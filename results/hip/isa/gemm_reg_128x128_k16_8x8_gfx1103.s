_ZN3clk3hip8gemm_regILi128ELi128ELi16ELi8ELi8ELb0EEEviPKfS3_Pf: ; @_ZN3clk3hip8gemm_regILi128ELi128ELi16ELi8ELi8ELb0EEEviPKfS3_Pf
; %bb.0:                                ; %.preheader131
	s_clause 0x2
	s_load_b32 s16, s[0:1], 0x0
	s_load_b128 s[12:15], s[0:1], 0x8
	s_load_b64 s[10:11], s[0:1], 0x18
	v_bfe_u32 v56, v0, 10, 10
	v_and_b32_e32 v57, 0x3ff, v0
	s_lshl_b32 s17, s3, 7
	s_lshl_b32 s18, s2, 7
	s_waitcnt lgkmcnt(0)
	s_cmp_lt_i32 s16, 1
	s_cbranch_scc1 .LBB40_37
; %bb.1:                                ; %.preheader129.lr.ph
	v_and_b32_e32 v67, 15, v57
	v_lshl_add_u32 v1, v56, 4, v57
	v_lshlrev_b32_e32 v68, 6, v56
	v_lshl_or_b32 v101, v57, 2, 0x2000
	v_dual_mov_b32 v19, 0 :: v_dual_mov_b32 v22, 0
	v_lshlrev_b32_e32 v2, 2, v67
	v_lshrrev_b32_e32 v5, 4, v1
	v_add_nc_u32_e32 v6, 0x200, v1
	v_add_nc_u32_e32 v7, 0x300, v1
	v_add_nc_u32_e32 v4, 0x100, v1
	v_dual_mov_b32 v17, 0 :: v_dual_add_nc_u32 v12, 0x600, v1
	v_add_nc_u32_e32 v9, s17, v5
	v_lshl_or_b32 v69, v5, 6, v2
	v_lshrrev_b32_e32 v11, 4, v7
	v_lshrrev_b32_e32 v91, 7, v7
	v_mov_b32_e32 v7, 0
	v_lshrrev_b32_e32 v5, 4, v6
	v_cmp_gt_i32_e64 s0, s16, v9
	v_mul_lo_u32 v70, v9, s16
	v_lshrrev_b32_e32 v14, 4, v12
	v_lshrrev_b32_e32 v94, 7, v12
	v_add_nc_u32_e32 v9, s17, v5
	v_lshl_or_b32 v74, v5, 6, v2
	v_dual_mov_b32 v12, 0 :: v_dual_add_nc_u32 v5, 0x500, v1
	v_and_b32_e32 v3, 0x7f, v1
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_cmp_gt_i32_e64 s2, s16, v9
	v_mul_lo_u32 v73, v9, s16
	v_lshrrev_b32_e32 v13, 4, v5
	v_lshrrev_b32_e32 v93, 7, v5
	v_mov_b32_e32 v5, 0
	v_lshrrev_b32_e32 v8, 4, v4
	v_lshl_or_b32 v76, v11, 6, v2
	v_dual_mov_b32 v16, 0 :: v_dual_add_nc_u32 v15, s17, v13
	v_lshrrev_b32_e32 v83, 7, v1
	s_delay_alu instid0(VALU_DEP_4)
	v_add_nc_u32_e32 v10, s17, v8
	v_lshl_or_b32 v72, v8, 6, v2
	v_add_nc_u32_e32 v8, s17, v11
	v_add_nc_u32_e32 v11, 0x700, v1
	v_lshrrev_b32_e32 v84, 7, v4
	v_cmp_gt_i32_e64 s1, s16, v10
	v_mul_lo_u32 v71, v10, s16
	v_add_nc_u32_e32 v10, 0x400, v1
	v_cmp_gt_i32_e64 s3, s16, v8
	v_mul_lo_u32 v75, v8, s16
	v_lshrrev_b32_e32 v85, 7, v6
	v_lshrrev_b32_e32 v95, 7, v11
	v_lshrrev_b32_e32 v9, 4, v10
	v_mov_b32_e32 v4, 0
	v_or_b32_e32 v0, s18, v3
	v_lshl_or_b32 v3, v3, 2, 0x2000
	v_cmp_gt_i32_e64 s5, s16, v15
	v_add_nc_u32_e32 v8, s17, v9
	v_mul_lo_u32 v79, v15, s16
	v_mov_b32_e32 v18, 0
	v_lshl_add_u32 v88, v83, 9, v3
	v_lshl_add_u32 v89, v84, 9, v3
	v_cmp_gt_i32_e64 s4, s16, v8
	v_mul_lo_u32 v77, v8, s16
	v_lshrrev_b32_e32 v8, 4, v11
	v_mov_b32_e32 v11, 0
	v_lshrrev_b32_e32 v92, 7, v10
	v_lshl_add_u32 v90, v85, 9, v3
	v_lshl_add_u32 v96, v91, 9, v3
	v_dual_mov_b32 v20, 0 :: v_dual_add_nc_u32 v15, s17, v8
	s_delay_alu instid0(VALU_DEP_4)
	v_lshl_add_u32 v97, v92, 9, v3
	v_lshl_add_u32 v98, v93, 9, v3
	v_lshl_add_u32 v99, v94, 9, v3
	v_lshl_add_u32 v100, v95, 9, v3
	v_mov_b32_e32 v3, 0
	v_lshl_or_b32 v78, v9, 6, v2
	v_add_nc_u32_e32 v9, s17, v14
	v_mul_lo_u32 v86, v15, s16
	v_lshl_or_b32 v80, v13, 6, v2
	v_lshl_or_b32 v82, v14, 6, v2
	v_cmp_gt_i32_e64 s7, s16, v15
	v_mul_lo_u32 v81, v9, s16
	v_cmp_gt_i32_e64 s6, s16, v9
	v_lshl_or_b32 v87, v8, 6, v2
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v2, 0
	v_mov_b32_e32 v6, 0
	v_dual_mov_b32 v8, 0 :: v_dual_mov_b32 v9, 0
	v_dual_mov_b32 v10, 0 :: v_dual_mov_b32 v13, 0
	v_dual_mov_b32 v14, 0 :: v_dual_mov_b32 v15, 0
	v_dual_mov_b32 v21, 0 :: v_dual_mov_b32 v24, 0
	v_dual_mov_b32 v23, 0 :: v_dual_mov_b32 v26, 0
	v_dual_mov_b32 v25, 0 :: v_dual_mov_b32 v28, 0
	v_dual_mov_b32 v27, 0 :: v_dual_mov_b32 v30, 0
	v_dual_mov_b32 v29, 0 :: v_dual_mov_b32 v32, 0
	v_dual_mov_b32 v31, 0 :: v_dual_mov_b32 v34, 0
	v_dual_mov_b32 v33, 0 :: v_dual_mov_b32 v36, 0
	v_dual_mov_b32 v35, 0 :: v_dual_mov_b32 v38, 0
	v_dual_mov_b32 v37, 0 :: v_dual_mov_b32 v40, 0
	v_dual_mov_b32 v39, 0 :: v_dual_mov_b32 v42, 0
	v_dual_mov_b32 v41, 0 :: v_dual_mov_b32 v44, 0
	v_dual_mov_b32 v43, 0 :: v_dual_mov_b32 v46, 0
	v_dual_mov_b32 v45, 0 :: v_dual_mov_b32 v48, 0
	v_dual_mov_b32 v47, 0 :: v_dual_mov_b32 v50, 0
	v_dual_mov_b32 v49, 0 :: v_dual_mov_b32 v52, 0
	v_dual_mov_b32 v51, 0 :: v_dual_mov_b32 v54, 0
	v_dual_mov_b32 v53, 0 :: v_dual_mov_b32 v58, 0
	v_dual_mov_b32 v55, 0 :: v_dual_mov_b32 v60, 0
	v_dual_mov_b32 v59, 0 :: v_dual_mov_b32 v62, 0
	v_dual_mov_b32 v61, 0 :: v_dual_mov_b32 v64, 0
	v_dual_mov_b32 v63, 0 :: v_dual_mov_b32 v66, 0
	v_mov_b32_e32 v65, 0
	s_mov_b32 s19, 0
	v_cmp_gt_i32_e32 vcc_lo, s16, v0
