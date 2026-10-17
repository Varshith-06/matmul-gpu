| Step | Busy clock samples | Median (MHz) | Min | Max | Single-issue peak at median (GFLOPS) |
|---|---:|---:|---:|---:|---:|
| tuning | 494 | 2276 | 933 | 2723 | 3,496 |
| ownership | 64 | 1773 | 931 | 1894 | 2,723 |
| ladder | 13 | 1789 | 1034 | 1857 | 2,748 |
| rocblas | 74 | 1877 | 937 | 1981 | 2,883 |
| monitorcheck | 8 | 1710 | 1028 | 1860 | 2,626 |
| wave64/tuning | 620 | 1858 | 1014 | 2527 | 2,855 |
| wave64/ladder | 9 | 1797 | 1747 | 1997 | 2,760 |
| repeat/tuning | 805 | 1870 | 959 | 2333 | 2,872 |
| repeat/ladder | 11 | 1718 | 1677 | 2289 | 2,639 |
| opencl_gfx1103/ownership | 73 | 1798 | 950 | 2245 | 2,762 |
| h2h/h2h | 162 | 1768 | 925 | 2361 | 2,715 |
| h2h_ladder/h2h | 141 | 1764 | 926 | 2354 | 2,710 |

Short probes (after 0.5 s of load): fma: 1988 MHz, gemm_reg 128x128 k16 8x8: 1807 MHz, idle: 807 MHz

hip_bandwidth:

| kernel | mbytes | median_ms | gbps | warp_size |
|---|---|---|---|---|
| copy | 4 | 0.1256 | 66.8 | 32 |
| copy | 16 | 0.573 | 58.6 | 32 |
| copy | 64 | 2.2503 | 59.6 | 32 |
| copy | 256 | 9.9554 | 53.9 | 32 |
| copy | 1024 | 37.6277 | 57.1 | 32 |

hip_fma:

| kernel | chains | median_ms | gflops | warp_size |
|---|---|---|---|---|
| fma_sgpr | 8 | 16.2705 | 1583.8 | 32 |
| fma_vgpr | 8 | 8.7831 | 2934 | 32 |
| fma_vgpr | 16 | 17.5757 | 2932.4 | 32 |

h2h (interleaved rounds):

| contender | n | rounds | median | min | max | median_ms |
|---|---|---|---|---|---|---|
| OpenCL gemm_reg (AMD Windows driver) | 2048 | 5 | 1677.2 | 1651.1 | 1737.8 | 10.2 |
| OpenCL gemm_reg (AMD Windows driver) | 4096 | 5 | 1564.9 | 1556.8 | 1682.8 | 87.8 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 2048 | 5 | 1618.9 | 1487.1 | 1634.5 | 10.6 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 4096 | 5 | 1511.4 | 1451.3 | 1557.1 | 90.9 |
| HIP gemm_reg, wave64 | 2048 | 5 | 1516.4 | 1495.2 | 1566 | 11.3 |
| HIP gemm_reg, wave64 | 4096 | 5 | 1449.8 | 1382.1 | 1468.2 | 94.8 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 2048 | 5 | 1776.8 | 1723.7 | 1847.8 | 9.7 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 4096 | 5 | 2274.7 | 2137.8 | 2382.7 | 60.4 |

h2h_ladder (interleaved rounds):

| contender | n | rounds | median | min | max | median_ms |
|---|---|---|---|---|---|---|
| OpenCL gemm_reg (AMD Windows driver) | 256 | 3 | 190.6 | 185.8 | 191.7 | 0.2 |
| OpenCL gemm_reg (AMD Windows driver) | 512 | 3 | 706.3 | 643.3 | 745.4 | 0.4 |
| OpenCL gemm_reg (AMD Windows driver) | 1024 | 3 | 857.2 | 856.8 | 871.2 | 2.5 |
| OpenCL gemm_reg (AMD Windows driver) | 2048 | 3 | 1563.7 | 1555.7 | 1706.5 | 11 |
| OpenCL gemm_reg (AMD Windows driver) | 3072 | 3 | 1144.6 | 1135.3 | 1558.1 | 50.7 |
| OpenCL gemm_reg (AMD Windows driver) | 4096 | 3 | 1450.7 | 1199.3 | 1485.1 | 94.7 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 256 | 3 | 148.4 | 146.6 | 155.4 | 0.2 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 512 | 3 | 596.8 | 593.4 | 599.4 | 0.4 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 1024 | 3 | 823.4 | 819.6 | 857.9 | 2.6 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 2048 | 3 | 1483.6 | 1453.7 | 1566 | 11.6 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 3072 | 3 | 1579.9 | 1456.8 | 1596.8 | 36.7 |
| HIP gemm_reg, wave32 (ROCm 7.2.4 on WSL) | 4096 | 3 | 1468.8 | 1393.5 | 1524.4 | 93.6 |
| HIP gemm_reg, wave64 | 256 | 3 | 135.9 | 135.3 | 153.1 | 0.2 |
| HIP gemm_reg, wave64 | 512 | 3 | 549.8 | 548.9 | 549.9 | 0.5 |
| HIP gemm_reg, wave64 | 1024 | 3 | 790.8 | 764.7 | 805.4 | 2.7 |
| HIP gemm_reg, wave64 | 2048 | 3 | 1488.8 | 1416.7 | 1586.5 | 11.5 |
| HIP gemm_reg, wave64 | 3072 | 3 | 1517.3 | 1414 | 1532.4 | 38.2 |
| HIP gemm_reg, wave64 | 4096 | 3 | 1384.2 | 1343 | 1461.2 | 99.3 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 256 | 3 | 228.8 | 228.7 | 240.1 | 0.1 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 512 | 3 | 492 | 490.6 | 494.4 | 0.5 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 1024 | 3 | 1095 | 1088 | 1119.8 | 2 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 2048 | 3 | 1718.8 | 1689.6 | 1752.8 | 10 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 3072 | 3 | 2265.2 | 2041 | 2286.3 | 25.6 |
| rocBLAS, gfx1100 kernels via HSA_OVERRIDE (unofficial) | 4096 | 3 | 2200.3 | 2064.3 | 2423.2 | 62.5 |

Host CPU time during a run (host_cpu.csv):

| api | config | n | reps | wall_s | user_s | sys_s |
|---|---|---|---|---|---|---|
| opencl | 128x128 k16 8x8 | 4096 | 40 | 3.8 | 0.31 | 0.19 |
| hip-wsl | 128x128 k16 8x8 | 4096 | 40 | 4.57 | 15.55 | 0.27 |
| opencl | 128x128 k16 8x8 | 4096 | 40 | 3.83 | 0.27 | 0.27 |
| hip-wsl | 128x128 k16 8x8 | 4096 | 40 | 4.2 | 15.4 | 0.2 |

opencl_cpu_idle: 1823, 1818, 1766 GFLOPS (median 1818)

opencl_cpu_4spin: 1615, 1652, 1636 GFLOPS (median 1636)

Monitor check (128x128 k16 8x8, N = 4096): without 1514, 1568, 1564 GFLOPS; with 1470, 1501, 1510
