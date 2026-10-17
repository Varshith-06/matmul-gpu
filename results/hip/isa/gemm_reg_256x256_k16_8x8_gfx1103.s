_ZN3clk3hip8gemm_regILi256ELi256ELi16ELi8ELi8ELb0EEEviPKfS3_Pf: ; @_ZN3clk3hip8gemm_regILi256ELi256ELi16ELi8ELi8ELb0EEEviPKfS3_Pf
; %bb.0:                                ; %.preheader126
	s_clause 0x2
	s_load_b32 s14, s[0:1], 0x0
	s_load_b128 s[8:11], s[0:1], 0x8
	s_load_b64 s[12:13], s[0:1], 0x18
	v_bfe_u32 v59, v0, 10, 10
	v_and_b32_e32 v60, 0x3ff, v0
	s_lshl_b32 s6, s3, 8
	s_lshl_b32 s7, s2, 8
	s_waitcnt lgkmcnt(0)
	s_cmp_lt_i32 s14, 1
	s_cbranch_scc1 .LBB52_21
; %bb.1:                                ; %.preheader124.lr.ph
	v_lshl_add_u32 v1, v59, 5, v60
	v_dual_mov_b32 v17, 0 :: v_dual_and_b32 v62, 15, v60
	v_dual_mov_b32 v19, 0 :: v_dual_lshlrev_b32 v68, 6, v59
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v4, 4, v1
	v_dual_mov_b32 v20, 0 :: v_dual_add_nc_u32 v5, 0x400, v1
	v_dual_mov_b32 v23, 0 :: v_dual_add_nc_u32 v6, 0x800, v1
	v_dual_mov_b32 v22, 0 :: v_dual_add_nc_u32 v7, 0xc00, v1
	v_dual_mov_b32 v25, 0 :: v_dual_add_nc_u32 v8, s6, v4
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v9, 4, v5
	v_dual_mov_b32 v21, 0 :: v_dual_lshlrev_b32 v2, 2, v62
	v_lshrrev_b32_e32 v10, 4, v6
	v_cmp_gt_i32_e64 s0, s14, v8
	s_delay_alu instid0(VALU_DEP_4)
	v_dual_mov_b32 v24, 0 :: v_dual_add_nc_u32 v11, s6, v9
	v_mul_lo_u32 v69, v8, s14
	v_lshrrev_b32_e32 v8, 4, v7
	v_dual_mov_b32 v18, 0 :: v_dual_and_b32 v3, 0xff, v1
	v_lshl_or_b32 v70, v4, 6, v2
	v_dual_mov_b32 v27, 0 :: v_dual_add_nc_u32 v4, s6, v10
	v_cmp_gt_i32_e64 s1, s14, v11
	v_mul_lo_u32 v71, v11, s14
	v_dual_mov_b32 v26, 0 :: v_dual_add_nc_u32 v11, s6, v8
	v_or_b32_e32 v0, s7, v3
	v_lshl_or_b32 v3, v3, 2, 0x4000
	v_lshrrev_b32_e32 v76, 8, v1
	v_lshrrev_b32_e32 v77, 8, v5
	v_lshrrev_b32_e32 v78, 8, v6
	v_lshrrev_b32_e32 v79, 8, v7
	v_mul_lo_u32 v73, v4, s14
	v_mul_lo_u32 v75, v11, s14
	v_lshl_or_b32 v72, v9, 6, v2
	v_cmp_gt_i32_e64 s2, s14, v4
	v_lshl_or_b32 v74, v10, 6, v2
	v_cmp_gt_i32_e64 s3, s14, v11
	v_lshl_or_b32 v80, v8, 6, v2
	v_lshl_add_u32 v81, v76, 10, v3
	v_lshl_add_u32 v82, v77, 10, v3
	v_lshl_add_u32 v83, v78, 10, v3
	v_lshl_add_u32 v84, v79, 10, v3
	v_lshl_or_b32 v85, v60, 2, 0x4000
	v_dual_mov_b32 v28, 0 :: v_dual_mov_b32 v29, 0
	v_dual_mov_b32 v30, 0 :: v_dual_mov_b32 v31, 0
	v_dual_mov_b32 v32, 0 :: v_dual_mov_b32 v33, 0
	v_dual_mov_b32 v34, 0 :: v_dual_mov_b32 v35, 0
	v_dual_mov_b32 v36, 0 :: v_dual_mov_b32 v37, 0
	v_dual_mov_b32 v38, 0 :: v_dual_mov_b32 v39, 0
	v_dual_mov_b32 v40, 0 :: v_dual_mov_b32 v41, 0
	v_dual_mov_b32 v42, 0 :: v_dual_mov_b32 v43, 0
	v_dual_mov_b32 v44, 0 :: v_dual_mov_b32 v45, 0
	v_dual_mov_b32 v46, 0 :: v_dual_mov_b32 v47, 0
	v_dual_mov_b32 v48, 0 :: v_dual_mov_b32 v49, 0
	v_dual_mov_b32 v50, 0 :: v_dual_mov_b32 v51, 0
	v_dual_mov_b32 v52, 0 :: v_dual_mov_b32 v53, 0
	v_dual_mov_b32 v54, 0 :: v_dual_mov_b32 v55, 0
	v_dual_mov_b32 v56, 0 :: v_dual_mov_b32 v57, 0
	v_dual_mov_b32 v58, 0 :: v_dual_mov_b32 v63, 0
	v_dual_mov_b32 v65, 0 :: v_dual_mov_b32 v64, 0
	v_dual_mov_b32 v61, 0 :: v_dual_mov_b32 v66, 0
	v_dual_mov_b32 v67, 0 :: v_dual_mov_b32 v16, 0
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v14, 0
	v_dual_mov_b32 v13, 0 :: v_dual_mov_b32 v12, 0
	v_dual_mov_b32 v11, 0 :: v_dual_mov_b32 v10, 0
	v_dual_mov_b32 v9, 0 :: v_dual_mov_b32 v8, 0
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v6, 0
	v_dual_mov_b32 v5, 0 :: v_dual_mov_b32 v4, 0
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v2, 0
	v_mov_b32_e32 v1, 0
	s_mov_b32 s15, 0
	v_cmp_gt_i32_e32 vcc_lo, s14, v0