.LBB40_2:                               ; %.preheader129
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB40_35 Depth 2
	v_or_b32_e32 v102, s19, v67
	v_mov_b32_e32 v104, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s8, s16, v102
	s_and_b32 s9, s0, s8
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_4
; %bb.3:                                ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v103, v70, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s9, s12, v103
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9
	global_load_b32 v104, v[103:104], off
.LBB40_4:                               ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	v_mov_b32_e32 v103, 0
	v_mov_b32_e32 v105, 0
	s_and_b32 s9, s1, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v69, v104
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_6
; %bb.5:                                ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v104, v71, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v105, 31, v104
	v_lshlrev_b64 v[104:105], 2, v[104:105]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v104, s9, s12, v104
	v_add_co_ci_u32_e64 v105, null, s13, v105, s9
	global_load_b32 v105, v[104:105], off
.LBB40_6:                               ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	s_and_b32 s9, s2, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v72, v105
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_8
; %bb.7:                                ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v103, v73, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s9, s12, v103
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9
	global_load_b32 v103, v[103:104], off
.LBB40_8:                               ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	v_dual_mov_b32 v104, 0 :: v_dual_mov_b32 v105, 0
	s_and_b32 s9, s3, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v74, v103
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_10
; %bb.9:                                ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v105, v75, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v106, 31, v105
	v_lshlrev_b64 v[105:106], 2, v[105:106]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v105, s9, s12, v105
	v_add_co_ci_u32_e64 v106, null, s13, v106, s9
	global_load_b32 v105, v[105:106], off
.LBB40_10:                              ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	s_and_b32 s9, s4, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v76, v105
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_12
; %bb.11:                               ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v103, v77, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s9, s12, v103
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9
	global_load_b32 v104, v[103:104], off
.LBB40_12:                              ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	v_mov_b32_e32 v105, 0
	v_mov_b32_e32 v103, 0
	s_and_b32 s9, s5, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v78, v104
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_14
; %bb.13:                               ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v103, v79, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s9, s12, v103
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9
	global_load_b32 v103, v[103:104], off
.LBB40_14:                              ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	s_and_b32 s9, s6, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v80, v103
	s_and_saveexec_b32 s20, s9
	s_cbranch_execz .LBB40_16
; %bb.15:                               ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v103, v81, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s9, s12, v103
	v_add_co_ci_u32_e64 v104, null, s13, v104, s9
	global_load_b32 v105, v[103:104], off
.LBB40_16:                              ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s20
	v_dual_mov_b32 v103, 0 :: v_dual_mov_b32 v104, 0
	s_and_b32 s8, s7, s8
	s_waitcnt vmcnt(0)
	ds_store_b32 v82, v105
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_18
; %bb.17:                               ;   in Loop: Header=BB40_2 Depth=1
	v_add_nc_u32_e32 v104, v86, v102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v105, 31, v104
	v_lshlrev_b64 v[104:105], 2, v[104:105]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v104, s8, s12, v104
	v_add_co_ci_u32_e64 v105, null, s13, v105, s8
	global_load_b32 v104, v[104:105], off
.LBB40_18:                              ; %.preheader128.preheader
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_add_nc_u32_e32 v102, s19, v83
	s_waitcnt vmcnt(0)
	ds_store_b32 v87, v104
	v_cmp_gt_i32_e64 s8, s16, v102
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_20
; %bb.19:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[103:104], null, v102, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[102:103], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v102, s8, s14, v102
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8
	global_load_b32 v103, v[102:103], off
