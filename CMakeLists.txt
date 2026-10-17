cmake_minimum_required(VERSION 3.20)
project(clkernels CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

option(CLK_WERROR "Treat host-code warnings as errors" OFF)
option(CLK_FETCH_OPENCL "Fetch the Khronos headers and ICD loader if no OpenCL SDK is found" ON)
option(CLK_CLBLAST "Build the CLBlast reference kernel if CLBlast is found" ON)
set(CLK_TEST_DEVICE "" CACHE STRING "Device name substring for ctest (empty: first device found)")

if(MSVC)
  set(CLK_WARNINGS /W4 /permissive-)
  if(CLK_WERROR)
    list(APPEND CLK_WARNINGS /WX)
  endif()
else()
  set(CLK_WARNINGS -Wall -Wextra -Wpedantic)
  if(CLK_WERROR)
    list(APPEND CLK_WARNINGS -Werror)
  endif()
endif()

# --- OpenCL: headers, C++ bindings and the ICD loader ----------------------------------------
# The vcpkg `opencl` port, Linux packages (ocl-icd-opencl-dev, opencl-headers, opencl-clhpp-headers)
# or the Khronos OpenCL-SDK all satisfy find_package(OpenCL). Without any of them, fetch the three
# Khronos repositories and build the loader, which finds the installed drivers at runtime.
find_package(OpenCL QUIET)
find_path(CLK_CLHPP_DIR CL/opencl.hpp HINTS ${OpenCL_INCLUDE_DIRS})
if((NOT OpenCL_FOUND OR NOT CLK_CLHPP_DIR) AND CLK_FETCH_OPENCL)
  include(FetchContent)
  set(CLK_KHRONOS_TAG v2025.07.22)
  if(NOT CLK_CLHPP_DIR)
    # The C++ bindings are a single header; SOURCE_SUBDIR points at a directory without a
    # CMakeLists.txt so the repository is downloaded but its tests are not configured.
    FetchContent_Declare(opencl_clhpp GIT_REPOSITORY https://github.com/KhronosGroup/OpenCL-CLHPP.git
                         GIT_TAG ${CLK_KHRONOS_TAG} GIT_SHALLOW TRUE SOURCE_SUBDIR include)
    FetchContent_MakeAvailable(opencl_clhpp)
    set(CLK_CLHPP_DIR "${opencl_clhpp_SOURCE_DIR}/include" CACHE PATH "" FORCE)
  endif()
  if(NOT OpenCL_FOUND)
    FetchContent_Declare(opencl_headers GIT_REPOSITORY https://github.com/KhronosGroup/OpenCL-Headers.git
                         GIT_TAG ${CLK_KHRONOS_TAG} GIT_SHALLOW TRUE)
    FetchContent_Declare(opencl_icd_loader
                         GIT_REPOSITORY https://github.com/KhronosGroup/OpenCL-ICD-Loader.git
                         GIT_TAG ${CLK_KHRONOS_TAG} GIT_SHALLOW TRUE)
    set(OPENCL_ICD_LOADER_BUILD_TESTING OFF CACHE BOOL "" FORCE)
    set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(opencl_headers opencl_icd_loader)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})  # OpenCL.dll next to the executables
    set_target_properties(OpenCL PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
  endif()
endif()
if(NOT TARGET OpenCL::OpenCL OR NOT CLK_CLHPP_DIR)
  message(FATAL_ERROR "OpenCL headers, CL/opencl.hpp and the ICD loader are required (see README)")
endif()

add_library(clk src/env.cpp src/gemm.cpp src/softmax.cpp src/reference.cpp)
target_include_directories(clk PUBLIC include ${CLK_CLHPP_DIR})
target_link_libraries(clk PUBLIC OpenCL::OpenCL)
target_compile_options(clk PRIVATE ${CLK_WARNINGS})
target_compile_definitions(clk PUBLIC
  CL_HPP_TARGET_OPENCL_VERSION=300
  CL_HPP_MINIMUM_OPENCL_VERSION=120
  CL_HPP_ENABLE_EXCEPTIONS
  CL_TARGET_OPENCL_VERSION=300
  CLK_KERNEL_DIR="${CMAKE_SOURCE_DIR}/kernels")
if(MSVC)
  target_compile_definitions(clk PUBLIC _CRT_SECURE_NO_WARNINGS NOMINMAX)
endif()

# --- CLBlast (optional reference ceiling) -------------------------------------------------------
if(CLK_CLBLAST)
  find_package(CLBlast QUIET CONFIG)
  if(CLBlast_FOUND)
    message(STATUS "CLBlast found: building the clblast reference kernel")
    target_sources(clk PRIVATE src/clblast.cpp)
    target_compile_definitions(clk PRIVATE CLK_HAVE_CLBLAST)
    target_link_libraries(clk PRIVATE clblast)
  else()
    message(STATUS "CLBlast not found: the clblast reference kernel is not built")
  endif()
endif()

add_executable(bench bench/main.cpp)
target_compile_options(bench PRIVATE ${CLK_WARNINGS})
target_link_libraries(bench PRIVATE clk)
if(WIN32 AND CLBlast_FOUND)  # Windows finds DLLs next to the executable
  add_custom_command(TARGET bench POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different
                     $<TARGET_FILE:clblast> $<TARGET_FILE_DIR:bench>)
endif()

enable_testing()
add_executable(test_kernels tests/test_kernels.cpp)
target_compile_options(test_kernels PRIVATE ${CLK_WARNINGS})
target_link_libraries(test_kernels PRIVATE clk)
add_test(NAME kernels COMMAND test_kernels "${CLK_TEST_DEVICE}")