.LBB52_2:                               ; %.preheader124
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB52_19 Depth 2
	v_or_b32_e32 v86, s15, v62
	v_mov_b32_e32 v87, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s4, s14, v86
	s_and_b32 s5, s0, s4
	s_and_saveexec_b32 s16, s5
	s_cbranch_execz .LBB52_4
; %bb.3:                                ;   in Loop: Header=BB52_2 Depth=1
	v_add_nc_u32_e32 v87, v69, v86
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v88, 31, v87
	v_lshlrev_b64 v[87:88], 2, v[87:88]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v87, s5, s8, v87
	v_add_co_ci_u32_e64 v88, null, s9, v88, s5
	global_load_b32 v87, v[87:88], off
.LBB52_4:                               ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s16
	v_dual_mov_b32 v88, 0 :: v_dual_mov_b32 v89, 0
	s_and_b32 s5, s1, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v70, v87
	s_and_saveexec_b32 s16, s5
	s_cbranch_execz .LBB52_6
; %bb.5:                                ;   in Loop: Header=BB52_2 Depth=1
	v_add_nc_u32_e32 v89, v71, v86
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v90, 31, v89
	v_lshlrev_b64 v[89:90], 2, v[89:90]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v89, s5, s8, v89
	v_add_co_ci_u32_e64 v90, null, s9, v90, s5
	global_load_b32 v89, v[89:90], off
.LBB52_6:                               ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s16
	s_and_b32 s5, s2, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v72, v89
	s_and_saveexec_b32 s16, s5
	s_cbranch_execz .LBB52_8
; %bb.7:                                ;   in Loop: Header=BB52_2 Depth=1
	v_add_nc_u32_e32 v87, v73, v86
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v88, 31, v87
	v_lshlrev_b64 v[87:88], 2, v[87:88]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v87, s5, s8, v87
	v_add_co_ci_u32_e64 v88, null, s9, v88, s5
	global_load_b32 v88, v[87:88], off
.LBB52_8:                               ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s16
	v_mov_b32_e32 v87, 0
	v_mov_b32_e32 v89, 0
	s_and_b32 s4, s3, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v74, v88
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB52_10
; %bb.9:                                ;   in Loop: Header=BB52_2 Depth=1
	v_add_nc_u32_e32 v88, v75, v86
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v89, 31, v88
	v_lshlrev_b64 v[88:89], 2, v[88:89]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v88, s4, s8, v88
	v_add_co_ci_u32_e64 v89, null, s9, v89, s4
	global_load_b32 v89, v[88:89], off
.LBB52_10:                              ; %.preheader123.preheader
                                        ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v86, s15, v76
	s_waitcnt vmcnt(0)
	ds_store_b32 v80, v89
	v_cmp_gt_i32_e64 s4, s14, v86
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB52_12
; %bb.11:                               ;   in Loop: Header=BB52_2 Depth=1
	v_mad_u64_u32 v[87:88], null, v86, s14, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v88, 31, v87
	v_lshlrev_b64 v[86:87], 2, v[87:88]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v86, s4, s10, v86
	v_add_co_ci_u32_e64 v87, null, s11, v87, s4
	global_load_b32 v87, v[86:87], off
.LBB52_12:                              ; %.preheader123.1
                                        ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_dual_mov_b32 v86, 0 :: v_dual_add_nc_u32 v89, s15, v77
	v_mov_b32_e32 v88, 0
	s_waitcnt vmcnt(0)
	ds_store_b32 v81, v87
	v_cmp_gt_i32_e64 s4, s14, v89
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB52_14
; %bb.13:                               ;   in Loop: Header=BB52_2 Depth=1
	v_mad_u64_u32 v[87:88], null, v89, s14, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v88, 31, v87
	v_lshlrev_b64 v[87:88], 2, v[87:88]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v87, s4, s10, v87
	v_add_co_ci_u32_e64 v88, null, s11, v88, s4
	global_load_b32 v88, v[87:88], off
.LBB52_14:                              ; %.preheader123.2
                                        ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v87, s15, v78
	s_waitcnt vmcnt(0)
	ds_store_b32 v82, v88
	v_cmp_gt_i32_e64 s4, s14, v87
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB52_16
; %bb.15:                               ;   in Loop: Header=BB52_2 Depth=1
	v_mad_u64_u32 v[88:89], null, v87, s14, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v89, 31, v88
	v_lshlrev_b64 v[86:87], 2, v[88:89]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v86, s4, s10, v86
	v_add_co_ci_u32_e64 v87, null, s11, v87, s4
	global_load_b32 v86, v[86:87], off