.LBB40_20:                              ; %.preheader128.1
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_dual_mov_b32 v102, 0 :: v_dual_add_nc_u32 v105, s19, v84
	v_mov_b32_e32 v104, 0
	s_waitcnt vmcnt(0)
	ds_store_b32 v88, v103
	v_cmp_gt_i32_e64 s8, s16, v105
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_22
; %bb.21:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[103:104], null, v105, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s8, s14, v103
	v_add_co_ci_u32_e64 v104, null, s15, v104, s8
	global_load_b32 v104, v[103:104], off
.LBB40_22:                              ; %.preheader128.2
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_add_nc_u32_e32 v103, s19, v85
	s_waitcnt vmcnt(0)
	ds_store_b32 v89, v104
	v_cmp_gt_i32_e64 s8, s16, v103
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_24
; %bb.23:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[104:105], null, v103, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v105, 31, v104
	v_lshlrev_b64 v[102:103], 2, v[104:105]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v102, s8, s14, v102
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8
	global_load_b32 v102, v[102:103], off
.LBB40_24:                              ; %.preheader128.3
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_dual_mov_b32 v104, 0 :: v_dual_add_nc_u32 v105, s19, v91
	v_mov_b32_e32 v103, 0
	s_waitcnt vmcnt(0)
	ds_store_b32 v90, v102
	v_cmp_gt_i32_e64 s8, s16, v105
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_26
; %bb.25:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[106:107], null, v105, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v107, 31, v106
	v_lshlrev_b64 v[104:105], 2, v[106:107]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v104, s8, s14, v104
	v_add_co_ci_u32_e64 v105, null, s15, v105, s8
	global_load_b32 v104, v[104:105], off
.LBB40_26:                              ; %.preheader128.4
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_add_nc_u32_e32 v102, s19, v92
	s_waitcnt vmcnt(0)
	ds_store_b32 v96, v104
	v_cmp_gt_i32_e64 s8, s16, v102
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_28
; %bb.27:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[103:104], null, v102, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[102:103], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v102, s8, s14, v102
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8
	global_load_b32 v103, v[102:103], off
.LBB40_28:                              ; %.preheader128.5
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_dual_mov_b32 v102, 0 :: v_dual_add_nc_u32 v105, s19, v93
	v_mov_b32_e32 v104, 0
	s_waitcnt vmcnt(0)
	ds_store_b32 v97, v103
	v_cmp_gt_i32_e64 s8, s16, v105
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_30
; %bb.29:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[103:104], null, v105, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v104, 31, v103
	v_lshlrev_b64 v[103:104], 2, v[103:104]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v103, s8, s14, v103
	v_add_co_ci_u32_e64 v104, null, s15, v104, s8
	global_load_b32 v104, v[103:104], off
.LBB40_30:                              ; %.preheader128.6
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_add_nc_u32_e32 v103, s19, v94
	s_waitcnt vmcnt(0)
	ds_store_b32 v98, v104
	v_cmp_gt_i32_e64 s8, s16, v103
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_32
; %bb.31:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[104:105], null, v103, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v105, 31, v104
	v_lshlrev_b64 v[102:103], 2, v[104:105]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v102, s8, s14, v102
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8
	global_load_b32 v102, v[102:103], off
.LBB40_32:                              ; %.preheader128.7
                                        ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_dual_mov_b32 v104, 0 :: v_dual_add_nc_u32 v103, s19, v95
	s_waitcnt vmcnt(0)
	ds_store_b32 v99, v102
	v_cmp_gt_i32_e64 s8, s16, v103
	s_and_b32 s8, s8, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s9, s8
	s_cbranch_execz .LBB40_34
; %bb.33:                               ;   in Loop: Header=BB40_2 Depth=1
	v_mad_u64_u32 v[104:105], null, v103, s16, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v105, 31, v104
	v_lshlrev_b64 v[102:103], 2, v[104:105]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v102, s8, s14, v102
	v_add_co_ci_u32_e64 v103, null, s15, v103, s8
	global_load_b32 v104, v[102:103], off
