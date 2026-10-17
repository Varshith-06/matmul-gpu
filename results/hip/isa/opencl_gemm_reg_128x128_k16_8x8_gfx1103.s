0000000000003c00 <gemm_reg>:
	s_clause 0x2                                               // 000000003C00: BF850002
	s_load_b32 s16, s[0:1], null                               // 000000003C04: F4000400 F8000000
	s_load_b128 s[12:15], s[0:1], 0x8                          // 000000003C0C: F4080300 F8000008
	s_load_b64 s[10:11], s[0:1], 0x18                          // 000000003C14: F4040280 F8000018
	v_and_b32_e32 v55, 0x3ff, v0                               // 000000003C1C: 366E00FF 000003FF
	v_bfe_u32 v56, v0, 10, 10                                  // 000000003C24: D6100038 02291500
	s_lshl_b32 s17, s3, 7                                      // 000000003C2C: 84118703
	s_lshl_b32 s18, s2, 7                                      // 000000003C30: 84128702
	s_waitcnt lgkmcnt(0)                                       // 000000003C34: BF89FC07
	s_cmp_lt_i32 s16, 1                                        // 000000003C38: BF048110
	s_cbranch_scc1 664                                         // 000000003C3C: BFA20298 <gemm_reg+0xaa0>
	v_lshl_add_u32 v0, v56, 4, v55                             // 000000003C40: D6460000 04DD0938
	v_dual_mov_b32 v18, 0 :: v_dual_and_b32 v67, 15, v55       // 000000003C48: CA240080 12426E8F
	v_lshl_or_b32 v100, v55, 2, 0x2000                         // 000000003C50: D6560064 03FD0537 00002000
	v_dual_mov_b32 v50, 0 :: v_dual_lshlrev_b32 v101, 6, v56   // 000000003C5C: CA220080 32647086
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_4) | instid1(VALU_DEP_4)// 000000003C64: BF870254
	v_lshrrev_b32_e32 v1, 4, v0                                // 000000003C68: 32020084
	v_dual_mov_b32 v17, 0 :: v_dual_add_nc_u32 v2, 0x100, v0   // 000000003C6C: CA200080 110200FF 00000100
	v_dual_mov_b32 v20, 0 :: v_dual_lshlrev_b32 v3, 2, v67     // 000000003C78: CA220080 14028682
	v_dual_mov_b32 v19, 0 :: v_dual_add_nc_u32 v4, 0x200, v0   // 000000003C80: CA200080 130400FF 00000200
	v_dual_mov_b32 v22, 0 :: v_dual_add_nc_u32 v5, 0x300, v0   // 000000003C8C: CA200080 160400FF 00000300
	v_lshrrev_b32_e32 v7, 4, v2                                // 000000003C98: 320E0484
	v_dual_mov_b32 v23, 0 :: v_dual_add_nc_u32 v8, s17, v1     // 000000003C9C: CA200080 17080211
	s_delay_alu instid0(VALU_DEP_4)                            // 000000003CA4: BF870004
	v_lshrrev_b32_e32 v9, 4, v4                                // 000000003CA8: 32120884
	v_lshl_or_b32 v68, v1, 6, v3                               // 000000003CAC: D6560044 040D0D01
	v_lshrrev_b32_e32 v1, 4, v5                                // 000000003CB4: 32020A84
	v_dual_mov_b32 v21, 0 :: v_dual_add_nc_u32 v6, 0x400, v0   // 000000003CB8: CA200080 150600FF 00000400
	v_dual_mov_b32 v25, 0 :: v_dual_add_nc_u32 v10, s17, v7    // 000000003CC4: CA200080 190A0E11
	v_dual_mov_b32 v24, 0 :: v_dual_add_nc_u32 v11, s17, v9    // 000000003CCC: CA200080 180A1211
	v_lshl_or_b32 v70, v7, 6, v3                               // 000000003CD4: D6560046 040D0D07
	v_dual_mov_b32 v26, 0 :: v_dual_add_nc_u32 v7, s17, v1     // 000000003CDC: CA200080 1A060211
	v_lshl_or_b32 v73, v9, 6, v3                               // 000000003CE4: D6560049 040D0D09
	v_dual_mov_b32 v28, 0 :: v_dual_add_nc_u32 v9, 0x500, v0   // 000000003CEC: CA200080 1C0800FF 00000500
	v_cmp_gt_i32_e32 vcc_lo, s16, v8                           // 000000003CF8: 7C881010
	v_mul_lo_u32 v69, v8, s16                                  // 000000003CFC: D72C0045 00002108
	v_cmp_gt_i32_e64 s1, s16, v11                              // 000000003D04: D4440001 00021610
	v_lshrrev_b32_e32 v8, 4, v6                                // 000000003D0C: 32100C84
	v_mul_lo_u32 v72, v11, s16                                 // 000000003D10: D72C0048 0000210B
	v_cmp_gt_i32_e64 s2, s16, v7                               // 000000003D18: D4440002 00020E10
	v_mul_lo_u32 v74, v7, s16                                  // 000000003D20: D72C004A 00002107
	v_dual_mov_b32 v30, 0 :: v_dual_add_nc_u32 v7, 0x600, v0   // 000000003D28: CA200080 1E0600FF 00000600
	v_lshrrev_b32_e32 v11, 4, v9                               // 000000003D34: 32161284
	v_cmp_gt_i32_e64 s0, s16, v10                              // 000000003D38: D4440000 00021410
	v_mul_lo_u32 v71, v10, s16                                 // 000000003D40: D72C0047 0000210A
	v_dual_mov_b32 v27, 0 :: v_dual_add_nc_u32 v10, s17, v8    // 000000003D48: CA200080 1B0A1011
	v_lshrrev_b32_e32 v12, 4, v7                               // 000000003D50: 32180E84
	v_dual_mov_b32 v34, 0 :: v_dual_add_nc_u32 v13, s17, v11   // 000000003D54: CA200080 220C1611
	v_lshl_or_b32 v75, v1, 6, v3                               // 000000003D5C: D656004B 040D0D01
	s_delay_alu instid0(VALU_DEP_4)                            // 000000003D64: BF870004
	v_cmp_gt_i32_e64 s3, s16, v10                              // 000000003D68: D4440003 00021410
	v_dual_mov_b32 v32, 0 :: v_dual_add_nc_u32 v1, 0x700, v0   // 000000003D70: CA200080 200000FF 00000700
	v_mul_lo_u32 v76, v10, s16                                 // 000000003D7C: D72C004C 0000210A
	v_dual_mov_b32 v29, 0 :: v_dual_add_nc_u32 v10, s17, v12   // 000000003D84: CA200080 1D0A1811
	v_cmp_gt_i32_e64 s4, s16, v13                              // 000000003D8C: D4440004 00021A10
	v_mul_lo_u32 v78, v13, s16                                 // 000000003D94: D72C004E 0000210D
	v_dual_mov_b32 v38, 0 :: v_dual_and_b32 v13, 0x7f, v0      // 000000003D9C: CA240080 260C00FF 0000007F
	v_lshl_or_b32 v77, v8, 6, v3                               // 000000003DA8: D656004D 040D0D08
	v_lshrrev_b32_e32 v8, 4, v1                                // 000000003DB0: 32100284
	v_cmp_gt_i32_e64 s5, s16, v10                              // 000000003DB4: D4440005 00021410
	v_mul_lo_u32 v80, v10, s16                                 // 000000003DBC: D72C0050 0000210A
	v_lshrrev_b32_e32 v82, 7, v0                               // 000000003DC4: 32A40087
	v_dual_mov_b32 v31, 0 :: v_dual_lshlrev_b32 v10, 2, v13    // 000000003DC8: CA220080 1F0A1A82
	v_lshrrev_b32_e32 v83, 7, v2                               // 000000003DD0: 32A60487
	v_lshl_or_b32 v79, v11, 6, v3                              // 000000003DD4: D656004F 040D0D0B
	v_dual_mov_b32 v36, 0 :: v_dual_add_nc_u32 v11, s17, v8    // 000000003DDC: CA200080 240A1011
	v_lshrrev_b32_e32 v84, 7, v4                               // 000000003DE4: 32A80887
	v_lshl_or_b32 v2, v82, 9, v10                              // 000000003DE8: D6560002 04291352
	v_lshl_or_b32 v4, v83, 9, v10                              // 000000003DF0: D6560004 04291353
	v_lshrrev_b32_e32 v90, 7, v5                               // 000000003DF8: 32B40A87
	v_lshrrev_b32_e32 v91, 7, v6                               // 000000003DFC: 32B60C87
	v_lshrrev_b32_e32 v92, 7, v9                               // 000000003E00: 32B81287
	v_lshrrev_b32_e32 v93, 7, v7                               // 000000003E04: 32BA0E87
	v_lshrrev_b32_e32 v94, 7, v1                               // 000000003E08: 32BC0287
	v_lshl_or_b32 v81, v12, 6, v3                              // 000000003E0C: D6560051 040D0D0C
	v_cmp_gt_i32_e64 s6, s16, v11                              // 000000003E14: D4440006 00021610
	v_mul_lo_u32 v85, v11, s16                                 // 000000003E1C: D72C0055 0000210B
	v_or_b32_e32 v0, s18, v13                                  // 000000003E24: 38001A12
	v_lshl_or_b32 v11, v84, 9, v10                             // 000000003E28: D656000B 04291354
	v_lshl_or_b32 v86, v8, 6, v3                               // 000000003E30: D6560056 040D0D08
	v_dual_mov_b32 v40, 0 :: v_dual_add_nc_u32 v87, 0x2000, v2 // 000000003E38: CA200080 285604FF 00002000
	v_dual_mov_b32 v33, 0 :: v_dual_add_nc_u32 v88, 0x2000, v4 // 000000003E44: CA200080 215808FF 00002000
	v_lshl_or_b32 v1, v90, 9, v10                              // 000000003E50: D6560001 0429135A
	v_lshl_or_b32 v2, v91, 9, v10                              // 000000003E58: D6560002 0429135B
	v_lshl_or_b32 v3, v92, 9, v10                              // 000000003E60: D6560003 0429135C
	v_lshl_or_b32 v4, v93, 9, v10                              // 000000003E68: D6560004 0429135D
	v_lshl_or_b32 v5, v94, 9, v10                              // 000000003E70: D6560005 0429135E
	v_cmp_gt_i32_e64 s7, s16, v0                               // 000000003E78: D4440007 00020010
	v_dual_mov_b32 v42, 0 :: v_dual_add_nc_u32 v89, 0x2000, v11// 000000003E80: CA200080 2A5816FF 00002000
	v_dual_mov_b32 v44, 0 :: v_dual_add_nc_u32 v95, 0x2000, v1 // 000000003E8C: CA200080 2C5E02FF 00002000
	v_dual_mov_b32 v35, 0 :: v_dual_add_nc_u32 v96, 0x2000, v2 // 000000003E98: CA200080 236004FF 00002000
	v_dual_mov_b32 v46, 0 :: v_dual_add_nc_u32 v97, 0x2000, v3 // 000000003EA4: CA200080 2E6006FF 00002000
	v_dual_mov_b32 v37, 0 :: v_dual_add_nc_u32 v98, 0x2000, v4 // 000000003EB0: CA200080 256208FF 00002000
	v_dual_mov_b32 v48, 0 :: v_dual_add_nc_u32 v99, 0x2000, v5 // 000000003EBC: CA200080 30620AFF 00002000
	v_dual_mov_b32 v39, 0 :: v_dual_mov_b32 v52, 0             // 000000003EC8: CA100080 27340080
	v_dual_mov_b32 v41, 0 :: v_dual_mov_b32 v54, 0             // 000000003ED0: CA100080 29360080
	v_dual_mov_b32 v43, 0 :: v_dual_mov_b32 v58, 0             // 000000003ED8: CA100080 2B3A0080
	v_dual_mov_b32 v45, 0 :: v_dual_mov_b32 v60, 0             // 000000003EE0: CA100080 2D3C0080
	v_dual_mov_b32 v47, 0 :: v_dual_mov_b32 v62, 0             // 000000003EE8: CA100080 2F3E0080
	v_dual_mov_b32 v49, 0 :: v_dual_mov_b32 v64, 0             // 000000003EF0: CA100080 31400080
	v_dual_mov_b32 v51, 0 :: v_dual_mov_b32 v66, 0             // 000000003EF8: CA100080 33420080
	v_dual_mov_b32 v53, 0 :: v_dual_mov_b32 v16, 0             // 000000003F00: CA100080 35100080
	v_dual_mov_b32 v57, 0 :: v_dual_mov_b32 v14, 0             // 000000003F08: CA100080 390E0080
	v_dual_mov_b32 v59, 0 :: v_dual_mov_b32 v12, 0             // 000000003F10: CA100080 3B0C0080
	v_dual_mov_b32 v61, 0 :: v_dual_mov_b32 v10, 0             // 000000003F18: CA100080 3D0A0080
	v_dual_mov_b32 v63, 0 :: v_dual_mov_b32 v8, 0              // 000000003F20: CA100080 3F080080
	v_dual_mov_b32 v65, 0 :: v_dual_mov_b32 v6, 0              // 000000003F28: CA100080 41060080
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v4, 0              // 000000003F30: CA100080 0F040080
	v_dual_mov_b32 v13, 0 :: v_dual_mov_b32 v2, 0              // 000000003F38: CA100080 0D020080
	v_mov_b32_e32 v11, 0                                       // 000000003F40: 7E160280
	v_mov_b32_e32 v9, 0                                        // 000000003F44: 7E120280
	v_mov_b32_e32 v7, 0                                        // 000000003F48: 7E0E0280
	v_mov_b32_e32 v5, 0                                        // 000000003F4C: 7E0A0280
	v_mov_b32_e32 v3, 0                                        // 000000003F50: 7E060280
	v_mov_b32_e32 v1, 0                                        // 000000003F54: 7E020280
	s_mov_b32 s19, 0                                           // 000000003F58: BE930080
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000003F5C: BF870129
	v_or_b32_e32 v102, s19, v67                                // 000000003F60: 38CC8613
	v_mov_b32_e32 v104, 0                                      // 000000003F64: 7ED00280
	v_cmp_gt_i32_e64 s8, s16, v102                             // 000000003F68: D4440008 0002CC10
	s_and_b32 s9, vcc_lo, s8                                   // 000000003F70: 8B09086A
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000003F74: BF870009
	s_and_saveexec_b32 s20, s9                                 // 000000003F78: BE942009
	s_cbranch_execz 12                                         // 000000003F7C: BFA5000C <gemm_reg+0x3b0>
	v_add_nc_u32_e32 v103, v102, v69                           // 000000003F80: 4ACE8B66
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000003F84: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 000000003F88: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 000000003F8C: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000003F94: BF870091
	v_add_co_u32 v103, s9, s12, v103                           // 000000003F98: D7000967 0002CE0C
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9              // 000000003FA0: D5207C68 0026D00D
	global_load_b32 v104, v[103:104], off                      // 000000003FA8: DC520000 687C0067
	s_or_b32 exec_lo, exec_lo, s20                             // 000000003FB0: 8C7E147E
	v_mov_b32_e32 v103, 0                                      // 000000003FB4: 7ECE0280
	v_mov_b32_e32 v105, 0                                      // 000000003FB8: 7ED20280
	s_and_b32 s9, s0, s8                                       // 000000003FBC: 8B090800
	s_waitcnt vmcnt(0)                                         // 000000003FC0: BF8903F7
	ds_store_b32 v68, v104                                     // 000000003FC4: D8340000 00006844
	s_and_saveexec_b32 s20, s9                                 // 000000003FCC: BE942009
	s_cbranch_execz 12                                         // 000000003FD0: BFA5000C <gemm_reg+0x404>
	v_add_nc_u32_e32 v104, v102, v71                           // 000000003FD4: 4AD08F66
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000003FD8: BF870091
	v_ashrrev_i32_e32 v105, 31, v104                           // 000000003FDC: 34D2D09F
	v_lshlrev_b64 v[104:105], 2, v[104:105]                    // 000000003FE0: D73C0068 0002D082
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000003FE8: BF870091
	v_add_co_u32 v104, s9, s12, v104                           // 000000003FEC: D7000968 0002D00C
	v_add_co_ci_u32_e64 v105, null, s13, v105, s9              // 000000003FF4: D5207C69 0026D20D
	global_load_b32 v105, v[104:105], off                      // 000000003FFC: DC520000 697C0068
	s_or_b32 exec_lo, exec_lo, s20                             // 000000004004: 8C7E147E
	s_and_b32 s9, s1, s8                                       // 000000004008: 8B090801
	s_waitcnt vmcnt(0)                                         // 00000000400C: BF8903F7
	ds_store_b32 v70, v105                                     // 000000004010: D8340000 00006946
	s_and_saveexec_b32 s20, s9                                 // 000000004018: BE942009
	s_cbranch_execz 12                                         // 00000000401C: BFA5000C <gemm_reg+0x450>
	v_add_nc_u32_e32 v103, v102, v72                           // 000000004020: 4ACE9166
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004024: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 000000004028: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 00000000402C: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004034: BF870091
	v_add_co_u32 v103, s9, s12, v103                           // 000000004038: D7000967 0002CE0C
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9              // 000000004040: D5207C68 0026D00D
	global_load_b32 v103, v[103:104], off                      // 000000004048: DC520000 677C0067
	s_or_b32 exec_lo, exec_lo, s20                             // 000000004050: 8C7E147E
	v_dual_mov_b32 v104, 0 :: v_dual_mov_b32 v105, 0           // 000000004054: CA100080 68680080
	s_and_b32 s9, s2, s8                                       // 00000000405C: 8B090802
	s_waitcnt vmcnt(0)                                         // 000000004060: BF8903F7
	ds_store_b32 v73, v103                                     // 000000004064: D8340000 00006749
	s_and_saveexec_b32 s20, s9                                 // 00000000406C: BE942009
	s_cbranch_execz 12                                         // 000000004070: BFA5000C <gemm_reg+0x4a4>
	v_add_nc_u32_e32 v105, v102, v74                           // 000000004074: 4AD29566
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004078: BF870091
	v_ashrrev_i32_e32 v106, 31, v105                           // 00000000407C: 34D4D29F
	v_lshlrev_b64 v[105:106], 2, v[105:106]                    // 000000004080: D73C0069 0002D282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004088: BF870091
	v_add_co_u32 v105, s9, s12, v105                           // 00000000408C: D7000969 0002D20C
	v_add_co_ci_u32_e64 v106, null, s13, v106, s9              // 000000004094: D5207C6A 0026D40D
	global_load_b32 v105, v[105:106], off                      // 00000000409C: DC520000 697C0069
	s_or_b32 exec_lo, exec_lo, s20                             // 0000000040A4: 8C7E147E
	s_and_b32 s9, s3, s8                                       // 0000000040A8: 8B090803
	s_waitcnt vmcnt(0)                                         // 0000000040AC: BF8903F7
	ds_store_b32 v75, v105                                     // 0000000040B0: D8340000 0000694B
	s_and_saveexec_b32 s20, s9                                 // 0000000040B8: BE942009
	s_cbranch_execz 12                                         // 0000000040BC: BFA5000C <gemm_reg+0x4f0>
	v_add_nc_u32_e32 v103, v102, v76                           // 0000000040C0: 4ACE9966
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000040C4: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 0000000040C8: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 0000000040CC: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000040D4: BF870091
	v_add_co_u32 v103, s9, s12, v103                           // 0000000040D8: D7000967 0002CE0C
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9              // 0000000040E0: D5207C68 0026D00D
	global_load_b32 v104, v[103:104], off                      // 0000000040E8: DC520000 687C0067
	s_or_b32 exec_lo, exec_lo, s20                             // 0000000040F0: 8C7E147E
	v_mov_b32_e32 v105, 0                                      // 0000000040F4: 7ED20280
	v_mov_b32_e32 v103, 0                                      // 0000000040F8: 7ECE0280
	s_and_b32 s9, s4, s8                                       // 0000000040FC: 8B090804
	s_waitcnt vmcnt(0)                                         // 000000004100: BF8903F7
	ds_store_b32 v77, v104                                     // 000000004104: D8340000 0000684D
	s_and_saveexec_b32 s20, s9                                 // 00000000410C: BE942009
	s_cbranch_execz 12                                         // 000000004110: BFA5000C <gemm_reg+0x544>
	v_add_nc_u32_e32 v103, v102, v78                           // 000000004114: 4ACE9D66
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004118: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 00000000411C: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 000000004120: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004128: BF870091
	v_add_co_u32 v103, s9, s12, v103                           // 00000000412C: D7000967 0002CE0C
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9              // 000000004134: D5207C68 0026D00D
	global_load_b32 v103, v[103:104], off                      // 00000000413C: DC520000 677C0067
	s_or_b32 exec_lo, exec_lo, s20                             // 000000004144: 8C7E147E
	s_and_b32 s9, s5, s8                                       // 000000004148: 8B090805
	s_waitcnt vmcnt(0)                                         // 00000000414C: BF8903F7
	ds_store_b32 v79, v103                                     // 000000004150: D8340000 0000674F
	s_and_saveexec_b32 s20, s9                                 // 000000004158: BE942009
	s_cbranch_execz 12                                         // 00000000415C: BFA5000C <gemm_reg+0x590>
	v_add_nc_u32_e32 v103, v102, v80                           // 000000004160: 4ACEA166
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004164: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 000000004168: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 00000000416C: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004174: BF870091
	v_add_co_u32 v103, s9, s12, v103                           // 000000004178: D7000967 0002CE0C
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9              // 000000004180: D5207C68 0026D00D
	global_load_b32 v105, v[103:104], off                      // 000000004188: DC520000 697C0067
	s_or_b32 exec_lo, exec_lo, s20                             // 000000004190: 8C7E147E
	v_dual_mov_b32 v103, 0 :: v_dual_mov_b32 v104, 0           // 000000004194: CA100080 67680080
	s_and_b32 s8, s6, s8                                       // 00000000419C: 8B080806
	s_waitcnt vmcnt(0)                                         // 0000000041A0: BF8903F7
	ds_store_b32 v81, v105                                     // 0000000041A4: D8340000 00006951
	s_and_saveexec_b32 s9, s8                                  // 0000000041AC: BE892008
	s_cbranch_execz 12                                         // 0000000041B0: BFA5000C <gemm_reg+0x5e4>
	v_add_nc_u32_e32 v104, v102, v85                           // 0000000041B4: 4AD0AB66
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000041B8: BF870091
	v_ashrrev_i32_e32 v105, 31, v104                           // 0000000041BC: 34D2D09F
	v_lshlrev_b64 v[104:105], 2, v[104:105]                    // 0000000041C0: D73C0068 0002D082
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000041C8: BF870091
	v_add_co_u32 v104, s8, s12, v104                           // 0000000041CC: D7000868 0002D00C
	v_add_co_ci_u32_e64 v105, null, s13, v105, s8              // 0000000041D4: D5207C69 0022D20D
	global_load_b32 v104, v[104:105], off                      // 0000000041DC: DC520000 687C0068
	s_or_b32 exec_lo, exec_lo, s9                              // 0000000041E4: 8C7E097E
	v_add_nc_u32_e32 v102, s19, v82                            // 0000000041E8: 4ACCA413
	s_waitcnt vmcnt(0)                                         // 0000000041EC: BF8903F7
	ds_store_b32 v86, v104                                     // 0000000041F0: D8340000 00006856
	v_cmp_gt_i32_e64 s8, s16, v102                             // 0000000041F8: D4440008 0002CC10
	s_and_b32 s8, s8, s7                                       // 000000004200: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004204: BF870009
	s_and_saveexec_b32 s9, s8                                  // 000000004208: BE892008
	s_cbranch_execz 13                                         // 00000000420C: BFA5000D <gemm_reg+0x644>
	v_mad_u64_u32 v[103:104], null, v102, s16, v[0:1]          // 000000004210: D6FE7C67 04002166
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004218: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 00000000421C: 34D0CE9F
	v_lshlrev_b64 v[102:103], 2, v[103:104]                    // 000000004220: D73C0066 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004228: BF870091
	v_add_co_u32 v102, s8, s14, v102                           // 00000000422C: D7000866 0002CC0E
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8              // 000000004234: D5207C67 0022CE0F
	global_load_b32 v103, v[102:103], off                      // 00000000423C: DC520000 677C0066
	s_or_b32 exec_lo, exec_lo, s9                              // 000000004244: 8C7E097E
	v_dual_mov_b32 v102, 0 :: v_dual_add_nc_u32 v105, s19, v83 // 000000004248: CA200080 6668A613
	v_mov_b32_e32 v104, 0                                      // 000000004250: 7ED00280
	s_waitcnt vmcnt(0)                                         // 000000004254: BF8903F7
	ds_store_b32 v87, v103                                     // 000000004258: D8340000 00006757
	v_cmp_gt_i32_e64 s8, s16, v105                             // 000000004260: D4440008 0002D210
	s_and_b32 s8, s8, s7                                       // 000000004268: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000426C: BF870009
	s_and_saveexec_b32 s9, s8                                  // 000000004270: BE892008
	s_cbranch_execz 13                                         // 000000004274: BFA5000D <gemm_reg+0x6ac>
	v_mad_u64_u32 v[103:104], null, v105, s16, v[0:1]          // 000000004278: D6FE7C67 04002169
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004280: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 000000004284: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 000000004288: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004290: BF870091
	v_add_co_u32 v103, s8, s14, v103                           // 000000004294: D7000867 0002CE0E
	v_add_co_ci_u32_e64 v104, null, s15, v104, s8              // 00000000429C: D5207C68 0022D00F
	global_load_b32 v104, v[103:104], off                      // 0000000042A4: DC520000 687C0067
	s_or_b32 exec_lo, exec_lo, s9                              // 0000000042AC: 8C7E097E
	v_add_nc_u32_e32 v103, s19, v84                            // 0000000042B0: 4ACEA813
	s_waitcnt vmcnt(0)                                         // 0000000042B4: BF8903F7
	ds_store_b32 v88, v104                                     // 0000000042B8: D8340000 00006858
	v_cmp_gt_i32_e64 s8, s16, v103                             // 0000000042C0: D4440008 0002CE10
	s_and_b32 s8, s8, s7                                       // 0000000042C8: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000042CC: BF870009
	s_and_saveexec_b32 s9, s8                                  // 0000000042D0: BE892008
	s_cbranch_execz 13                                         // 0000000042D4: BFA5000D <gemm_reg+0x70c>
	v_mad_u64_u32 v[104:105], null, v103, s16, v[0:1]          // 0000000042D8: D6FE7C68 04002167
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000042E0: BF870091
	v_ashrrev_i32_e32 v105, 31, v104                           // 0000000042E4: 34D2D09F
	v_lshlrev_b64 v[102:103], 2, v[104:105]                    // 0000000042E8: D73C0066 0002D082
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000042F0: BF870091
	v_add_co_u32 v102, s8, s14, v102                           // 0000000042F4: D7000866 0002CC0E
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8              // 0000000042FC: D5207C67 0022CE0F
	global_load_b32 v102, v[102:103], off                      // 000000004304: DC520000 667C0066
	s_or_b32 exec_lo, exec_lo, s9                              // 00000000430C: 8C7E097E
	v_dual_mov_b32 v104, 0 :: v_dual_add_nc_u32 v105, s19, v90 // 000000004310: CA200080 6868B413
	v_mov_b32_e32 v103, 0                                      // 000000004318: 7ECE0280
	s_waitcnt vmcnt(0)                                         // 00000000431C: BF8903F7
	ds_store_b32 v89, v102                                     // 000000004320: D8340000 00006659
	v_cmp_gt_i32_e64 s8, s16, v105                             // 000000004328: D4440008 0002D210
	s_and_b32 s8, s8, s7                                       // 000000004330: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004334: BF870009
	s_and_saveexec_b32 s9, s8                                  // 000000004338: BE892008
	s_cbranch_execz 13                                         // 00000000433C: BFA5000D <gemm_reg+0x774>
	v_mad_u64_u32 v[106:107], null, v105, s16, v[0:1]          // 000000004340: D6FE7C6A 04002169
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004348: BF870091
	v_ashrrev_i32_e32 v107, 31, v106                           // 00000000434C: 34D6D49F
	v_lshlrev_b64 v[104:105], 2, v[106:107]                    // 000000004350: D73C0068 0002D482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004358: BF870091
	v_add_co_u32 v104, s8, s14, v104                           // 00000000435C: D7000868 0002D00E
	v_add_co_ci_u32_e64 v105, null, s15, v105, s8              // 000000004364: D5207C69 0022D20F
	global_load_b32 v104, v[104:105], off                      // 00000000436C: DC520000 687C0068
	s_or_b32 exec_lo, exec_lo, s9                              // 000000004374: 8C7E097E
	v_add_nc_u32_e32 v102, s19, v91                            // 000000004378: 4ACCB613
	s_waitcnt vmcnt(0)                                         // 00000000437C: BF8903F7
	ds_store_b32 v95, v104                                     // 000000004380: D8340000 0000685F
	v_cmp_gt_i32_e64 s8, s16, v102                             // 000000004388: D4440008 0002CC10
	s_and_b32 s8, s8, s7                                       // 000000004390: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004394: BF870009
	s_and_saveexec_b32 s9, s8                                  // 000000004398: BE892008
	s_cbranch_execz 13                                         // 00000000439C: BFA5000D <gemm_reg+0x7d4>
	v_mad_u64_u32 v[103:104], null, v102, s16, v[0:1]          // 0000000043A0: D6FE7C67 04002166
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000043A8: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 0000000043AC: 34D0CE9F
	v_lshlrev_b64 v[102:103], 2, v[103:104]                    // 0000000043B0: D73C0066 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000043B8: BF870091
	v_add_co_u32 v102, s8, s14, v102                           // 0000000043BC: D7000866 0002CC0E
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8              // 0000000043C4: D5207C67 0022CE0F
	global_load_b32 v103, v[102:103], off                      // 0000000043CC: DC520000 677C0066
	s_or_b32 exec_lo, exec_lo, s9                              // 0000000043D4: 8C7E097E
	v_dual_mov_b32 v102, 0 :: v_dual_add_nc_u32 v105, s19, v92 // 0000000043D8: CA200080 6668B813
	v_mov_b32_e32 v104, 0                                      // 0000000043E0: 7ED00280
	s_waitcnt vmcnt(0)                                         // 0000000043E4: BF8903F7
	ds_store_b32 v96, v103                                     // 0000000043E8: D8340000 00006760
	v_cmp_gt_i32_e64 s8, s16, v105                             // 0000000043F0: D4440008 0002D210
	s_and_b32 s8, s8, s7                                       // 0000000043F8: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000043FC: BF870009
	s_and_saveexec_b32 s9, s8                                  // 000000004400: BE892008
	s_cbranch_execz 13                                         // 000000004404: BFA5000D <gemm_reg+0x83c>
	v_mad_u64_u32 v[103:104], null, v105, s16, v[0:1]          // 000000004408: D6FE7C67 04002169
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004410: BF870091
	v_ashrrev_i32_e32 v104, 31, v103                           // 000000004414: 34D0CE9F
	v_lshlrev_b64 v[103:104], 2, v[103:104]                    // 000000004418: D73C0067 0002CE82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004420: BF870091
	v_add_co_u32 v103, s8, s14, v103                           // 000000004424: D7000867 0002CE0E
	v_add_co_ci_u32_e64 v104, null, s15, v104, s8              // 00000000442C: D5207C68 0022D00F
	global_load_b32 v104, v[103:104], off                      // 000000004434: DC520000 687C0067
	s_or_b32 exec_lo, exec_lo, s9                              // 00000000443C: 8C7E097E
	v_add_nc_u32_e32 v103, s19, v93                            // 000000004440: 4ACEBA13
	s_waitcnt vmcnt(0)                                         // 000000004444: BF8903F7
	ds_store_b32 v97, v104                                     // 000000004448: D8340000 00006861
	v_cmp_gt_i32_e64 s8, s16, v103                             // 000000004450: D4440008 0002CE10
	s_and_b32 s8, s8, s7                                       // 000000004458: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000445C: BF870009
	s_and_saveexec_b32 s9, s8                                  // 000000004460: BE892008
	s_cbranch_execz 13                                         // 000000004464: BFA5000D <gemm_reg+0x89c>
	v_mad_u64_u32 v[104:105], null, v103, s16, v[0:1]          // 000000004468: D6FE7C68 04002167
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004470: BF870091
	v_ashrrev_i32_e32 v105, 31, v104                           // 000000004474: 34D2D09F
	v_lshlrev_b64 v[102:103], 2, v[104:105]                    // 000000004478: D73C0066 0002D082
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004480: BF870091
	v_add_co_u32 v102, s8, s14, v102                           // 000000004484: D7000866 0002CC0E
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8              // 00000000448C: D5207C67 0022CE0F
	global_load_b32 v102, v[102:103], off                      // 000000004494: DC520000 667C0066
	s_or_b32 exec_lo, exec_lo, s9                              // 00000000449C: 8C7E097E
	v_dual_mov_b32 v104, 0 :: v_dual_add_nc_u32 v103, s19, v94 // 0000000044A0: CA200080 6866BC13
	s_waitcnt vmcnt(0)                                         // 0000000044A8: BF8903F7
	ds_store_b32 v98, v102                                     // 0000000044AC: D8340000 00006662
	v_cmp_gt_i32_e64 s8, s16, v103                             // 0000000044B4: D4440008 0002CE10
	s_and_b32 s8, s8, s7                                       // 0000000044BC: 8B080708
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000044C0: BF870009
	s_and_saveexec_b32 s9, s8                                  // 0000000044C4: BE892008
	s_cbranch_execz 13                                         // 0000000044C8: BFA5000D <gemm_reg+0x900>
	v_mad_u64_u32 v[104:105], null, v103, s16, v[0:1]          // 0000000044CC: D6FE7C68 04002167
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000044D4: BF870091
	v_ashrrev_i32_e32 v105, 31, v104                           // 0000000044D8: 34D2D09F
	v_lshlrev_b64 v[102:103], 2, v[104:105]                    // 0000000044DC: D73C0066 0002D082
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000044E4: BF870091
	v_add_co_u32 v102, s8, s14, v102                           // 0000000044E8: D7000866 0002CC0E
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8              // 0000000044F0: D5207C67 0022CE0F
	global_load_b32 v104, v[102:103], off                      // 0000000044F8: DC520000 687C0066
	s_or_b32 exec_lo, exec_lo, s9                              // 000000004500: 8C7E097E
	v_mov_b32_e32 v102, v100                                   // 000000004504: 7ECC0364
	s_mov_b32 s8, 0                                            // 000000004508: BE880080
	s_waitcnt vmcnt(0)                                         // 00000000450C: BF8903F7
	ds_store_b32 v99, v104                                     // 000000004510: D8340000 00006863
	s_waitcnt lgkmcnt(0)                                       // 000000004518: BF89FC07
	s_barrier                                                  // 00000000451C: BFBD0000
	ds_load_2addr_b32 v[103:104], v102 offset1:16              // 000000004520: D8DC1000 67000066
	ds_load_2addr_b32 v[105:106], v102 offset0:32 offset1:48   // 000000004528: D8DC3020 69000066
	ds_load_2addr_b32 v[107:108], v102 offset0:64 offset1:80   // 000000004530: D8DC5040 6B000066
	ds_load_2addr_b32 v[109:110], v102 offset0:96 offset1:112  // 000000004538: D8DC7060 6D000066
	v_add_nc_u32_e32 v117, s8, v101                            // 000000004540: 4AEACA08
	s_add_i32 s8, s8, 4                                        // 000000004544: 81088408
	ds_load_2addr_stride64_b32 v[111:112], v117 offset1:4      // 000000004548: D8E00400 6F000075
	ds_load_2addr_stride64_b32 v[113:114], v117 offset0:8 offset1:12// 000000004550: D8E00C08 71000075
	ds_load_2addr_stride64_b32 v[115:116], v117 offset0:16 offset1:20// 000000004558: D8E01410 73000075
	ds_load_2addr_stride64_b32 v[117:118], v117 offset0:24 offset1:28// 000000004560: D8E01C18 75000075
	v_add_nc_u32_e32 v102, 0x200, v102                         // 000000004568: 4ACCCCFF 00000200
	s_cmp_lg_u32 s8, 64                                        // 000000004570: BF07C008
	s_waitcnt lgkmcnt(3)                                       // 000000004574: BF89FC37
	v_fmac_f32_e32 v65, v111, v104                             // 000000004578: 5682D16F
	v_fmac_f32_e32 v66, v111, v103                             // 00000000457C: 5684CF6F
	v_dual_fmac_f32 v64, v111, v105 :: v_dual_fmac_f32 v57, v112, v104// 000000004580: C800D36F 4038D170
	v_dual_fmac_f32 v63, v111, v106 :: v_dual_fmac_f32 v58, v112, v103// 000000004588: C800D56F 3F3ACF70
	v_dual_fmac_f32 v62, v111, v107 :: v_dual_fmac_f32 v53, v112, v106// 000000004590: C800D76F 3E34D570
	v_dual_fmac_f32 v61, v111, v108 :: v_dual_fmac_f32 v54, v112, v105// 000000004598: C800D96F 3D36D370
	v_dual_fmac_f32 v60, v111, v109 :: v_dual_fmac_f32 v51, v112, v108// 0000000045A0: C800DB6F 3C32D970
	v_dual_fmac_f32 v59, v111, v110 :: v_dual_fmac_f32 v52, v112, v107// 0000000045A8: C800DD6F 3B34D770
	s_waitcnt lgkmcnt(2)                                       // 0000000045B0: BF89FC27
	v_dual_fmac_f32 v50, v112, v109 :: v_dual_fmac_f32 v47, v113, v104// 0000000045B4: C800DB70 322ED171
	v_dual_fmac_f32 v49, v112, v110 :: v_dual_fmac_f32 v48, v113, v103// 0000000045BC: C800DD70 3130CF71
	v_dual_fmac_f32 v46, v113, v105 :: v_dual_fmac_f32 v39, v114, v104// 0000000045C4: C800D371 2E26D172
	v_dual_fmac_f32 v45, v113, v106 :: v_dual_fmac_f32 v40, v114, v103// 0000000045CC: C800D571 2D28CF72
	v_dual_fmac_f32 v44, v113, v107 :: v_dual_fmac_f32 v37, v114, v106// 0000000045D4: C800D771 2C24D572
	v_dual_fmac_f32 v43, v113, v108 :: v_dual_fmac_f32 v38, v114, v105// 0000000045DC: C800D971 2B26D372
	v_dual_fmac_f32 v42, v113, v109 :: v_dual_fmac_f32 v35, v114, v108// 0000000045E4: C800DB71 2A22D972
	v_dual_fmac_f32 v41, v113, v110 :: v_dual_fmac_f32 v36, v114, v107// 0000000045EC: C800DD71 2924D772
	s_waitcnt lgkmcnt(1)                                       // 0000000045F4: BF89FC17
	v_dual_fmac_f32 v34, v114, v109 :: v_dual_fmac_f32 v31, v115, v104// 0000000045F8: C800DB72 221ED173
	v_dual_fmac_f32 v33, v114, v110 :: v_dual_fmac_f32 v32, v115, v103// 000000004600: C800DD72 2120CF73
	v_dual_fmac_f32 v30, v115, v105 :: v_dual_fmac_f32 v23, v116, v104// 000000004608: C800D373 1E16D174
	v_dual_fmac_f32 v29, v115, v106 :: v_dual_fmac_f32 v24, v116, v103// 000000004610: C800D573 1D18CF74
	v_dual_fmac_f32 v28, v115, v107 :: v_dual_fmac_f32 v21, v116, v106// 000000004618: C800D773 1C14D574
	v_dual_fmac_f32 v27, v115, v108 :: v_dual_fmac_f32 v22, v116, v105// 000000004620: C800D973 1B16D374
	v_dual_fmac_f32 v26, v115, v109 :: v_dual_fmac_f32 v19, v116, v108// 000000004628: C800DB73 1A12D974
	v_dual_fmac_f32 v25, v115, v110 :: v_dual_fmac_f32 v20, v116, v107// 000000004630: C800DD73 1914D774
	s_waitcnt lgkmcnt(0)                                       // 000000004638: BF89FC07
	v_dual_fmac_f32 v18, v116, v109 :: v_dual_fmac_f32 v15, v117, v104// 00000000463C: C800DB74 120ED175
	v_dual_fmac_f32 v17, v116, v110 :: v_dual_fmac_f32 v16, v117, v103// 000000004644: C800DD74 1110CF75
	v_dual_fmac_f32 v14, v117, v105 :: v_dual_fmac_f32 v7, v118, v104// 00000000464C: C800D375 0E06D176
	v_dual_fmac_f32 v13, v117, v106 :: v_dual_fmac_f32 v8, v118, v103// 000000004654: C800D575 0D08CF76
	v_dual_fmac_f32 v12, v117, v107 :: v_dual_fmac_f32 v5, v118, v106// 00000000465C: C800D775 0C04D576
	v_dual_fmac_f32 v11, v117, v108 :: v_dual_fmac_f32 v6, v118, v105// 000000004664: C800D975 0B06D376
	v_dual_fmac_f32 v10, v117, v109 :: v_dual_fmac_f32 v3, v118, v108// 00000000466C: C800DB75 0A02D976
	v_dual_fmac_f32 v9, v117, v110 :: v_dual_fmac_f32 v4, v118, v107// 000000004674: C800DD75 0904D776
	v_fmac_f32_e32 v2, v118, v109                              // 00000000467C: 5604DB76
	v_fmac_f32_e32 v1, v118, v110                              // 000000004680: 5602DD76
	s_cbranch_scc1 65446                                       // 000000004684: BFA2FFA6 <gemm_reg+0x920>
	s_add_i32 s19, s19, 16                                     // 000000004688: 81139013
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000468C: BF870009
	s_cmp_ge_i32 s19, s16                                      // 000000004690: BF031013
	s_barrier                                                  // 000000004694: BFBD0000
	s_cbranch_scc0 65072                                       // 000000004698: BFA1FE30 <gemm_reg+0x35c>
	s_branch 64                                                // 00000000469C: BFA00040 <gemm_reg+0xba0>
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v2, 0               // 0000000046A0: CA100080 01020080
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v4, 0               // 0000000046A8: CA100080 03040080
	v_dual_mov_b32 v5, 0 :: v_dual_mov_b32 v6, 0               // 0000000046B0: CA100080 05060080
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v8, 0               // 0000000046B8: CA100080 07080080
	v_dual_mov_b32 v9, 0 :: v_dual_mov_b32 v10, 0              // 0000000046C0: CA100080 090A0080
	v_dual_mov_b32 v11, 0 :: v_dual_mov_b32 v12, 0             // 0000000046C8: CA100080 0B0C0080
	v_dual_mov_b32 v13, 0 :: v_dual_mov_b32 v14, 0             // 0000000046D0: CA100080 0D0E0080
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0             // 0000000046D8: CA100080 0F100080
	v_dual_mov_b32 v66, 0 :: v_dual_mov_b32 v65, 0             // 0000000046E0: CA100080 42400080
	v_dual_mov_b32 v64, 0 :: v_dual_mov_b32 v63, 0             // 0000000046E8: CA100080 403E0080
	v_dual_mov_b32 v62, 0 :: v_dual_mov_b32 v61, 0             // 0000000046F0: CA100080 3E3C0080
	v_dual_mov_b32 v60, 0 :: v_dual_mov_b32 v59, 0             // 0000000046F8: CA100080 3C3A0080
	v_dual_mov_b32 v58, 0 :: v_dual_mov_b32 v57, 0             // 000000004700: CA100080 3A380080
	v_dual_mov_b32 v54, 0 :: v_dual_mov_b32 v53, 0             // 000000004708: CA100080 36340080
	v_dual_mov_b32 v52, 0 :: v_dual_mov_b32 v51, 0             // 000000004710: CA100080 34320080
	v_dual_mov_b32 v50, 0 :: v_dual_mov_b32 v49, 0             // 000000004718: CA100080 32300080
	v_dual_mov_b32 v48, 0 :: v_dual_mov_b32 v47, 0             // 000000004720: CA100080 302E0080
	v_dual_mov_b32 v46, 0 :: v_dual_mov_b32 v45, 0             // 000000004728: CA100080 2E2C0080
	v_dual_mov_b32 v44, 0 :: v_dual_mov_b32 v43, 0             // 000000004730: CA100080 2C2A0080
	v_dual_mov_b32 v42, 0 :: v_dual_mov_b32 v41, 0             // 000000004738: CA100080 2A280080
	v_dual_mov_b32 v40, 0 :: v_dual_mov_b32 v39, 0             // 000000004740: CA100080 28260080
	v_dual_mov_b32 v38, 0 :: v_dual_mov_b32 v37, 0             // 000000004748: CA100080 26240080
	v_dual_mov_b32 v36, 0 :: v_dual_mov_b32 v35, 0             // 000000004750: CA100080 24220080
	v_dual_mov_b32 v34, 0 :: v_dual_mov_b32 v33, 0             // 000000004758: CA100080 22200080
	v_dual_mov_b32 v32, 0 :: v_dual_mov_b32 v31, 0             // 000000004760: CA100080 201E0080
	v_dual_mov_b32 v30, 0 :: v_dual_mov_b32 v29, 0             // 000000004768: CA100080 1E1C0080
	v_dual_mov_b32 v28, 0 :: v_dual_mov_b32 v27, 0             // 000000004770: CA100080 1C1A0080
	v_dual_mov_b32 v26, 0 :: v_dual_mov_b32 v25, 0             // 000000004778: CA100080 1A180080
	v_dual_mov_b32 v24, 0 :: v_dual_mov_b32 v23, 0             // 000000004780: CA100080 18160080
	v_dual_mov_b32 v22, 0 :: v_dual_mov_b32 v21, 0             // 000000004788: CA100080 16140080
	v_dual_mov_b32 v20, 0 :: v_dual_mov_b32 v19, 0             // 000000004790: CA100080 14120080
	v_dual_mov_b32 v18, 0 :: v_dual_mov_b32 v17, 0             // 000000004798: CA100080 12100080
	v_add_nc_u32_e32 v67, s17, v56                             // 0000000047A0: 4A867011
	v_add_nc_u32_e32 v0, s18, v55                              // 0000000047A4: 4A006E12
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 0000000047A8: BF8701A2
	v_mul_lo_u32 v68, v67, s16                                 // 0000000047AC: D72C0044 00002143
	v_cmp_gt_i32_e64 s7, s16, v67                              // 0000000047B4: D4440007 00028610
	v_cmp_gt_i32_e32 vcc_lo, s16, v0                           // 0000000047BC: 7C880010
	s_and_b32 s0, s7, vcc_lo                                   // 0000000047C0: 8B006A07
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000047C4: BF870009
	s_and_saveexec_b32 s1, s0                                  // 0000000047C8: BE812000
	s_cbranch_execz 12                                         // 0000000047CC: BFA5000C <gemm_reg+0xc00>
	v_add_nc_u32_e32 v55, v68, v0                              // 0000000047D0: 4A6E0144
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000047D4: BF870091
	v_ashrrev_i32_e32 v56, 31, v55                             // 0000000047D8: 34706E9F
	v_lshlrev_b64 v[55:56], 2, v[55:56]                        // 0000000047DC: D73C0037 00026E82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000047E4: BF870091
	v_add_co_u32 v55, s0, s10, v55                             // 0000000047E8: D7000037 00026E0A
	v_add_co_ci_u32_e64 v56, null, s11, v56, s0                // 0000000047F0: D5207C38 0002700B
	global_store_b32 v[55:56], v66, off                        // 0000000047F8: DC6A0000 007C4237
	s_or_b32 exec_lo, exec_lo, s1                              // 000000004800: 8C7E017E
	v_add_nc_u32_e32 v55, 16, v0                               // 000000004804: 4A6E0090
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 000000004808: BF8704A1
	v_cmp_gt_i32_e64 s0, s16, v55                              // 00000000480C: D4440000 00026E10
	s_and_b32 s1, s7, s0                                       // 000000004814: 8B010007
	s_and_saveexec_b32 s2, s1                                  // 000000004818: BE822001
	s_cbranch_execz 12                                         // 00000000481C: BFA5000C <gemm_reg+0xc50>
	v_add_nc_u32_e32 v69, v55, v68                             // 000000004820: 4A8A8937
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004824: BF870091
	v_ashrrev_i32_e32 v70, 31, v69                             // 000000004828: 348C8A9F
	v_lshlrev_b64 v[69:70], 2, v[69:70]                        // 00000000482C: D73C0045 00028A82
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004834: BF870091
	v_add_co_u32 v69, s1, s10, v69                             // 000000004838: D7000145 00028A0A
	v_add_co_ci_u32_e64 v70, null, s11, v70, s1                // 000000004840: D5207C46 00068C0B
	global_store_b32 v[69:70], v65, off                        // 000000004848: DC6A0000 007C4145
	s_or_b32 exec_lo, exec_lo, s2                              // 000000004850: 8C7E027E
	v_add_nc_u32_e32 v56, 32, v0                               // 000000004854: 4A7000A0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 000000004858: BF8704A1
	v_cmp_gt_i32_e64 s1, s16, v56                              // 00000000485C: D4440001 00027010
	s_and_b32 s2, s7, s1                                       // 000000004864: 8B020107
	s_and_saveexec_b32 s3, s2                                  // 000000004868: BE832002
	s_cbranch_execz 12                                         // 00000000486C: BFA5000C <gemm_reg+0xca0>
	v_add_nc_u32_e32 v65, v56, v68                             // 000000004870: 4A828938
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004874: BF870091
	v_ashrrev_i32_e32 v66, 31, v65                             // 000000004878: 3484829F
	v_lshlrev_b64 v[65:66], 2, v[65:66]                        // 00000000487C: D73C0041 00028282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004884: BF870091
	v_add_co_u32 v65, s2, s10, v65                             // 000000004888: D7000241 0002820A
	v_add_co_ci_u32_e64 v66, null, s11, v66, s2                // 000000004890: D5207C42 000A840B
	global_store_b32 v[65:66], v64, off                        // 000000004898: DC6A0000 007C4041
	s_or_b32 exec_lo, exec_lo, s3                              // 0000000048A0: 8C7E037E
	v_add_nc_u32_e32 v64, 48, v0                               // 0000000048A4: 4A8000B0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 0000000048A8: BF8704A1
	v_cmp_gt_i32_e64 s2, s16, v64                              // 0000000048AC: D4440002 00028010
	s_and_b32 s3, s7, s2                                       // 0000000048B4: 8B030207
	s_and_saveexec_b32 s4, s3                                  // 0000000048B8: BE842003
	s_cbranch_execz 12                                         // 0000000048BC: BFA5000C <gemm_reg+0xcf0>
	v_add_nc_u32_e32 v65, v64, v68                             // 0000000048C0: 4A828940
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000048C4: BF870091
	v_ashrrev_i32_e32 v66, 31, v65                             // 0000000048C8: 3484829F
	v_lshlrev_b64 v[65:66], 2, v[65:66]                        // 0000000048CC: D73C0041 00028282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000048D4: BF870091
	v_add_co_u32 v65, s3, s10, v65                             // 0000000048D8: D7000341 0002820A
	v_add_co_ci_u32_e64 v66, null, s11, v66, s3                // 0000000048E0: D5207C42 000E840B
	global_store_b32 v[65:66], v63, off                        // 0000000048E8: DC6A0000 007C3F41
	s_or_b32 exec_lo, exec_lo, s4                              // 0000000048F0: 8C7E047E
	v_add_nc_u32_e32 v63, 64, v0                               // 0000000048F4: 4A7E00C0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 0000000048F8: BF8704A1
	v_cmp_gt_i32_e64 s3, s16, v63                              // 0000000048FC: D4440003 00027E10
	s_and_b32 s4, s7, s3                                       // 000000004904: 8B040307
	s_and_saveexec_b32 s5, s4                                  // 000000004908: BE852004
	s_cbranch_execz 12                                         // 00000000490C: BFA5000C <gemm_reg+0xd40>
	v_add_nc_u32_e32 v65, v63, v68                             // 000000004910: 4A82893F
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004914: BF870091
	v_ashrrev_i32_e32 v66, 31, v65                             // 000000004918: 3484829F
	v_lshlrev_b64 v[65:66], 2, v[65:66]                        // 00000000491C: D73C0041 00028282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004924: BF870091
	v_add_co_u32 v65, s4, s10, v65                             // 000000004928: D7000441 0002820A
	v_add_co_ci_u32_e64 v66, null, s11, v66, s4                // 000000004930: D5207C42 0012840B
	global_store_b32 v[65:66], v62, off                        // 000000004938: DC6A0000 007C3E41
	s_or_b32 exec_lo, exec_lo, s5                              // 000000004940: 8C7E057E
	v_add_nc_u32_e32 v62, 0x50, v0                             // 000000004944: 4A7C00FF 00000050
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 00000000494C: BF8704A1
	v_cmp_gt_i32_e64 s4, s16, v62                              // 000000004950: D4440004 00027C10
	s_and_b32 s5, s7, s4                                       // 000000004958: 8B050407
	s_and_saveexec_b32 s6, s5                                  // 00000000495C: BE862005
	s_cbranch_execz 12                                         // 000000004960: BFA5000C <gemm_reg+0xd94>
	v_add_nc_u32_e32 v65, v62, v68                             // 000000004964: 4A82893E
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004968: BF870091
	v_ashrrev_i32_e32 v66, 31, v65                             // 00000000496C: 3484829F
	v_lshlrev_b64 v[65:66], 2, v[65:66]                        // 000000004970: D73C0041 00028282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004978: BF870091
	v_add_co_u32 v65, s5, s10, v65                             // 00000000497C: D7000541 0002820A
	v_add_co_ci_u32_e64 v66, null, s11, v66, s5                // 000000004984: D5207C42 0016840B
	global_store_b32 v[65:66], v61, off                        // 00000000498C: DC6A0000 007C3D41
	s_or_b32 exec_lo, exec_lo, s6                              // 000000004994: 8C7E067E
	v_add_nc_u32_e32 v61, 0x60, v0                             // 000000004998: 4A7A00FF 00000060
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 0000000049A0: BF8704A1
	v_cmp_gt_i32_e64 s5, s16, v61                              // 0000000049A4: D4440005 00027A10
	s_and_b32 s6, s7, s5                                       // 0000000049AC: 8B060507
	s_and_saveexec_b32 s8, s6                                  // 0000000049B0: BE882006
	s_cbranch_execz 12                                         // 0000000049B4: BFA5000C <gemm_reg+0xde8>
	v_add_nc_u32_e32 v65, v61, v68                             // 0000000049B8: 4A82893D
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000049BC: BF870091
	v_ashrrev_i32_e32 v66, 31, v65                             // 0000000049C0: 3484829F
	v_lshlrev_b64 v[65:66], 2, v[65:66]                        // 0000000049C4: D73C0041 00028282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000049CC: BF870091
	v_add_co_u32 v65, s6, s10, v65                             // 0000000049D0: D7000641 0002820A
	v_add_co_ci_u32_e64 v66, null, s11, v66, s6                // 0000000049D8: D5207C42 001A840B
	global_store_b32 v[65:66], v60, off                        // 0000000049E0: DC6A0000 007C3C41
	s_or_b32 exec_lo, exec_lo, s8                              // 0000000049E8: 8C7E087E
	v_add_nc_u32_e32 v60, 0x70, v0                             // 0000000049EC: 4A7800FF 00000070
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 0000000049F4: BF8704A1
	v_cmp_gt_i32_e64 s6, s16, v60                              // 0000000049F8: D4440006 00027810
	s_and_b32 s7, s7, s6                                       // 000000004A00: 8B070607
	s_and_saveexec_b32 s8, s7                                  // 000000004A04: BE882007
	s_cbranch_execz 12                                         // 000000004A08: BFA5000C <gemm_reg+0xe3c>
	v_add_nc_u32_e32 v65, v60, v68                             // 000000004A0C: 4A82893C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004A10: BF870091
	v_ashrrev_i32_e32 v66, 31, v65                             // 000000004A14: 3484829F
	v_lshlrev_b64 v[65:66], 2, v[65:66]                        // 000000004A18: D73C0041 00028282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004A20: BF870091
	v_add_co_u32 v65, s7, s10, v65                             // 000000004A24: D7000741 0002820A
	v_add_co_ci_u32_e64 v66, null, s11, v66, s7                // 000000004A2C: D5207C42 001E840B
	global_store_b32 v[65:66], v59, off                        // 000000004A34: DC6A0000 007C3B41
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004A3C: 8C7E087E
	v_add_nc_u32_e32 v59, 16, v67                              // 000000004A40: 4A768690
	s_lshl_b32 s9, s16, 4                                      // 000000004A44: 84098410
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004A48: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v59                              // 000000004A4C: D4440007 00027610
	v_add_nc_u32_e32 v59, s9, v68                              // 000000004A54: 4A768809
	s_and_b32 s8, vcc_lo, s7                                   // 000000004A58: 8B08076A
	s_and_saveexec_b32 s12, s8                                 // 000000004A5C: BE8C2008
	s_cbranch_execnz 377                                       // 000000004A60: BFA60179 <gemm_reg+0x1448>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004A64: 8C7E0C7E
	s_and_b32 s8, s7, s0                                       // 000000004A68: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004A6C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004A70: BE8C2008
	s_cbranch_execnz 389                                       // 000000004A74: BFA60185 <gemm_reg+0x148c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004A78: 8C7E0C7E
	s_and_b32 s8, s7, s1                                       // 000000004A7C: 8B080107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004A80: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004A84: BE8C2008
	s_cbranch_execnz 401                                       // 000000004A88: BFA60191 <gemm_reg+0x14d0>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004A8C: 8C7E0C7E
	s_and_b32 s8, s7, s2                                       // 000000004A90: 8B080207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004A94: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004A98: BE8C2008
	s_cbranch_execnz 413                                       // 000000004A9C: BFA6019D <gemm_reg+0x1514>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004AA0: 8C7E0C7E
	s_and_b32 s8, s7, s3                                       // 000000004AA4: 8B080307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004AA8: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004AAC: BE8C2008
	s_cbranch_execnz 425                                       // 000000004AB0: BFA601A9 <gemm_reg+0x1558>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004AB4: 8C7E0C7E
	s_and_b32 s8, s7, s4                                       // 000000004AB8: 8B080407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004ABC: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004AC0: BE8C2008
	s_cbranch_execnz 437                                       // 000000004AC4: BFA601B5 <gemm_reg+0x159c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004AC8: 8C7E0C7E
	s_and_b32 s8, s7, s5                                       // 000000004ACC: 8B080507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004AD0: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004AD4: BE8C2008
	s_cbranch_execnz 449                                       // 000000004AD8: BFA601C1 <gemm_reg+0x15e0>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004ADC: 8C7E0C7E
	s_and_b32 s7, s7, s6                                       // 000000004AE0: 8B070607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004AE4: BF870009
	s_and_saveexec_b32 s8, s7                                  // 000000004AE8: BE882007
	s_cbranch_execz 12                                         // 000000004AEC: BFA5000C <gemm_reg+0xf20>
	v_add_nc_u32_e32 v50, v59, v60                             // 000000004AF0: 4A64793B
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004AF4: BF870091
	v_ashrrev_i32_e32 v51, 31, v50                             // 000000004AF8: 3466649F
	v_lshlrev_b64 v[50:51], 2, v[50:51]                        // 000000004AFC: D73C0032 00026482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004B04: BF870091
	v_add_co_u32 v50, s7, s10, v50                             // 000000004B08: D7000732 0002640A
	v_add_co_ci_u32_e64 v51, null, s11, v51, s7                // 000000004B10: D5207C33 001E660B
	global_store_b32 v[50:51], v49, off                        // 000000004B18: DC6A0000 007C3132
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004B20: 8C7E087E
	v_add_nc_u32_e32 v49, 32, v67                              // 000000004B24: 4A6286A0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004B28: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v49                              // 000000004B2C: D4440007 00026210
	v_add_nc_u32_e32 v49, s9, v59                              // 000000004B34: 4A627609
	s_and_b32 s8, vcc_lo, s7                                   // 000000004B38: 8B08076A
	s_and_saveexec_b32 s12, s8                                 // 000000004B3C: BE8C2008
	s_cbranch_execnz 441                                       // 000000004B40: BFA601B9 <gemm_reg+0x1628>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004B44: 8C7E0C7E
	s_and_b32 s8, s7, s0                                       // 000000004B48: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004B4C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004B50: BE8C2008
	s_cbranch_execnz 453                                       // 000000004B54: BFA601C5 <gemm_reg+0x166c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004B58: 8C7E0C7E
	s_and_b32 s8, s7, s1                                       // 000000004B5C: 8B080107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004B60: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004B64: BE8C2008
	s_cbranch_execnz 465                                       // 000000004B68: BFA601D1 <gemm_reg+0x16b0>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004B6C: 8C7E0C7E
	s_and_b32 s8, s7, s2                                       // 000000004B70: 8B080207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004B74: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004B78: BE8C2008
	s_cbranch_execnz 477                                       // 000000004B7C: BFA601DD <gemm_reg+0x16f4>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004B80: 8C7E0C7E
	s_and_b32 s8, s7, s3                                       // 000000004B84: 8B080307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004B88: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004B8C: BE8C2008
	s_cbranch_execnz 489                                       // 000000004B90: BFA601E9 <gemm_reg+0x1738>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004B94: 8C7E0C7E
	s_and_b32 s8, s7, s4                                       // 000000004B98: 8B080407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004B9C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004BA0: BE8C2008
	s_cbranch_execnz 501                                       // 000000004BA4: BFA601F5 <gemm_reg+0x177c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004BA8: 8C7E0C7E
	s_and_b32 s8, s7, s5                                       // 000000004BAC: 8B080507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004BB0: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004BB4: BE8C2008
	s_cbranch_execnz 513                                       // 000000004BB8: BFA60201 <gemm_reg+0x17c0>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004BBC: 8C7E0C7E
	s_and_b32 s7, s7, s6                                       // 000000004BC0: 8B070607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004BC4: BF870009
	s_and_saveexec_b32 s8, s7                                  // 000000004BC8: BE882007
	s_cbranch_execz 12                                         // 000000004BCC: BFA5000C <gemm_reg+0x1000>
	v_add_nc_u32_e32 v42, v49, v60                             // 000000004BD0: 4A547931
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004BD4: BF870091
	v_ashrrev_i32_e32 v43, 31, v42                             // 000000004BD8: 3456549F
	v_lshlrev_b64 v[42:43], 2, v[42:43]                        // 000000004BDC: D73C002A 00025482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004BE4: BF870091
	v_add_co_u32 v42, s7, s10, v42                             // 000000004BE8: D700072A 0002540A
	v_add_co_ci_u32_e64 v43, null, s11, v43, s7                // 000000004BF0: D5207C2B 001E560B
	global_store_b32 v[42:43], v41, off                        // 000000004BF8: DC6A0000 007C292A
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004C00: 8C7E087E
	v_add_nc_u32_e32 v41, 48, v67                              // 000000004C04: 4A5286B0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004C08: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v41                              // 000000004C0C: D4440007 00025210
	v_add_nc_u32_e32 v41, s9, v49                              // 000000004C14: 4A526209
	s_and_b32 s8, vcc_lo, s7                                   // 000000004C18: 8B08076A
	s_and_saveexec_b32 s12, s8                                 // 000000004C1C: BE8C2008
	s_cbranch_execnz 505                                       // 000000004C20: BFA601F9 <gemm_reg+0x1808>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C24: 8C7E0C7E
	s_and_b32 s8, s7, s0                                       // 000000004C28: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004C2C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004C30: BE8C2008
	s_cbranch_execnz 517                                       // 000000004C34: BFA60205 <gemm_reg+0x184c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C38: 8C7E0C7E
	s_and_b32 s8, s7, s1                                       // 000000004C3C: 8B080107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004C40: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004C44: BE8C2008
	s_cbranch_execnz 529                                       // 000000004C48: BFA60211 <gemm_reg+0x1890>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C4C: 8C7E0C7E
	s_and_b32 s8, s7, s2                                       // 000000004C50: 8B080207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004C54: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004C58: BE8C2008
	s_cbranch_execnz 541                                       // 000000004C5C: BFA6021D <gemm_reg+0x18d4>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C60: 8C7E0C7E
	s_and_b32 s8, s7, s3                                       // 000000004C64: 8B080307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004C68: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004C6C: BE8C2008
	s_cbranch_execnz 553                                       // 000000004C70: BFA60229 <gemm_reg+0x1918>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C74: 8C7E0C7E
	s_and_b32 s8, s7, s4                                       // 000000004C78: 8B080407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004C7C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004C80: BE8C2008
	s_cbranch_execnz 565                                       // 000000004C84: BFA60235 <gemm_reg+0x195c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C88: 8C7E0C7E
	s_and_b32 s8, s7, s5                                       // 000000004C8C: 8B080507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004C90: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004C94: BE8C2008
	s_cbranch_execnz 577                                       // 000000004C98: BFA60241 <gemm_reg+0x19a0>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004C9C: 8C7E0C7E
	s_and_b32 s7, s7, s6                                       // 000000004CA0: 8B070607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004CA4: BF870009
	s_and_saveexec_b32 s8, s7                                  // 000000004CA8: BE882007
	s_cbranch_execz 12                                         // 000000004CAC: BFA5000C <gemm_reg+0x10e0>
	v_add_nc_u32_e32 v34, v41, v60                             // 000000004CB0: 4A447929
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004CB4: BF870091
	v_ashrrev_i32_e32 v35, 31, v34                             // 000000004CB8: 3446449F
	v_lshlrev_b64 v[34:35], 2, v[34:35]                        // 000000004CBC: D73C0022 00024482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004CC4: BF870091
	v_add_co_u32 v34, s7, s10, v34                             // 000000004CC8: D7000722 0002440A
	v_add_co_ci_u32_e64 v35, null, s11, v35, s7                // 000000004CD0: D5207C23 001E460B
	global_store_b32 v[34:35], v33, off                        // 000000004CD8: DC6A0000 007C2122
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004CE0: 8C7E087E
	v_add_nc_u32_e32 v33, 64, v67                              // 000000004CE4: 4A4286C0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004CE8: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v33                              // 000000004CEC: D4440007 00024210
	v_add_nc_u32_e32 v33, s9, v41                              // 000000004CF4: 4A425209
	s_and_b32 s8, vcc_lo, s7                                   // 000000004CF8: 8B08076A
	s_and_saveexec_b32 s12, s8                                 // 000000004CFC: BE8C2008
	s_cbranch_execnz 569                                       // 000000004D00: BFA60239 <gemm_reg+0x19e8>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D04: 8C7E0C7E
	s_and_b32 s8, s7, s0                                       // 000000004D08: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D0C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004D10: BE8C2008
	s_cbranch_execnz 581                                       // 000000004D14: BFA60245 <gemm_reg+0x1a2c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D18: 8C7E0C7E
	s_and_b32 s8, s7, s1                                       // 000000004D1C: 8B080107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D20: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004D24: BE8C2008
	s_cbranch_execnz 593                                       // 000000004D28: BFA60251 <gemm_reg+0x1a70>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D2C: 8C7E0C7E
	s_and_b32 s8, s7, s2                                       // 000000004D30: 8B080207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D34: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004D38: BE8C2008
	s_cbranch_execnz 605                                       // 000000004D3C: BFA6025D <gemm_reg+0x1ab4>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D40: 8C7E0C7E
	s_and_b32 s8, s7, s3                                       // 000000004D44: 8B080307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D48: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004D4C: BE8C2008
	s_cbranch_execnz 617                                       // 000000004D50: BFA60269 <gemm_reg+0x1af8>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D54: 8C7E0C7E
	s_and_b32 s8, s7, s4                                       // 000000004D58: 8B080407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D5C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004D60: BE8C2008
	s_cbranch_execnz 629                                       // 000000004D64: BFA60275 <gemm_reg+0x1b3c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D68: 8C7E0C7E
	s_and_b32 s8, s7, s5                                       // 000000004D6C: 8B080507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D70: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004D74: BE8C2008
	s_cbranch_execnz 641                                       // 000000004D78: BFA60281 <gemm_reg+0x1b80>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004D7C: 8C7E0C7E
	s_and_b32 s7, s7, s6                                       // 000000004D80: 8B070607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004D84: BF870009
	s_and_saveexec_b32 s8, s7                                  // 000000004D88: BE882007
	s_cbranch_execz 12                                         // 000000004D8C: BFA5000C <gemm_reg+0x11c0>
	v_add_nc_u32_e32 v26, v33, v60                             // 000000004D90: 4A347921
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004D94: BF870091
	v_ashrrev_i32_e32 v27, 31, v26                             // 000000004D98: 3436349F
	v_lshlrev_b64 v[26:27], 2, v[26:27]                        // 000000004D9C: D73C001A 00023482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004DA4: BF870091
	v_add_co_u32 v26, s7, s10, v26                             // 000000004DA8: D700071A 0002340A
	v_add_co_ci_u32_e64 v27, null, s11, v27, s7                // 000000004DB0: D5207C1B 001E360B
	global_store_b32 v[26:27], v25, off                        // 000000004DB8: DC6A0000 007C191A
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004DC0: 8C7E087E
	v_add_nc_u32_e32 v25, 0x50, v67                            // 000000004DC4: 4A3286FF 00000050
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004DCC: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v25                              // 000000004DD0: D4440007 00023210
	v_add_nc_u32_e32 v25, s9, v33                              // 000000004DD8: 4A324209
	s_and_b32 s8, vcc_lo, s7                                   // 000000004DDC: 8B08076A
	s_and_saveexec_b32 s12, s8                                 // 000000004DE0: BE8C2008
	s_cbranch_execnz 632                                       // 000000004DE4: BFA60278 <gemm_reg+0x1bc8>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004DE8: 8C7E0C7E
	s_and_b32 s8, s7, s0                                       // 000000004DEC: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004DF0: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004DF4: BE8C2008
	s_cbranch_execnz 644                                       // 000000004DF8: BFA60284 <gemm_reg+0x1c0c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004DFC: 8C7E0C7E
	s_and_b32 s8, s7, s1                                       // 000000004E00: 8B080107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004E04: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004E08: BE8C2008
	s_cbranch_execnz 656                                       // 000000004E0C: BFA60290 <gemm_reg+0x1c50>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004E10: 8C7E0C7E
	s_and_b32 s8, s7, s2                                       // 000000004E14: 8B080207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004E18: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004E1C: BE8C2008
	s_cbranch_execnz 668                                       // 000000004E20: BFA6029C <gemm_reg+0x1c94>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004E24: 8C7E0C7E
	s_and_b32 s8, s7, s3                                       // 000000004E28: 8B080307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004E2C: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004E30: BE8C2008
	s_cbranch_execnz 680                                       // 000000004E34: BFA602A8 <gemm_reg+0x1cd8>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004E38: 8C7E0C7E
	s_and_b32 s8, s7, s4                                       // 000000004E3C: 8B080407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004E40: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004E44: BE8C2008
	s_cbranch_execnz 692                                       // 000000004E48: BFA602B4 <gemm_reg+0x1d1c>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004E4C: 8C7E0C7E
	s_and_b32 s8, s7, s5                                       // 000000004E50: 8B080507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004E54: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004E58: BE8C2008
	s_cbranch_execnz 704                                       // 000000004E5C: BFA602C0 <gemm_reg+0x1d60>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004E60: 8C7E0C7E
	s_and_b32 s7, s7, s6                                       // 000000004E64: 8B070607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004E68: BF870009
	s_and_saveexec_b32 s8, s7                                  // 000000004E6C: BE882007
	s_cbranch_execz 12                                         // 000000004E70: BFA5000C <gemm_reg+0x12a4>
	v_add_nc_u32_e32 v18, v25, v60                             // 000000004E74: 4A247919
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004E78: BF870091
	v_ashrrev_i32_e32 v19, 31, v18                             // 000000004E7C: 3426249F
	v_lshlrev_b64 v[18:19], 2, v[18:19]                        // 000000004E80: D73C0012 00022482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004E88: BF870091
	v_add_co_u32 v18, s7, s10, v18                             // 000000004E8C: D7000712 0002240A
	v_add_co_ci_u32_e64 v19, null, s11, v19, s7                // 000000004E94: D5207C13 001E260B
	global_store_b32 v[18:19], v17, off                        // 000000004E9C: DC6A0000 007C1112
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004EA4: 8C7E087E
	v_add_nc_u32_e32 v17, 0x60, v67                            // 000000004EA8: 4A2286FF 00000060
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004EB0: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v17                              // 000000004EB4: D4440007 00022210
	v_add_nc_u32_e32 v17, s9, v25                              // 000000004EBC: 4A223209
	s_and_b32 s8, vcc_lo, s7                                   // 000000004EC0: 8B08076A
	s_and_saveexec_b32 s12, s8                                 // 000000004EC4: BE8C2008
	s_cbranch_execnz 695                                       // 000000004EC8: BFA602B7 <gemm_reg+0x1da8>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004ECC: 8C7E0C7E
	s_and_b32 s8, s7, s0                                       // 000000004ED0: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004ED4: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004ED8: BE8C2008
	s_cbranch_execnz 707                                       // 000000004EDC: BFA602C3 <gemm_reg+0x1dec>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004EE0: 8C7E0C7E
	s_and_b32 s8, s7, s1                                       // 000000004EE4: 8B080107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004EE8: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004EEC: BE8C2008
	s_cbranch_execnz 719                                       // 000000004EF0: BFA602CF <gemm_reg+0x1e30>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004EF4: 8C7E0C7E
	s_and_b32 s8, s7, s2                                       // 000000004EF8: 8B080207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004EFC: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004F00: BE8C2008
	s_cbranch_execnz 731                                       // 000000004F04: BFA602DB <gemm_reg+0x1e74>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004F08: 8C7E0C7E
	s_and_b32 s8, s7, s3                                       // 000000004F0C: 8B080307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004F10: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004F14: BE8C2008
	s_cbranch_execnz 743                                       // 000000004F18: BFA602E7 <gemm_reg+0x1eb8>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004F1C: 8C7E0C7E
	s_and_b32 s8, s7, s4                                       // 000000004F20: 8B080407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004F24: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004F28: BE8C2008
	s_cbranch_execnz 755                                       // 000000004F2C: BFA602F3 <gemm_reg+0x1efc>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004F30: 8C7E0C7E
	s_and_b32 s8, s7, s5                                       // 000000004F34: 8B080507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004F38: BF870009
	s_and_saveexec_b32 s12, s8                                 // 000000004F3C: BE8C2008
	s_cbranch_execnz 767                                       // 000000004F40: BFA602FF <gemm_reg+0x1f40>
	s_or_b32 exec_lo, exec_lo, s12                             // 000000004F44: 8C7E0C7E
	s_and_b32 s7, s7, s6                                       // 000000004F48: 8B070607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004F4C: BF870009
	s_and_saveexec_b32 s8, s7                                  // 000000004F50: BE882007
	s_cbranch_execz 12                                         // 000000004F54: BFA5000C <gemm_reg+0x1388>
	v_add_nc_u32_e32 v10, v17, v60                             // 000000004F58: 4A147911
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004F5C: BF870091
	v_ashrrev_i32_e32 v11, 31, v10                             // 000000004F60: 3416149F
	v_lshlrev_b64 v[10:11], 2, v[10:11]                        // 000000004F64: D73C000A 00021482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000004F6C: BF870091
	v_add_co_u32 v10, s7, s10, v10                             // 000000004F70: D700070A 0002140A
	v_add_co_ci_u32_e64 v11, null, s11, v11, s7                // 000000004F78: D5207C0B 001E160B
	global_store_b32 v[10:11], v9, off                         // 000000004F80: DC6A0000 007C090A
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004F88: 8C7E087E
	v_add_nc_u32_e32 v9, 0x70, v67                             // 000000004F8C: 4A1286FF 00000070
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)// 000000004F94: BF8704B1
	v_cmp_gt_i32_e64 s7, s16, v9                               // 000000004F98: D4440007 00021210
	v_add_nc_u32_e32 v9, s9, v17                               // 000000004FA0: 4A122209
	s_and_b32 s9, vcc_lo, s7                                   // 000000004FA4: 8B09076A
	s_and_saveexec_b32 s8, s9                                  // 000000004FA8: BE882009
	s_cbranch_execnz 758                                       // 000000004FAC: BFA602F6 <gemm_reg+0x1f88>
	s_or_b32 exec_lo, exec_lo, s8                              // 000000004FB0: 8C7E087E
	s_and_b32 s8, s7, s0                                       // 000000004FB4: 8B080007
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004FB8: BF870009
	s_and_saveexec_b32 s0, s8                                  // 000000004FBC: BE802008
	s_cbranch_execnz 770                                       // 000000004FC0: BFA60302 <gemm_reg+0x1fcc>
	s_or_b32 exec_lo, exec_lo, s0                              // 000000004FC4: 8C7E007E
	s_and_b32 s1, s7, s1                                       // 000000004FC8: 8B010107
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004FCC: BF870009
	s_and_saveexec_b32 s0, s1                                  // 000000004FD0: BE802001
	s_cbranch_execnz 782                                       // 000000004FD4: BFA6030E <gemm_reg+0x2010>
	s_or_b32 exec_lo, exec_lo, s0                              // 000000004FD8: 8C7E007E
	s_and_b32 s1, s7, s2                                       // 000000004FDC: 8B010207
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004FE0: BF870009
	s_and_saveexec_b32 s0, s1                                  // 000000004FE4: BE802001
	s_cbranch_execnz 794                                       // 000000004FE8: BFA6031A <gemm_reg+0x2054>
	s_or_b32 exec_lo, exec_lo, s0                              // 000000004FEC: 8C7E007E
	s_and_b32 s1, s7, s3                                       // 000000004FF0: 8B010307
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000004FF4: BF870009
	s_and_saveexec_b32 s0, s1                                  // 000000004FF8: BE802001
	s_cbranch_execnz 806                                       // 000000004FFC: BFA60326 <gemm_reg+0x2098>
	s_or_b32 exec_lo, exec_lo, s0                              // 000000005000: 8C7E007E
	s_and_b32 s1, s7, s4                                       // 000000005004: 8B010407
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000005008: BF870009
	s_and_saveexec_b32 s0, s1                                  // 00000000500C: BE802001
	s_cbranch_execnz 818                                       // 000000005010: BFA60332 <gemm_reg+0x20dc>
	s_or_b32 exec_lo, exec_lo, s0                              // 000000005014: 8C7E007E
	s_and_b32 s1, s7, s5                                       // 000000005018: 8B010507
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000501C: BF870009
	s_and_saveexec_b32 s0, s1                                  // 000000005020: BE802001
	s_cbranch_execnz 830                                       // 000000005024: BFA6033E <gemm_reg+0x2120>
	s_or_b32 exec_lo, exec_lo, s0                              // 000000005028: 8C7E007E
	s_and_b32 s0, s7, s6                                       // 00000000502C: 8B000607
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000005030: BF870009
	s_and_saveexec_b32 s1, s0                                  // 000000005034: BE812000
	s_cbranch_execnz 842                                       // 000000005038: BFA6034A <gemm_reg+0x2164>
	s_nop 0                                                    // 00000000503C: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 000000005040: BFB60003
	s_endpgm                                                   // 000000005044: BFB00000