.LBB52_16:                              ; %.preheader123.3
                                        ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_dual_mov_b32 v88, 0 :: v_dual_add_nc_u32 v87, s15, v79
	s_waitcnt vmcnt(0)
	ds_store_b32 v83, v86
	v_cmp_gt_i32_e64 s4, s14, v87
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB52_18
; %bb.17:                               ;   in Loop: Header=BB52_2 Depth=1
	v_mad_u64_u32 v[88:89], null, v87, s14, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v89, 31, v88
	v_lshlrev_b64 v[86:87], 2, v[88:89]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v86, s4, s10, v86
	v_add_co_ci_u32_e64 v87, null, s11, v87, s4
	global_load_b32 v88, v[86:87], off
.LBB52_18:                              ;   in Loop: Header=BB52_2 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_mov_b32_e32 v86, v85
	s_mov_b32 s4, 0
	s_waitcnt vmcnt(0)
	ds_store_b32 v84, v88
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
.LBB52_19:                              ; %.preheader122
                                        ;   Parent Loop BB52_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ds_load_2addr_b32 v[87:88], v86 offset1:32
	ds_load_2addr_b32 v[89:90], v86 offset0:64 offset1:96
	ds_load_2addr_b32 v[91:92], v86 offset0:128 offset1:160
	ds_load_2addr_b32 v[93:94], v86 offset0:192 offset1:224
	v_add_nc_u32_e32 v101, s4, v68
	s_add_i32 s4, s4, 4
	ds_load_2addr_stride64_b32 v[95:96], v101 offset1:8
	ds_load_2addr_stride64_b32 v[97:98], v101 offset0:16 offset1:24
	ds_load_2addr_stride64_b32 v[99:100], v101 offset0:32 offset1:40
	ds_load_2addr_stride64_b32 v[101:102], v101 offset0:48 offset1:56
	v_add_nc_u32_e32 v86, 0x400, v86
	s_cmp_lg_u32 s4, 64
	s_waitcnt lgkmcnt(3)
	v_fmac_f32_e32 v67, v95, v87
	v_dual_fmac_f32 v66, v95, v88 :: v_dual_fmac_f32 v53, v96, v90
	v_dual_fmac_f32 v61, v95, v89 :: v_dual_fmac_f32 v56, v96, v87
	v_fmac_f32_e32 v64, v95, v90
	v_dual_fmac_f32 v65, v95, v91 :: v_dual_fmac_f32 v54, v96, v89
	v_dual_fmac_f32 v63, v95, v92 :: v_dual_fmac_f32 v52, v96, v91
	v_dual_fmac_f32 v58, v95, v93 :: v_dual_fmac_f32 v55, v96, v88
	v_dual_fmac_f32 v57, v95, v94 :: v_dual_fmac_f32 v50, v96, v93
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v51, v96, v92 :: v_dual_fmac_f32 v48, v97, v87
	v_dual_fmac_f32 v49, v96, v94 :: v_dual_fmac_f32 v46, v97, v89
	v_dual_fmac_f32 v47, v97, v88 :: v_dual_fmac_f32 v40, v98, v87
	v_dual_fmac_f32 v45, v97, v90 :: v_dual_fmac_f32 v38, v98, v89
	v_dual_fmac_f32 v44, v97, v91 :: v_dual_fmac_f32 v39, v98, v88
	v_dual_fmac_f32 v43, v97, v92 :: v_dual_fmac_f32 v36, v98, v91
	v_dual_fmac_f32 v42, v97, v93 :: v_dual_fmac_f32 v37, v98, v90
	v_dual_fmac_f32 v41, v97, v94 :: v_dual_fmac_f32 v34, v98, v93
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v35, v98, v92 :: v_dual_fmac_f32 v32, v99, v87
	v_dual_fmac_f32 v33, v98, v94 :: v_dual_fmac_f32 v30, v99, v89
	v_dual_fmac_f32 v31, v99, v88 :: v_dual_fmac_f32 v24, v100, v87
	v_dual_fmac_f32 v29, v99, v90 :: v_dual_fmac_f32 v22, v100, v89
	v_dual_fmac_f32 v28, v99, v91 :: v_dual_fmac_f32 v23, v100, v88
	v_dual_fmac_f32 v27, v99, v92 :: v_dual_fmac_f32 v20, v100, v91
	v_dual_fmac_f32 v26, v99, v93 :: v_dual_fmac_f32 v21, v100, v90
	v_dual_fmac_f32 v25, v99, v94 :: v_dual_fmac_f32 v18, v100, v93
	s_waitcnt lgkmcnt(0)
	v_dual_fmac_f32 v19, v100, v92 :: v_dual_fmac_f32 v16, v101, v87
	v_dual_fmac_f32 v17, v100, v94 :: v_dual_fmac_f32 v14, v101, v89
	v_dual_fmac_f32 v15, v101, v88 :: v_dual_fmac_f32 v8, v102, v87
	v_dual_fmac_f32 v13, v101, v90 :: v_dual_fmac_f32 v6, v102, v89
	v_dual_fmac_f32 v12, v101, v91 :: v_dual_fmac_f32 v7, v102, v88
	v_dual_fmac_f32 v11, v101, v92 :: v_dual_fmac_f32 v4, v102, v91
	v_dual_fmac_f32 v10, v101, v93 :: v_dual_fmac_f32 v5, v102, v90
	v_dual_fmac_f32 v9, v101, v94 :: v_dual_fmac_f32 v2, v102, v93
	v_fmac_f32_e32 v3, v102, v92
	v_fmac_f32_e32 v1, v102, v94
	s_cbranch_scc1 .LBB52_19