.LBB40_34:                              ;   in Loop: Header=BB40_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s9
	v_mov_b32_e32 v102, v101
	s_mov_b32 s8, 0
	s_waitcnt vmcnt(0)
	ds_store_b32 v100, v104
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
.LBB40_35:                              ; %.preheader127
                                        ;   Parent Loop BB40_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ds_load_2addr_b32 v[103:104], v102 offset1:16
	ds_load_2addr_b32 v[105:106], v102 offset0:32 offset1:48
	ds_load_2addr_b32 v[107:108], v102 offset0:64 offset1:80
	ds_load_2addr_b32 v[109:110], v102 offset0:96 offset1:112
	v_add_nc_u32_e32 v117, s8, v68
	s_add_i32 s8, s8, 4
	ds_load_2addr_stride64_b32 v[111:112], v117 offset1:4
	ds_load_2addr_stride64_b32 v[113:114], v117 offset0:8 offset1:12
	ds_load_2addr_stride64_b32 v[115:116], v117 offset0:16 offset1:20
	ds_load_2addr_stride64_b32 v[117:118], v117 offset0:24 offset1:28
	v_add_nc_u32_e32 v102, 0x200, v102
	s_cmp_lg_u32 s8, 64
	s_waitcnt lgkmcnt(3)
	v_fmac_f32_e32 v66, v111, v103
	v_fmac_f32_e32 v65, v111, v104
	v_dual_fmac_f32 v64, v111, v105 :: v_dual_fmac_f32 v55, v112, v104
	v_dual_fmac_f32 v63, v111, v106 :: v_dual_fmac_f32 v58, v112, v103
	v_dual_fmac_f32 v62, v111, v107 :: v_dual_fmac_f32 v53, v112, v106
	v_dual_fmac_f32 v61, v111, v108 :: v_dual_fmac_f32 v54, v112, v105
	v_dual_fmac_f32 v60, v111, v109 :: v_dual_fmac_f32 v51, v112, v108
	v_dual_fmac_f32 v59, v111, v110 :: v_dual_fmac_f32 v52, v112, v107
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v50, v112, v109 :: v_dual_fmac_f32 v47, v113, v104
	v_dual_fmac_f32 v49, v112, v110 :: v_dual_fmac_f32 v48, v113, v103
	v_dual_fmac_f32 v46, v113, v105 :: v_dual_fmac_f32 v39, v114, v104
	v_dual_fmac_f32 v45, v113, v106 :: v_dual_fmac_f32 v40, v114, v103
	v_dual_fmac_f32 v44, v113, v107 :: v_dual_fmac_f32 v37, v114, v106
	v_dual_fmac_f32 v43, v113, v108 :: v_dual_fmac_f32 v38, v114, v105
	v_dual_fmac_f32 v42, v113, v109 :: v_dual_fmac_f32 v35, v114, v108
	v_dual_fmac_f32 v41, v113, v110 :: v_dual_fmac_f32 v36, v114, v107
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v34, v114, v109 :: v_dual_fmac_f32 v31, v115, v104
	v_dual_fmac_f32 v33, v114, v110 :: v_dual_fmac_f32 v32, v115, v103
	v_dual_fmac_f32 v30, v115, v105 :: v_dual_fmac_f32 v23, v116, v104
	v_dual_fmac_f32 v29, v115, v106 :: v_dual_fmac_f32 v24, v116, v103
	v_dual_fmac_f32 v28, v115, v107 :: v_dual_fmac_f32 v21, v116, v106
	v_dual_fmac_f32 v27, v115, v108 :: v_dual_fmac_f32 v22, v116, v105
	v_dual_fmac_f32 v26, v115, v109 :: v_dual_fmac_f32 v19, v116, v108
	v_dual_fmac_f32 v25, v115, v110 :: v_dual_fmac_f32 v20, v116, v107
	s_waitcnt lgkmcnt(0)
	v_dual_fmac_f32 v18, v116, v109 :: v_dual_fmac_f32 v15, v117, v104
	v_dual_fmac_f32 v17, v116, v110 :: v_dual_fmac_f32 v16, v117, v103
	v_dual_fmac_f32 v14, v117, v105 :: v_dual_fmac_f32 v7, v118, v104
	v_dual_fmac_f32 v13, v117, v106 :: v_dual_fmac_f32 v8, v118, v103
	v_dual_fmac_f32 v12, v117, v107 :: v_dual_fmac_f32 v5, v118, v106
	v_dual_fmac_f32 v11, v117, v108 :: v_dual_fmac_f32 v6, v118, v105
	v_dual_fmac_f32 v10, v117, v109 :: v_dual_fmac_f32 v3, v118, v108
	v_dual_fmac_f32 v9, v117, v110 :: v_dual_fmac_f32 v4, v118, v107
	v_fmac_f32_e32 v2, v118, v109
	v_fmac_f32_e32 v1, v118, v110
	s_cbranch_scc1 .LBB40_35
; %bb.36:                               ;   in Loop: Header=BB40_2 Depth=1
	s_add_i32 s19, s19, 16
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cmp_ge_i32 s19, s16
	s_barrier
	buffer_gl0_inv
	s_cbranch_scc0 .LBB40_2
	s_branch .LBB40_38
.LBB40_37:
	v_dual_mov_b32 v66, 0 :: v_dual_mov_b32 v65, 0
	v_dual_mov_b32 v64, 0 :: v_dual_mov_b32 v63, 0
	v_dual_mov_b32 v62, 0 :: v_dual_mov_b32 v61, 0
	v_dual_mov_b32 v60, 0 :: v_dual_mov_b32 v59, 0
	v_dual_mov_b32 v58, 0 :: v_dual_mov_b32 v55, 0
	v_dual_mov_b32 v54, 0 :: v_dual_mov_b32 v53, 0
	v_dual_mov_b32 v52, 0 :: v_dual_mov_b32 v51, 0
	v_dual_mov_b32 v50, 0 :: v_dual_mov_b32 v49, 0
	v_dual_mov_b32 v48, 0 :: v_dual_mov_b32 v47, 0
	v_dual_mov_b32 v46, 0 :: v_dual_mov_b32 v45, 0
	v_dual_mov_b32 v44, 0 :: v_dual_mov_b32 v43, 0
	v_dual_mov_b32 v42, 0 :: v_dual_mov_b32 v41, 0
	v_dual_mov_b32 v40, 0 :: v_dual_mov_b32 v39, 0
	v_dual_mov_b32 v38, 0 :: v_dual_mov_b32 v37, 0
	v_dual_mov_b32 v36, 0 :: v_dual_mov_b32 v35, 0
	v_dual_mov_b32 v34, 0 :: v_dual_mov_b32 v33, 0
	v_dual_mov_b32 v32, 0 :: v_dual_mov_b32 v31, 0
	v_dual_mov_b32 v30, 0 :: v_dual_mov_b32 v29, 0
	v_dual_mov_b32 v28, 0 :: v_dual_mov_b32 v27, 0
	v_dual_mov_b32 v26, 0 :: v_dual_mov_b32 v25, 0
	v_dual_mov_b32 v24, 0 :: v_dual_mov_b32 v23, 0
	v_dual_mov_b32 v22, 0 :: v_dual_mov_b32 v21, 0
	v_dual_mov_b32 v20, 0 :: v_dual_mov_b32 v19, 0
	v_dual_mov_b32 v18, 0 :: v_dual_mov_b32 v17, 0
	v_dual_mov_b32 v16, 0 :: v_dual_mov_b32 v15, 0
	v_dual_mov_b32 v14, 0 :: v_dual_mov_b32 v13, 0
	v_dual_mov_b32 v12, 0 :: v_dual_mov_b32 v11, 0
	v_dual_mov_b32 v10, 0 :: v_dual_mov_b32 v9, 0
	v_dual_mov_b32 v8, 0 :: v_dual_mov_b32 v7, 0
	v_dual_mov_b32 v6, 0 :: v_dual_mov_b32 v5, 0
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v3, 0
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, 0
.LBB40_38:                              ; %.preheader123
	v_add_nc_u32_e32 v67, s17, v56
	v_add_nc_u32_e32 v0, s18, v57
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v68, v67, s16
	v_cmp_gt_i32_e64 s7, s16, v67
	v_cmp_gt_i32_e32 vcc_lo, s16, v0
	s_and_b32 s0, s7, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB40_40
