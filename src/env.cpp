#include "clkernels/env.hpp"

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <iterator>
#include <regex>
#include <sstream>
#include <stdexcept>
#include <vector>

namespace clk {

namespace {

std::string kernel_dir() {
  // An environment variable lets a moved build tree find the kernels.
  if (const char* d = std::getenv("CLK_KERNEL_DIR")) return d;
  return CLK_KERNEL_DIR;
}

}  // namespace

cl::Device pick_device(const std::string& want) {
  std::vector<cl::Platform> platforms;
  cl::Platform::get(&platforms);
  for (auto& p : platforms) {
    std::vector<cl::Device> devs;
    try {
      p.getDevices(CL_DEVICE_TYPE_ALL, &devs);
    } catch (const cl::Error&) {
      continue;  // a platform with no devices throws CL_DEVICE_NOT_FOUND
    }
    for (auto& d : devs)
      if (want.empty() || d.getInfo<CL_DEVICE_NAME>().find(want) != std::string::npos) return d;
  }
  throw std::runtime_error("no OpenCL device matching '" + want + "' (try bench --devices)");
}

void list_devices(std::ostream& out) {
  std::vector<cl::Platform> platforms;
  cl::Platform::get(&platforms);
  for (auto& p : platforms) {
    out << "Platform: " << p.getInfo<CL_PLATFORM_NAME>() << " (" << p.getInfo<CL_PLATFORM_VERSION>()
        << ")\n";
    std::vector<cl::Device> devs;
    try {
      p.getDevices(CL_DEVICE_TYPE_ALL, &devs);
    } catch (const cl::Error&) {
      out << "  (no devices)\n";
      continue;
    }
    for (auto& d : devs) {
      out << "  Device: " << d.getInfo<CL_DEVICE_NAME>() << '\n'
          << "    compute units      " << d.getInfo<CL_DEVICE_MAX_COMPUTE_UNITS>() << '\n'
          << "    max clock          " << d.getInfo<CL_DEVICE_MAX_CLOCK_FREQUENCY>() << " MHz\n"
          << "    local memory       " << d.getInfo<CL_DEVICE_LOCAL_MEM_SIZE>() / 1024 << " KB\n"
          << "    max work-group     " << d.getInfo<CL_DEVICE_MAX_WORK_GROUP_SIZE>() << '\n'
          << "    global memory      " << d.getInfo<CL_DEVICE_GLOBAL_MEM_SIZE>() / (1024 * 1024)
          << " MB\n"
          << "    global mem cache   " << d.getInfo<CL_DEVICE_GLOBAL_MEM_CACHE_SIZE>() / 1024
          << " KB\n"
          << "    OpenCL C           " << d.getInfo<CL_DEVICE_OPENCL_C_VERSION>() << '\n'
          << "    driver             " << d.getInfo<CL_DRIVER_VERSION>() << '\n';
    }
  }
}

const char* error_name(cl_int code) {
  switch (code) {
#define CLK_E(x) \
  case x:        \
    return #x;
    CLK_E(CL_SUCCESS)
    CLK_E(CL_DEVICE_NOT_FOUND)
    CLK_E(CL_DEVICE_NOT_AVAILABLE)
    CLK_E(CL_COMPILER_NOT_AVAILABLE)
    CLK_E(CL_MEM_OBJECT_ALLOCATION_FAILURE)
    CLK_E(CL_OUT_OF_RESOURCES)
    CLK_E(CL_OUT_OF_HOST_MEMORY)
    CLK_E(CL_PROFILING_INFO_NOT_AVAILABLE)
    CLK_E(CL_BUILD_PROGRAM_FAILURE)
    CLK_E(CL_MAP_FAILURE)
    CLK_E(CL_MISALIGNED_SUB_BUFFER_OFFSET)
    CLK_E(CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST)
    CLK_E(CL_INVALID_VALUE)
    CLK_E(CL_INVALID_DEVICE_TYPE)
    CLK_E(CL_INVALID_PLATFORM)
    CLK_E(CL_INVALID_DEVICE)
    CLK_E(CL_INVALID_CONTEXT)
    CLK_E(CL_INVALID_QUEUE_PROPERTIES)
    CLK_E(CL_INVALID_COMMAND_QUEUE)
    CLK_E(CL_INVALID_HOST_PTR)
    CLK_E(CL_INVALID_MEM_OBJECT)
    CLK_E(CL_INVALID_BINARY)
    CLK_E(CL_INVALID_BUILD_OPTIONS)
    CLK_E(CL_INVALID_PROGRAM)
    CLK_E(CL_INVALID_PROGRAM_EXECUTABLE)
    CLK_E(CL_INVALID_KERNEL_NAME)
    CLK_E(CL_INVALID_KERNEL_DEFINITION)
    CLK_E(CL_INVALID_KERNEL)
    CLK_E(CL_INVALID_ARG_INDEX)
    CLK_E(CL_INVALID_ARG_VALUE)
    CLK_E(CL_INVALID_ARG_SIZE)
    CLK_E(CL_INVALID_KERNEL_ARGS)
    CLK_E(CL_INVALID_WORK_DIMENSION)
    CLK_E(CL_INVALID_WORK_GROUP_SIZE)
    CLK_E(CL_INVALID_WORK_ITEM_SIZE)
    CLK_E(CL_INVALID_GLOBAL_OFFSET)
    CLK_E(CL_INVALID_EVENT_WAIT_LIST)
    CLK_E(CL_INVALID_EVENT)
    CLK_E(CL_INVALID_OPERATION)
    CLK_E(CL_INVALID_BUFFER_SIZE)
    CLK_E(CL_INVALID_GLOBAL_WORK_SIZE)
#undef CLK_E
    default:
      return "unknown OpenCL error";
  }
}

std::string describe(const cl::Error& e) {
  std::ostringstream s;
  s << e.what() << " failed: " << error_name(e.err()) << " (" << e.err() << ")";
  return s.str();
}

int define_value(const std::string& opts, const std::string& name, int fallback) {
  const std::regex re("-D\\s*" + name + "=(-?[0-9]+)");
  std::smatch m;
  return std::regex_search(opts, m, re) ? std::stoi(m[1]) : fallback;
}

Env::Env(const std::string& name)
    : dev(pick_device(name)), ctx(dev), q(ctx, dev, CL_QUEUE_PROFILING_ENABLE) {}

bool Env::is_nvidia() const {
  return dev.getInfo<CL_DEVICE_VENDOR>().find("NVIDIA") != std::string::npos;
}

const Built& Env::build(const std::string& file, const std::string& opts) {
  const auto key = std::make_pair(file, opts);
  if (auto it = cache_.find(key); it != cache_.end()) return it->second;

  const std::string path = kernel_dir() + "/" + file;
  std::ifstream in(path);
  if (!in) throw std::runtime_error("cannot read kernel source " + path);
  const std::string src((std::istreambuf_iterator<char>(in)), std::istreambuf_iterator<char>());

  cl::Program prog(ctx, src);
  std::string all = "-cl-std=CL1.2 " + opts;
  if (!common_opts.empty()) all += " " + common_opts;
  try {
    prog.build({dev}, all.c_str());
  } catch (const cl::BuildError& err) {
    std::cerr << "build of " << file << " with '" << all << "' failed:\n";
    for (const auto& entry : err.getBuildLog()) std::cerr << entry.second << '\n';
    throw;
  }
  Built b{prog, prog.getBuildInfo<CL_PROGRAM_BUILD_LOG>(dev)};
  return cache_.emplace(key, std::move(b)).first->second;
}

double event_ms(const cl::Event& ev) {
  const cl_ulong t0 = ev.getProfilingInfo<CL_PROFILING_COMMAND_START>();
  const cl_ulong t1 = ev.getProfilingInfo<CL_PROFILING_COMMAND_END>();
  return static_cast<double>(t1 - t0) * 1e-6;  // nanoseconds -> ms
}

double launch_ms(Env& e, const cl::Kernel& k, const cl::NDRange& global, const cl::NDRange& local) {
  cl::Event ev;
  e.q.enqueueNDRangeKernel(k, cl::NullRange, global, local, nullptr, &ev);
  ev.wait();
  return event_ms(ev);
}

PtxasInfo ptxas_info(const std::string& log, const std::string& kernel) {
  // Per kernel, ptxas prints:
  //   ptxas info    : Function properties for gemm_reg
  //   ptxas         .     0 bytes stack frame, 0 bytes spill stores, 0 bytes spill loads
  //   ptxas info    : Used 56 registers, used 1 barriers, ...
  PtxasInfo info;
  std::smatch m;
  if (!std::regex_search(log, m, std::regex("Function properties for " + kernel + "\\b")))
    return info;
  const auto from = m[0].second;
  if (std::regex_search(from, log.end(), m,
                        std::regex("([0-9]+) bytes spill stores, ([0-9]+) bytes spill loads")))
    info.spill_bytes = std::stoi(m[1]) + std::stoi(m[2]);
  if (std::regex_search(from, log.end(), m, std::regex("Used ([0-9]+) registers")))
    info.registers = std::stoi(m[1]);
  return info;
}

std::string program_binary(const cl::Program& p) {
  const auto bins = p.getInfo<CL_PROGRAM_BINARIES>();
  if (bins.empty()) return {};
  return std::string(bins[0].begin(), bins[0].end());
}

}  // namespace clk