; %bb.20:                               ;   in Loop: Header=BB52_2 Depth=1
	s_add_i32 s15, s15, 16
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cmp_ge_i32 s15, s14
	s_barrier
	buffer_gl0_inv
	s_cbranch_scc0 .LBB52_2
	s_branch .LBB52_22
.LBB52_21:
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v2, 0
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v4, 0
	v_dual_mov_b32 v5, 0 :: v_dual_mov_b32 v6, 0
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v8, 0
	v_dual_mov_b32 v9, 0 :: v_dual_mov_b32 v10, 0
	v_dual_mov_b32 v11, 0 :: v_dual_mov_b32 v12, 0
	v_dual_mov_b32 v13, 0 :: v_dual_mov_b32 v14, 0
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0
	v_dual_mov_b32 v67, 0 :: v_dual_mov_b32 v66, 0
	v_dual_mov_b32 v61, 0 :: v_dual_mov_b32 v64, 0
	v_dual_mov_b32 v65, 0 :: v_dual_mov_b32 v58, 0
	v_dual_mov_b32 v63, 0 :: v_dual_mov_b32 v56, 0
	v_dual_mov_b32 v57, 0 :: v_dual_mov_b32 v54, 0
	v_dual_mov_b32 v55, 0 :: v_dual_mov_b32 v52, 0
	v_dual_mov_b32 v53, 0 :: v_dual_mov_b32 v50, 0
	v_dual_mov_b32 v51, 0 :: v_dual_mov_b32 v48, 0
	v_dual_mov_b32 v49, 0 :: v_dual_mov_b32 v46, 0
	v_dual_mov_b32 v47, 0 :: v_dual_mov_b32 v44, 0
	v_dual_mov_b32 v45, 0 :: v_dual_mov_b32 v42, 0
	v_dual_mov_b32 v43, 0 :: v_dual_mov_b32 v40, 0
	v_dual_mov_b32 v41, 0 :: v_dual_mov_b32 v38, 0
	v_dual_mov_b32 v39, 0 :: v_dual_mov_b32 v36, 0
	v_dual_mov_b32 v37, 0 :: v_dual_mov_b32 v34, 0
	v_dual_mov_b32 v35, 0 :: v_dual_mov_b32 v32, 0
	v_dual_mov_b32 v33, 0 :: v_dual_mov_b32 v30, 0
	v_dual_mov_b32 v31, 0 :: v_dual_mov_b32 v28, 0
	v_dual_mov_b32 v29, 0 :: v_dual_mov_b32 v26, 0
	v_dual_mov_b32 v27, 0 :: v_dual_mov_b32 v24, 0
	v_dual_mov_b32 v25, 0 :: v_dual_mov_b32 v22, 0
	v_dual_mov_b32 v23, 0 :: v_dual_mov_b32 v20, 0
	v_dual_mov_b32 v21, 0 :: v_dual_mov_b32 v18, 0
	v_mov_b32_e32 v19, 0
	v_mov_b32_e32 v17, 0
.LBB52_22:                              ; %.preheader118
	v_add_nc_u32_e32 v62, s6, v59
	v_add_nc_u32_e32 v0, s7, v60
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v68, v62, s14
	v_cmp_gt_i32_e64 s7, s14, v62
	v_cmp_gt_i32_e32 vcc_lo, s14, v0
	s_and_b32 s0, s7, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB52_24
; %bb.23:
	v_add_nc_u32_e32 v59, v0, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v60, 31, v59
	v_lshlrev_b64 v[59:60], 2, v[59:60]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v59, s0, s12, v59
	v_add_co_ci_u32_e64 v60, null, s13, v60, s0
	global_store_b32 v[59:60], v67, off
.LBB52_24:
	s_or_b32 exec_lo, exec_lo, s1
	v_add_nc_u32_e32 v59, 32, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s0, s14, v59
	s_and_b32 s1, s7, s0
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB52_26
; %bb.25:
	v_add_nc_u32_e32 v69, v59, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v70, 31, v69
	v_lshlrev_b64 v[69:70], 2, v[69:70]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v69, s1, s12, v69
	v_add_co_ci_u32_e64 v70, null, s13, v70, s1
	global_store_b32 v[69:70], v66, off
.LBB52_26:
	s_or_b32 exec_lo, exec_lo, s2
	v_add_nc_u32_e32 v60, 64, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s1, s14, v60
	s_and_b32 s2, s7, s1
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB52_28
; %bb.27:
	v_add_nc_u32_e32 v66, v60, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s2, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s2
	global_store_b32 v[66:67], v61, off
.LBB52_28:
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v61, 0x60, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s2, s14, v61
	s_and_b32 s3, s7, s2
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB52_30
; %bb.29:
	v_add_nc_u32_e32 v66, v61, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s3, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s3
	global_store_b32 v[66:67], v64, off
.LBB52_30:
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v64, 0x80, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s3, s14, v64
	s_and_b32 s4, s7, s3
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB52_32
; %bb.31:
	v_add_nc_u32_e32 v66, v64, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s4, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s4
	global_store_b32 v[66:67], v65, off
.LBB52_32:
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v65, 0xa0, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s4, s14, v65
	s_and_b32 s5, s7, s4
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB52_34
; %bb.33:
	v_add_nc_u32_e32 v66, v65, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s5, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s5
	global_store_b32 v[66:67], v63, off