; %bb.39:
	v_add_nc_u32_e32 v56, v0, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v57, 31, v56
	v_lshlrev_b64 v[56:57], 2, v[56:57]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v56, s0, s10, v56
	v_add_co_ci_u32_e64 v57, null, s11, v57, s0
	global_store_b32 v[56:57], v66, off
.LBB40_40:
	s_or_b32 exec_lo, exec_lo, s1
	v_add_nc_u32_e32 v56, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s0, s16, v56
	s_and_b32 s1, s7, s0
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB40_42
; %bb.41:
	v_add_nc_u32_e32 v69, v56, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v70, 31, v69
	v_lshlrev_b64 v[69:70], 2, v[69:70]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v69, s1, s10, v69
	v_add_co_ci_u32_e64 v70, null, s11, v70, s1
	global_store_b32 v[69:70], v65, off
.LBB40_42:
	s_or_b32 exec_lo, exec_lo, s2
	v_add_nc_u32_e32 v57, 32, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s1, s16, v57
	s_and_b32 s2, s7, s1
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB40_44
; %bb.43:
	v_add_nc_u32_e32 v65, v57, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s2, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s2
	global_store_b32 v[65:66], v64, off
.LBB40_44:
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v64, 48, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s2, s16, v64
	s_and_b32 s3, s7, s2
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB40_46
; %bb.45:
	v_add_nc_u32_e32 v65, v64, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s3, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s3
	global_store_b32 v[65:66], v63, off
.LBB40_46:
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v63, 64, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s3, s16, v63
	s_and_b32 s4, s7, s3
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB40_48
; %bb.47:
	v_add_nc_u32_e32 v65, v63, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s4, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s4
	global_store_b32 v[65:66], v62, off
.LBB40_48:
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v62, 0x50, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s4, s16, v62
	s_and_b32 s5, s7, s4
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB40_50
; %bb.49:
	v_add_nc_u32_e32 v65, v62, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s5, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s5
	global_store_b32 v[65:66], v61, off
.LBB40_50:
	s_or_b32 exec_lo, exec_lo, s6
	v_add_nc_u32_e32 v61, 0x60, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s5, s16, v61
	s_and_b32 s6, s7, s5
	s_and_saveexec_b32 s8, s6
	s_cbranch_execz .LBB40_52
; %bb.51:
	v_add_nc_u32_e32 v65, v61, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s6, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s6
	global_store_b32 v[65:66], v60, off
.LBB40_52:
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v60, 0x70, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s6, s16, v60
	s_and_b32 s7, s7, s6
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_54
; %bb.53:
	v_add_nc_u32_e32 v65, v60, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s7, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s7
	global_store_b32 v[65:66], v59, off
.LBB40_54:                              ; %.preheader.1
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v59, 16, v67
	s_lshl_b32 s9, s16, 4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v59
	v_add_nc_u32_e32 v59, s9, v68
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_117
; %bb.55:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_118
.LBB40_56:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_119
.LBB40_57:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_120
.LBB40_58:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_121
.LBB40_59:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_122
.LBB40_60:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_123
.LBB40_61:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_63
.LBB40_62:
	v_add_nc_u32_e32 v50, v60, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v51, 31, v50
	v_lshlrev_b64 v[50:51], 2, v[50:51]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v50, s7, s10, v50
	v_add_co_ci_u32_e64 v51, null, s11, v51, s7
	global_store_b32 v[50:51], v49, off
.LBB40_63:                              ; %.preheader.2
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v49, 32, v67
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v49
	v_add_nc_u32_e32 v49, s9, v59
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_124
; %bb.64:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_125
.LBB40_65:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_126
.LBB40_66:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_127
.LBB40_67:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_128
.LBB40_68:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_129
.LBB40_69:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_130
.LBB40_70:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_72
.LBB40_71:
	v_add_nc_u32_e32 v42, v60, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshlrev_b64 v[42:43], 2, v[42:43]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v42, s7, s10, v42
	v_add_co_ci_u32_e64 v43, null, s11, v43, s7
	global_store_b32 v[42:43], v41, off
.LBB40_72:                              ; %.preheader.3
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v41, 48, v67
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v41
	v_add_nc_u32_e32 v41, s9, v49
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_131
; %bb.73:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_132
.LBB40_74:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_133
.LBB40_75:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_134
.LBB40_76:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_135
.LBB40_77:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_136
.LBB40_78:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_137
.LBB40_79:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_81
.LBB40_80:
	v_add_nc_u32_e32 v34, v60, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v35, 31, v34
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v34, s7, s10, v34
	v_add_co_ci_u32_e64 v35, null, s11, v35, s7
	global_store_b32 v[34:35], v33, off
.LBB40_81:                              ; %.preheader.4
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v33, 64, v67
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v33
	v_add_nc_u32_e32 v33, s9, v41
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_138
; %bb.82:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_139
.LBB40_83:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_140
.LBB40_84:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_141
.LBB40_85:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_142
.LBB40_86:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_143
.LBB40_87:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_144
.LBB40_88:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_90
.LBB40_89:
	v_add_nc_u32_e32 v26, v60, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v27, 31, v26
	v_lshlrev_b64 v[26:27], 2, v[26:27]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v26, s7, s10, v26
	v_add_co_ci_u32_e64 v27, null, s11, v27, s7
	global_store_b32 v[26:27], v25, off