.LBB52_34:
	s_or_b32 exec_lo, exec_lo, s6
	v_add_nc_u32_e32 v63, 0xc0, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s5, s14, v63
	s_and_b32 s6, s7, s5
	s_and_saveexec_b32 s8, s6
	s_cbranch_execz .LBB52_36
; %bb.35:
	v_add_nc_u32_e32 v66, v63, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s6, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s6
	global_store_b32 v[66:67], v58, off
.LBB52_36:
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v58, 0xe0, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s6, s14, v58
	s_and_b32 s7, s7, s6
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_38
; %bb.37:
	v_add_nc_u32_e32 v66, v58, v68
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s7, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s7
	global_store_b32 v[66:67], v57, off
.LBB52_38:                              ; %.preheader.1
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v57, 32, v62
	s_lshl_b32 s9, s14, 5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v57
	v_add_nc_u32_e32 v57, s9, v68
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_101
; %bb.39:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_102
.LBB52_40:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_103
.LBB52_41:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_104
.LBB52_42:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_105
.LBB52_43:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_106
.LBB52_44:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_107
.LBB52_45:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_47
.LBB52_46:
	v_add_nc_u32_e32 v50, v58, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v51, 31, v50
	v_lshlrev_b64 v[50:51], 2, v[50:51]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v50, s7, s12, v50
	v_add_co_ci_u32_e64 v51, null, s13, v51, s7
	global_store_b32 v[50:51], v49, off
.LBB52_47:                              ; %.preheader.2
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v49, 64, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v49
	v_add_nc_u32_e32 v49, s9, v57
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_108
; %bb.48:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_109
.LBB52_49:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_110
.LBB52_50:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_111
.LBB52_51:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_112
.LBB52_52:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_113
.LBB52_53:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_114
.LBB52_54:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_56
.LBB52_55:
	v_add_nc_u32_e32 v42, v58, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshlrev_b64 v[42:43], 2, v[42:43]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v42, s7, s12, v42
	v_add_co_ci_u32_e64 v43, null, s13, v43, s7
	global_store_b32 v[42:43], v41, off
.LBB52_56:                              ; %.preheader.3
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v41, 0x60, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v41
	v_add_nc_u32_e32 v41, s9, v49
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_115
; %bb.57:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_116
.LBB52_58:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_117
.LBB52_59:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_118
.LBB52_60:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_119
.LBB52_61:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_120
.LBB52_62:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_121
.LBB52_63:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_65
.LBB52_64:
	v_add_nc_u32_e32 v34, v58, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v35, 31, v34
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v34, s7, s12, v34
	v_add_co_ci_u32_e64 v35, null, s13, v35, s7
	global_store_b32 v[34:35], v33, off
.LBB52_65:                              ; %.preheader.4
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v33, 0x80, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v33
	v_add_nc_u32_e32 v33, s9, v41
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_122
; %bb.66:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_123
.LBB52_67:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_124
.LBB52_68:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_125
.LBB52_69:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_126
.LBB52_70:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_127
.LBB52_71:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_128
.LBB52_72:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_74
.LBB52_73:
	v_add_nc_u32_e32 v26, v58, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v27, 31, v26
	v_lshlrev_b64 v[26:27], 2, v[26:27]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v26, s7, s12, v26
	v_add_co_ci_u32_e64 v27, null, s13, v27, s7
	global_store_b32 v[26:27], v25, off
.LBB52_74:                              ; %.preheader.5
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v25, 0xa0, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v25
	v_add_nc_u32_e32 v25, s9, v33
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_129
; %bb.75:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_130
.LBB52_76:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_131
.LBB52_77:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_132
.LBB52_78:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_133
.LBB52_79:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_134
.LBB52_80:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_135
.LBB52_81:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_83
.LBB52_82:
	v_add_nc_u32_e32 v18, v58, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v19, 31, v18
	v_lshlrev_b64 v[18:19], 2, v[18:19]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v18, s7, s12, v18
	v_add_co_ci_u32_e64 v19, null, s13, v19, s7
	global_store_b32 v[18:19], v17, off
.LBB52_83:                              ; %.preheader.6
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v17, 0xc0, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v17
	v_add_nc_u32_e32 v17, s9, v25
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_136
; %bb.84:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_137
.LBB52_85:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_138
.LBB52_86:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_139
.LBB52_87:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_140
.LBB52_88:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_141
.LBB52_89:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB52_142
.LBB52_90:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB52_92
.LBB52_91:
	v_add_nc_u32_e32 v10, v58, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v9, off
.LBB52_92:                              ; %.preheader.7
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v9, 0xe0, v62
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v9
	v_add_nc_u32_e32 v9, s9, v17
	s_and_b32 s9, s7, vcc_lo
	s_and_saveexec_b32 s8, s9
	s_cbranch_execnz .LBB52_143
; %bb.93:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s8
	s_cbranch_execnz .LBB52_144
.LBB52_94:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB52_145
.LBB52_95:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB52_146
.LBB52_96:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB52_147
.LBB52_97:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB52_148
.LBB52_98:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB52_149
.LBB52_99:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execnz .LBB52_150
.LBB52_100:
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
.LBB52_101:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v66, v0, v57
	v_ashrrev_i32_e32 v67, 31, v66
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	v_add_co_u32 v66, s8, s12, v66
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v67, null, s13, v67, s8
	global_store_b32 v[66:67], v56, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_40
.LBB52_102:
	v_add_nc_u32_e32 v66, v59, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v67, 31, v66
	v_lshlrev_b64 v[66:67], 2, v[66:67]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v66, s8, s12, v66
	v_add_co_ci_u32_e64 v67, null, s13, v67, s8
	global_store_b32 v[66:67], v55, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_41
.LBB52_103:
	v_add_nc_u32_e32 v55, v60, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v56, 31, v55
	v_lshlrev_b64 v[55:56], 2, v[55:56]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v55, s8, s12, v55
	v_add_co_ci_u32_e64 v56, null, s13, v56, s8
	global_store_b32 v[55:56], v54, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_42
.LBB52_104:
	v_add_nc_u32_e32 v54, v61, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v55, 31, v54
	v_lshlrev_b64 v[54:55], 2, v[54:55]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v54, s8, s12, v54
	v_add_co_ci_u32_e64 v55, null, s13, v55, s8
	global_store_b32 v[54:55], v53, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_43
.LBB52_105:
	v_add_nc_u32_e32 v53, v64, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v54, 31, v53
	v_lshlrev_b64 v[53:54], 2, v[53:54]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v53, s8, s12, v53
	v_add_co_ci_u32_e64 v54, null, s13, v54, s8
	global_store_b32 v[53:54], v52, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_44
.LBB52_106:
	v_add_nc_u32_e32 v52, v65, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v53, 31, v52
	v_lshlrev_b64 v[52:53], 2, v[52:53]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v52, s8, s12, v52
	v_add_co_ci_u32_e64 v53, null, s13, v53, s8
	global_store_b32 v[52:53], v51, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_45
.LBB52_107:
	v_add_nc_u32_e32 v51, v63, v57
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v52, 31, v51
	v_lshlrev_b64 v[51:52], 2, v[51:52]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v51, s8, s12, v51
	v_add_co_ci_u32_e64 v52, null, s13, v52, s8
	global_store_b32 v[51:52], v50, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB52_46
	s_branch .LBB52_47
.LBB52_108:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v50, v0, v49
	v_ashrrev_i32_e32 v51, 31, v50
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[50:51], 2, v[50:51]
	v_add_co_u32 v50, s8, s12, v50
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v51, null, s13, v51, s8
	global_store_b32 v[50:51], v48, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_49
.LBB52_109:
	v_add_nc_u32_e32 v50, v59, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v51, 31, v50
	v_lshlrev_b64 v[50:51], 2, v[50:51]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v50, s8, s12, v50
	v_add_co_ci_u32_e64 v51, null, s13, v51, s8
	global_store_b32 v[50:51], v47, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_50
.LBB52_110:
	v_add_nc_u32_e32 v47, v60, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v48, 31, v47
	v_lshlrev_b64 v[47:48], 2, v[47:48]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v47, s8, s12, v47
	v_add_co_ci_u32_e64 v48, null, s13, v48, s8
	global_store_b32 v[47:48], v46, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_51
.LBB52_111:
	v_add_nc_u32_e32 v46, v61, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v47, 31, v46
	v_lshlrev_b64 v[46:47], 2, v[46:47]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v46, s8, s12, v46
	v_add_co_ci_u32_e64 v47, null, s13, v47, s8
	global_store_b32 v[46:47], v45, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_52
.LBB52_112:
	v_add_nc_u32_e32 v45, v64, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v46, 31, v45
	v_lshlrev_b64 v[45:46], 2, v[45:46]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v45, s8, s12, v45
	v_add_co_ci_u32_e64 v46, null, s13, v46, s8
	global_store_b32 v[45:46], v44, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_53
.LBB52_113:
	v_add_nc_u32_e32 v44, v65, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v45, 31, v44
	v_lshlrev_b64 v[44:45], 2, v[44:45]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v44, s8, s12, v44
	v_add_co_ci_u32_e64 v45, null, s13, v45, s8
	global_store_b32 v[44:45], v43, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_54
.LBB52_114:
	v_add_nc_u32_e32 v43, v63, v49
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v44, 31, v43
	v_lshlrev_b64 v[43:44], 2, v[43:44]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v43, s8, s12, v43
	v_add_co_ci_u32_e64 v44, null, s13, v44, s8
	global_store_b32 v[43:44], v42, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB52_55
	s_branch .LBB52_56
.LBB52_115:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v42, v0, v41
	v_ashrrev_i32_e32 v43, 31, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[42:43], 2, v[42:43]
	v_add_co_u32 v42, s8, s12, v42
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v43, null, s13, v43, s8
	global_store_b32 v[42:43], v40, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_58
.LBB52_116:
	v_add_nc_u32_e32 v42, v59, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshlrev_b64 v[42:43], 2, v[42:43]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v42, s8, s12, v42
	v_add_co_ci_u32_e64 v43, null, s13, v43, s8
	global_store_b32 v[42:43], v39, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_59
.LBB52_117:
	v_add_nc_u32_e32 v39, v60, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v40, 31, v39
	v_lshlrev_b64 v[39:40], 2, v[39:40]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v39, s8, s12, v39
	v_add_co_ci_u32_e64 v40, null, s13, v40, s8
	global_store_b32 v[39:40], v38, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_60
.LBB52_118:
	v_add_nc_u32_e32 v38, v61, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v39, 31, v38
	v_lshlrev_b64 v[38:39], 2, v[38:39]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v38, s8, s12, v38
	v_add_co_ci_u32_e64 v39, null, s13, v39, s8
	global_store_b32 v[38:39], v37, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_61