.LBB40_90:                              ; %.preheader.5
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v25, 0x50, v67
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v25
	v_add_nc_u32_e32 v25, s9, v33
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_145
; %bb.91:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_146
.LBB40_92:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_147
.LBB40_93:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_148
.LBB40_94:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_149
.LBB40_95:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_150
.LBB40_96:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_151
.LBB40_97:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_99
.LBB40_98:
	v_add_nc_u32_e32 v18, v60, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v19, 31, v18
	v_lshlrev_b64 v[18:19], 2, v[18:19]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v18, s7, s10, v18
	v_add_co_ci_u32_e64 v19, null, s11, v19, s7
	global_store_b32 v[18:19], v17, off
.LBB40_99:                              ; %.preheader.6
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v17, 0x60, v67
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v17
	v_add_nc_u32_e32 v17, s9, v25
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_152
; %bb.100:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_153
.LBB40_101:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_154
.LBB40_102:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_155
.LBB40_103:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_156
.LBB40_104:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_157
.LBB40_105:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execnz .LBB40_158
.LBB40_106:
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB40_108
.LBB40_107:
	v_add_nc_u32_e32 v10, v60, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s10, v10
	v_add_co_ci_u32_e64 v11, null, s11, v11, s7
	global_store_b32 v[10:11], v9, off
.LBB40_108:                             ; %.preheader.7
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v9, 0x70, v67
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s16, v9
	v_add_nc_u32_e32 v9, s9, v17
	s_and_b32 s9, s7, vcc_lo
	s_and_saveexec_b32 s8, s9
	s_cbranch_execnz .LBB40_159
; %bb.109:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s8
	s_cbranch_execnz .LBB40_160
.LBB40_110:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB40_161
.LBB40_111:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB40_162
.LBB40_112:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB40_163
.LBB40_113:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB40_164
.LBB40_114:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB40_165
.LBB40_115:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execnz .LBB40_166
.LBB40_116:
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
.LBB40_117:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v65, v0, v59
	v_ashrrev_i32_e32 v66, 31, v65
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	v_add_co_u32 v65, s8, s10, v65
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v66, null, s11, v66, s8
	global_store_b32 v[65:66], v58, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_56
.LBB40_118:
	v_add_nc_u32_e32 v65, v56, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s8, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s8
	global_store_b32 v[65:66], v55, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_57
.LBB40_119:
	v_add_nc_u32_e32 v65, v57, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v66, 31, v65
	v_lshlrev_b64 v[65:66], 2, v[65:66]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v65, s8, s10, v65
	v_add_co_ci_u32_e64 v66, null, s11, v66, s8
	global_store_b32 v[65:66], v54, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_58
.LBB40_120:
	v_add_nc_u32_e32 v54, v64, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v55, 31, v54
	v_lshlrev_b64 v[54:55], 2, v[54:55]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v54, s8, s10, v54
	v_add_co_ci_u32_e64 v55, null, s11, v55, s8
	global_store_b32 v[54:55], v53, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_59
.LBB40_121:
	v_add_nc_u32_e32 v53, v63, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v54, 31, v53
	v_lshlrev_b64 v[53:54], 2, v[53:54]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v53, s8, s10, v53
	v_add_co_ci_u32_e64 v54, null, s11, v54, s8
	global_store_b32 v[53:54], v52, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_60
.LBB40_122:
	v_add_nc_u32_e32 v52, v62, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v53, 31, v52
	v_lshlrev_b64 v[52:53], 2, v[52:53]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v52, s8, s10, v52
	v_add_co_ci_u32_e64 v53, null, s11, v53, s8
	global_store_b32 v[52:53], v51, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_61
.LBB40_123:
	v_add_nc_u32_e32 v51, v61, v59
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v52, 31, v51
	v_lshlrev_b64 v[51:52], 2, v[51:52]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v51, s8, s10, v51
	v_add_co_ci_u32_e64 v52, null, s11, v52, s8
	global_store_b32 v[51:52], v50, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB40_62
	s_branch .LBB40_63
.LBB40_124:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v50, v0, v49
	v_ashrrev_i32_e32 v51, 31, v50
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[50:51], 2, v[50:51]
	v_add_co_u32 v50, s8, s10, v50
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v51, null, s11, v51, s8
	global_store_b32 v[50:51], v48, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_65
.LBB40_125:
	v_add_nc_u32_e32 v50, v56, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v51, 31, v50
	v_lshlrev_b64 v[50:51], 2, v[50:51]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v50, s8, s10, v50
	v_add_co_ci_u32_e64 v51, null, s11, v51, s8
	global_store_b32 v[50:51], v47, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_66
.LBB40_126:
	v_add_nc_u32_e32 v47, v57, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v48, 31, v47
	v_lshlrev_b64 v[47:48], 2, v[47:48]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v47, s8, s10, v47
	v_add_co_ci_u32_e64 v48, null, s11, v48, s8
	global_store_b32 v[47:48], v46, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_67
.LBB40_127:
	v_add_nc_u32_e32 v46, v64, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v47, 31, v46
	v_lshlrev_b64 v[46:47], 2, v[46:47]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v46, s8, s10, v46
	v_add_co_ci_u32_e64 v47, null, s11, v47, s8
	global_store_b32 v[46:47], v45, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_68
.LBB40_128:
	v_add_nc_u32_e32 v45, v63, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v46, 31, v45
	v_lshlrev_b64 v[45:46], 2, v[45:46]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v45, s8, s10, v45
	v_add_co_ci_u32_e64 v46, null, s11, v46, s8
	global_store_b32 v[45:46], v44, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_69
.LBB40_129:
	v_add_nc_u32_e32 v44, v62, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v45, 31, v44
	v_lshlrev_b64 v[44:45], 2, v[44:45]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v44, s8, s10, v44
	v_add_co_ci_u32_e64 v45, null, s11, v45, s8
	global_store_b32 v[44:45], v43, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_70
.LBB40_130:
	v_add_nc_u32_e32 v43, v61, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v44, 31, v43
	v_lshlrev_b64 v[43:44], 2, v[43:44]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v43, s8, s10, v43
	v_add_co_ci_u32_e64 v44, null, s11, v44, s8
	global_store_b32 v[43:44], v42, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB40_71
	s_branch .LBB40_72