.LBB52_119:
	v_add_nc_u32_e32 v37, v64, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v38, 31, v37
	v_lshlrev_b64 v[37:38], 2, v[37:38]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v37, s8, s12, v37
	v_add_co_ci_u32_e64 v38, null, s13, v38, s8
	global_store_b32 v[37:38], v36, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_62
.LBB52_120:
	v_add_nc_u32_e32 v36, v65, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v37, 31, v36
	v_lshlrev_b64 v[36:37], 2, v[36:37]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v36, s8, s12, v36
	v_add_co_ci_u32_e64 v37, null, s13, v37, s8
	global_store_b32 v[36:37], v35, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_63
.LBB52_121:
	v_add_nc_u32_e32 v35, v63, v41
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v36, 31, v35
	v_lshlrev_b64 v[35:36], 2, v[35:36]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v35, s8, s12, v35
	v_add_co_ci_u32_e64 v36, null, s13, v36, s8
	global_store_b32 v[35:36], v34, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB52_64
	s_branch .LBB52_65
.LBB52_122:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v34, v0, v33
	v_ashrrev_i32_e32 v35, 31, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	v_add_co_u32 v34, s8, s12, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v35, null, s13, v35, s8
	global_store_b32 v[34:35], v32, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_67
.LBB52_123:
	v_add_nc_u32_e32 v34, v59, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v35, 31, v34
	v_lshlrev_b64 v[34:35], 2, v[34:35]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v34, s8, s12, v34
	v_add_co_ci_u32_e64 v35, null, s13, v35, s8
	global_store_b32 v[34:35], v31, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_68
.LBB52_124:
	v_add_nc_u32_e32 v31, v60, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v32, 31, v31
	v_lshlrev_b64 v[31:32], 2, v[31:32]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v31, s8, s12, v31
	v_add_co_ci_u32_e64 v32, null, s13, v32, s8
	global_store_b32 v[31:32], v30, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_69
.LBB52_125:
	v_add_nc_u32_e32 v30, v61, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v31, 31, v30
	v_lshlrev_b64 v[30:31], 2, v[30:31]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v30, s8, s12, v30
	v_add_co_ci_u32_e64 v31, null, s13, v31, s8
	global_store_b32 v[30:31], v29, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_70
.LBB52_126:
	v_add_nc_u32_e32 v29, v64, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v30, 31, v29
	v_lshlrev_b64 v[29:30], 2, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v29, s8, s12, v29
	v_add_co_ci_u32_e64 v30, null, s13, v30, s8
	global_store_b32 v[29:30], v28, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_71
.LBB52_127:
	v_add_nc_u32_e32 v28, v65, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 31, v28
	v_lshlrev_b64 v[28:29], 2, v[28:29]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v28, s8, s12, v28
	v_add_co_ci_u32_e64 v29, null, s13, v29, s8
	global_store_b32 v[28:29], v27, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_72
.LBB52_128:
	v_add_nc_u32_e32 v27, v63, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v28, 31, v27
	v_lshlrev_b64 v[27:28], 2, v[27:28]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v27, s8, s12, v27
	v_add_co_ci_u32_e64 v28, null, s13, v28, s8
	global_store_b32 v[27:28], v26, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB52_73
	s_branch .LBB52_74
.LBB52_129:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v26, v0, v25
	v_ashrrev_i32_e32 v27, 31, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[26:27], 2, v[26:27]
	v_add_co_u32 v26, s8, s12, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v27, null, s13, v27, s8
	global_store_b32 v[26:27], v24, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_76
.LBB52_130:
	v_add_nc_u32_e32 v26, v59, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v27, 31, v26
	v_lshlrev_b64 v[26:27], 2, v[26:27]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v26, s8, s12, v26
	v_add_co_ci_u32_e64 v27, null, s13, v27, s8
	global_store_b32 v[26:27], v23, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_77
.LBB52_131:
	v_add_nc_u32_e32 v23, v60, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v24, 31, v23
	v_lshlrev_b64 v[23:24], 2, v[23:24]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v23, s8, s12, v23
	v_add_co_ci_u32_e64 v24, null, s13, v24, s8
	global_store_b32 v[23:24], v22, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_78
.LBB52_132:
	v_add_nc_u32_e32 v22, v61, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v23, 31, v22
	v_lshlrev_b64 v[22:23], 2, v[22:23]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v22, s8, s12, v22
	v_add_co_ci_u32_e64 v23, null, s13, v23, s8
	global_store_b32 v[22:23], v21, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_79
.LBB52_133:
	v_add_nc_u32_e32 v21, v64, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v22, 31, v21
	v_lshlrev_b64 v[21:22], 2, v[21:22]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v21, s8, s12, v21
	v_add_co_ci_u32_e64 v22, null, s13, v22, s8
	global_store_b32 v[21:22], v20, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_80
.LBB52_134:
	v_add_nc_u32_e32 v20, v65, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v21, 31, v20
	v_lshlrev_b64 v[20:21], 2, v[20:21]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v20, s8, s12, v20
	v_add_co_ci_u32_e64 v21, null, s13, v21, s8
	global_store_b32 v[20:21], v19, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_81