.LBB40_131:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v42, v0, v41
	v_ashrrev_i32_e32 v43, 31, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[42:43], 2, v[42:43]
	v_add_co_u32 v42, s8, s10, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v43, null, s11, v43, s8
	global_store_b32 v[42:43], v40, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_74
.LBB40_132:
	v_add_nc_u32_e32 v42, v56, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshlrev_b64 v[42:43], 2, v[42:43]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v42, s8, s10, v42
	v_add_co_ci_u32_e64 v43, null, s11, v43, s8
	global_store_b32 v[42:43], v39, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_75
.LBB40_133:
	v_add_nc_u32_e32 v39, v57, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v40, 31, v39
	v_lshlrev_b64 v[39:40], 2, v[39:40]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v39, s8, s10, v39
	v_add_co_ci_u32_e64 v40, null, s11, v40, s8
	global_store_b32 v[39:40], v38, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_76
.LBB40_134:
	v_add_nc_u32_e32 v38, v64, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v39, 31, v38
	v_lshlrev_b64 v[38:39], 2, v[38:39]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v38, s8, s10, v38
	v_add_co_ci_u32_e64 v39, null, s11, v39, s8
	global_store_b32 v[38:39], v37, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_77
.LBB40_135:
	v_add_nc_u32_e32 v37, v63, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v38, 31, v37
	v_lshlrev_b64 v[37:38], 2, v[37:38]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v37, s8, s10, v37
	v_add_co_ci_u32_e64 v38, null, s11, v38, s8
	global_store_b32 v[37:38], v36, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_78
.LBB40_136:
	v_add_nc_u32_e32 v36, v62, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v37, 31, v36
	v_lshlrev_b64 v[36:37], 2, v[36:37]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v36, s8, s10, v36
	v_add_co_ci_u32_e64 v37, null, s11, v37, s8
	global_store_b32 v[36:37], v35, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_79
.LBB40_137:
	v_add_nc_u32_e32 v35, v61, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v36, 31, v35
	v_lshlrev_b64 v[35:36], 2, v[35:36]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v35, s8, s10, v35
	v_add_co_ci_u32_e64 v36, null, s11, v36, s8
	global_store_b32 v[35:36], v34, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB40_80
	s_branch .LBB40_81
.LBB40_138:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v34, v0, v33
	v_ashrrev_i32_e32 v35, 31, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	v_add_co_u32 v34, s8, s10, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v35, null, s11, v35, s8
	global_store_b32 v[34:35], v32, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_83
.LBB40_139:
	v_add_nc_u32_e32 v34, v56, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v35, 31, v34
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v34, s8, s10, v34
	v_add_co_ci_u32_e64 v35, null, s11, v35, s8
	global_store_b32 v[34:35], v31, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_84
.LBB40_140:
	v_add_nc_u32_e32 v31, v57, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v32, 31, v31
	v_lshlrev_b64 v[31:32], 2, v[31:32]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v31, s8, s10, v31
	v_add_co_ci_u32_e64 v32, null, s11, v32, s8
	global_store_b32 v[31:32], v30, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_85
.LBB40_141:
	v_add_nc_u32_e32 v30, v64, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v31, 31, v30
	v_lshlrev_b64 v[30:31], 2, v[30:31]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v30, s8, s10, v30
	v_add_co_ci_u32_e64 v31, null, s11, v31, s8
	global_store_b32 v[30:31], v29, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_86
.LBB40_142:
	v_add_nc_u32_e32 v29, v63, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v30, 31, v29
	v_lshlrev_b64 v[29:30], 2, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v29, s8, s10, v29
	v_add_co_ci_u32_e64 v30, null, s11, v30, s8
	global_store_b32 v[29:30], v28, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_87
.LBB40_143:
	v_add_nc_u32_e32 v28, v62, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 31, v28
	v_lshlrev_b64 v[28:29], 2, v[28:29]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v28, s8, s10, v28
	v_add_co_ci_u32_e64 v29, null, s11, v29, s8
	global_store_b32 v[28:29], v27, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_88
.LBB40_144:
	v_add_nc_u32_e32 v27, v61, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v28, 31, v27
	v_lshlrev_b64 v[27:28], 2, v[27:28]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v27, s8, s10, v27
	v_add_co_ci_u32_e64 v28, null, s11, v28, s8
	global_store_b32 v[27:28], v26, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB40_89
	s_branch .LBB40_90
.LBB40_145:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v26, v0, v25
	v_ashrrev_i32_e32 v27, 31, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[26:27], 2, v[26:27]
	v_add_co_u32 v26, s8, s10, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v27, null, s11, v27, s8
	global_store_b32 v[26:27], v24, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_92
.LBB40_146:
	v_add_nc_u32_e32 v26, v56, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v27, 31, v26
	v_lshlrev_b64 v[26:27], 2, v[26:27]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v26, s8, s10, v26
	v_add_co_ci_u32_e64 v27, null, s11, v27, s8
	global_store_b32 v[26:27], v23, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_93
.LBB40_147:
	v_add_nc_u32_e32 v23, v57, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v24, 31, v23
	v_lshlrev_b64 v[23:24], 2, v[23:24]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v23, s8, s10, v23
	v_add_co_ci_u32_e64 v24, null, s11, v24, s8
	global_store_b32 v[23:24], v22, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_94
.LBB40_148:
	v_add_nc_u32_e32 v22, v64, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v23, 31, v22
	v_lshlrev_b64 v[22:23], 2, v[22:23]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v22, s8, s10, v22
	v_add_co_ci_u32_e64 v23, null, s11, v23, s8
	global_store_b32 v[22:23], v21, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_95
.LBB40_149:
	v_add_nc_u32_e32 v21, v63, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v22, 31, v21
	v_lshlrev_b64 v[21:22], 2, v[21:22]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v21, s8, s10, v21
	v_add_co_ci_u32_e64 v22, null, s11, v22, s8
	global_store_b32 v[21:22], v20, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_96