.LBB52_135:
	v_add_nc_u32_e32 v19, v63, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v20, 31, v19
	v_lshlrev_b64 v[19:20], 2, v[19:20]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v19, s8, s12, v19
	v_add_co_ci_u32_e64 v20, null, s13, v20, s8
	global_store_b32 v[19:20], v18, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB52_82
	s_branch .LBB52_83
.LBB52_136:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v18, v0, v17
	v_ashrrev_i32_e32 v19, 31, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[18:19], 2, v[18:19]
	v_add_co_u32 v18, s8, s12, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v19, null, s13, v19, s8
	global_store_b32 v[18:19], v16, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_85
.LBB52_137:
	v_add_nc_u32_e32 v18, v59, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v19, 31, v18
	v_lshlrev_b64 v[18:19], 2, v[18:19]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v18, s8, s12, v18
	v_add_co_ci_u32_e64 v19, null, s13, v19, s8
	global_store_b32 v[18:19], v15, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_86
.LBB52_138:
	v_add_nc_u32_e32 v15, v60, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v16, 31, v15
	v_lshlrev_b64 v[15:16], 2, v[15:16]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v15, s8, s12, v15
	v_add_co_ci_u32_e64 v16, null, s13, v16, s8
	global_store_b32 v[15:16], v14, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_87
.LBB52_139:
	v_add_nc_u32_e32 v14, v61, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v15, 31, v14
	v_lshlrev_b64 v[14:15], 2, v[14:15]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v14, s8, s12, v14
	v_add_co_ci_u32_e64 v15, null, s13, v15, s8
	global_store_b32 v[14:15], v13, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_88
.LBB52_140:
	v_add_nc_u32_e32 v13, v64, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v14, 31, v13
	v_lshlrev_b64 v[13:14], 2, v[13:14]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v13, s8, s12, v13
	v_add_co_ci_u32_e64 v14, null, s13, v14, s8
	global_store_b32 v[13:14], v12, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_89
.LBB52_141:
	v_add_nc_u32_e32 v12, v65, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v13, 31, v12
	v_lshlrev_b64 v[12:13], 2, v[12:13]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v12, s8, s12, v12
	v_add_co_ci_u32_e64 v13, null, s13, v13, s8
	global_store_b32 v[12:13], v11, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB52_90
.LBB52_142:
	v_add_nc_u32_e32 v11, v63, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v12, 31, v11
	v_lshlrev_b64 v[11:12], 2, v[11:12]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v11, s8, s12, v11
	v_add_co_ci_u32_e64 v12, null, s13, v12, s8
	global_store_b32 v[11:12], v10, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB52_91
	s_branch .LBB52_92
.LBB52_143:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v10, v0, v9
	v_ashrrev_i32_e32 v11, 31, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	v_add_co_u32 v10, vcc_lo, s12, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v11, null, s13, v11, vcc_lo
	global_store_b32 v[10:11], v8, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s0, s8
	s_cbranch_execz .LBB52_94
.LBB52_144:
	v_add_nc_u32_e32 v10, v59, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, vcc_lo, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, vcc_lo
	global_store_b32 v[10:11], v7, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB52_95
.LBB52_145:
	v_add_nc_u32_e32 v7, v60, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v8, 31, v7
	v_lshlrev_b64 v[7:8], 2, v[7:8]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v7, vcc_lo, s12, v7
	v_add_co_ci_u32_e64 v8, null, s13, v8, vcc_lo
	global_store_b32 v[7:8], v6, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB52_96
.LBB52_146:
	v_add_nc_u32_e32 v6, v61, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, vcc_lo, s12, v6
	v_add_co_ci_u32_e64 v7, null, s13, v7, vcc_lo
	global_store_b32 v[6:7], v5, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB52_97
.LBB52_147:
	v_add_nc_u32_e32 v5, v64, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64 v[5:6], 2, v[5:6]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v5, vcc_lo, s12, v5
	v_add_co_ci_u32_e64 v6, null, s13, v6, vcc_lo
	global_store_b32 v[5:6], v4, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB52_98
.LBB52_148:
	v_add_nc_u32_e32 v4, v65, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshlrev_b64 v[4:5], 2, v[4:5]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v4, vcc_lo, s12, v4
	v_add_co_ci_u32_e64 v5, null, s13, v5, vcc_lo
	global_store_b32 v[4:5], v3, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB52_99
.LBB52_149:
	v_add_nc_u32_e32 v3, v63, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v4, 31, v3
	v_lshlrev_b64 v[3:4], 2, v[3:4]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v3, vcc_lo, s12, v3
	v_add_co_ci_u32_e64 v4, null, s13, v4, vcc_lo
	global_store_b32 v[3:4], v2, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB52_100
.LBB52_150:
	v_add_nc_u32_e32 v2, v58, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, vcc_lo, s12, v2
	v_add_co_ci_u32_e64 v3, null, s13, v3, vcc_lo
	global_store_b32 v[2:3], v1, off
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _ZN3clk3hip8gemm_regILi256ELi256ELi16ELi8ELi8ELb0EEEviPKfS3_Pf
		.amdhsa_group_segment_fixed_size 32768
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
		.amdhsa_next_free_vgpr 103
		.amdhsa_next_free_sgpr 17
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
		.amdhsa_inst_pref_size 60
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._ZN3clk3hip8gemm_regILi256ELi256ELi16ELi8ELi8ELb0EEEviPKfS3_Pf,"axG",@progbits,_ZN3clk3hip8gemm_regILi256ELi256ELi16ELi8ELi8ELb0EEEviPKfS3_Pf,comdat