.LBB40_150:
	v_add_nc_u32_e32 v20, v62, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v21, 31, v20
	v_lshlrev_b64 v[20:21], 2, v[20:21]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v20, s8, s10, v20
	v_add_co_ci_u32_e64 v21, null, s11, v21, s8
	global_store_b32 v[20:21], v19, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_97
.LBB40_151:
	v_add_nc_u32_e32 v19, v61, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v20, 31, v19
	v_lshlrev_b64 v[19:20], 2, v[19:20]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v19, s8, s10, v19
	v_add_co_ci_u32_e64 v20, null, s11, v20, s8
	global_store_b32 v[19:20], v18, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB40_98
	s_branch .LBB40_99
.LBB40_152:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v18, v0, v17
	v_ashrrev_i32_e32 v19, 31, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[18:19], 2, v[18:19]
	v_add_co_u32 v18, s8, s10, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v19, null, s11, v19, s8
	global_store_b32 v[18:19], v16, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_101
.LBB40_153:
	v_add_nc_u32_e32 v18, v56, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v19, 31, v18
	v_lshlrev_b64 v[18:19], 2, v[18:19]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v18, s8, s10, v18
	v_add_co_ci_u32_e64 v19, null, s11, v19, s8
	global_store_b32 v[18:19], v15, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_102
.LBB40_154:
	v_add_nc_u32_e32 v15, v57, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v16, 31, v15
	v_lshlrev_b64 v[15:16], 2, v[15:16]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v15, s8, s10, v15
	v_add_co_ci_u32_e64 v16, null, s11, v16, s8
	global_store_b32 v[15:16], v14, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_103
.LBB40_155:
	v_add_nc_u32_e32 v14, v64, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v15, 31, v14
	v_lshlrev_b64 v[14:15], 2, v[14:15]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v14, s8, s10, v14
	v_add_co_ci_u32_e64 v15, null, s11, v15, s8
	global_store_b32 v[14:15], v13, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_104
.LBB40_156:
	v_add_nc_u32_e32 v13, v63, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v14, 31, v13
	v_lshlrev_b64 v[13:14], 2, v[13:14]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v13, s8, s10, v13
	v_add_co_ci_u32_e64 v14, null, s11, v14, s8
	global_store_b32 v[13:14], v12, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_105
.LBB40_157:
	v_add_nc_u32_e32 v12, v62, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v13, 31, v12
	v_lshlrev_b64 v[12:13], 2, v[12:13]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v12, s8, s10, v12
	v_add_co_ci_u32_e64 v13, null, s11, v13, s8
	global_store_b32 v[12:13], v11, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s12, s8
	s_cbranch_execz .LBB40_106
.LBB40_158:
	v_add_nc_u32_e32 v11, v61, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v12, 31, v11
	v_lshlrev_b64 v[11:12], 2, v[11:12]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v11, s8, s10, v11
	v_add_co_ci_u32_e64 v12, null, s11, v12, s8
	global_store_b32 v[11:12], v10, off
	s_or_b32 exec_lo, exec_lo, s12
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB40_107
	s_branch .LBB40_108
.LBB40_159:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v10, v0, v9
	v_ashrrev_i32_e32 v11, 31, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	v_add_co_u32 v10, vcc_lo, s10, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v11, null, s11, v11, vcc_lo
	global_store_b32 v[10:11], v8, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s0, s8
	s_cbranch_execz .LBB40_110
.LBB40_160:
	v_add_nc_u32_e32 v10, v56, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, vcc_lo, s10, v10
	v_add_co_ci_u32_e64 v11, null, s11, v11, vcc_lo
	global_store_b32 v[10:11], v7, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB40_111
.LBB40_161:
	v_add_nc_u32_e32 v7, v57, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v8, 31, v7
	v_lshlrev_b64 v[7:8], 2, v[7:8]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v7, vcc_lo, s10, v7
	v_add_co_ci_u32_e64 v8, null, s11, v8, vcc_lo
	global_store_b32 v[7:8], v6, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB40_112
.LBB40_162:
	v_add_nc_u32_e32 v6, v64, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, vcc_lo, s10, v6
	v_add_co_ci_u32_e64 v7, null, s11, v7, vcc_lo
	global_store_b32 v[6:7], v5, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB40_113
.LBB40_163:
	v_add_nc_u32_e32 v5, v63, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64 v[5:6], 2, v[5:6]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v5, vcc_lo, s10, v5
	v_add_co_ci_u32_e64 v6, null, s11, v6, vcc_lo
	global_store_b32 v[5:6], v4, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB40_114
.LBB40_164:
	v_add_nc_u32_e32 v4, v62, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshlrev_b64 v[4:5], 2, v[4:5]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v4, vcc_lo, s10, v4
	v_add_co_ci_u32_e64 v5, null, s11, v5, vcc_lo
	global_store_b32 v[4:5], v3, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB40_115
.LBB40_165:
	v_add_nc_u32_e32 v3, v61, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v4, 31, v3
	v_lshlrev_b64 v[3:4], 2, v[3:4]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v3, vcc_lo, s10, v3
	v_add_co_ci_u32_e64 v4, null, s11, v4, vcc_lo
	global_store_b32 v[3:4], v2, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB40_116
.LBB40_166:
	v_add_nc_u32_e32 v2, v60, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, vcc_lo, s10, v2
	v_add_co_ci_u32_e64 v3, null, s11, v3, vcc_lo
	global_store_b32 v[2:3], v1, off
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _ZN3clk3hip8gemm_regILi128ELi128ELi16ELi8ELi8ELb0EEEviPKfS3_Pf
		.amdhsa_group_segment_fixed_size 16384
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 32
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 119
		.amdhsa_next_free_sgpr 21
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 63
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._ZN3clk3hip8gemm_regILi128ELi128ELi16ELi8ELi8ELb0EEEviPKfS3_Pf,"axG",@progbits,_ZN3clk3hip8gemm_regILi128ELi128ELi16ELi8ELi8ELb0EEEviPKfS3_Pf,comdat
