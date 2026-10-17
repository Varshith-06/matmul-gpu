_ZN3clk3hip8gemm_regILi128ELi128ELi8ELi8ELi8ELb0EEEviPKfS3_Pf: ; @_ZN3clk3hip8gemm_regILi128ELi128ELi8ELi8ELi8ELb0EEEviPKfS3_Pf
; %bb.0:                                ; %.preheader131
	s_clause 0x2
	s_load_b32 s14, s[0:1], 0x0
	s_load_b128 s[8:11], s[0:1], 0x8
	s_load_b64 s[12:13], s[0:1], 0x18
	v_bfe_u32 v102, v0, 10, 10
	v_and_b32_e32 v103, 0x3ff, v0
	s_lshl_b32 s6, s3, 7
	s_lshl_b32 s7, s2, 7
	s_waitcnt lgkmcnt(0)
	s_cmp_lt_i32 s14, 1
	s_cbranch_scc1 .LBB36_19
; %bb.1:                                ; %.preheader129.lr.ph
	v_lshl_add_u32 v0, v102, 4, v103
	v_dual_mov_b32 v45, 0 :: v_dual_and_b32 v32, 7, v103
	v_lshl_or_b32 v112, v103, 2, 0x1000
	v_dual_mov_b32 v46, 0 :: v_dual_lshlrev_b32 v111, 5, v102
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v47, 0 :: v_dual_and_b32 v2, 0x7f, v0
	v_dual_mov_b32 v51, 0 :: v_dual_add_nc_u32 v6, 0x300, v0
	v_dual_mov_b32 v48, 0 :: v_dual_lshlrev_b32 v1, 2, v32
	v_or_b32_e32 v7, s7, v2
	v_lshrrev_b32_e32 v3, 3, v0
	v_dual_mov_b32 v50, 0 :: v_dual_add_nc_u32 v5, 0x200, v0
	v_dual_mov_b32 v49, 0 :: v_dual_add_nc_u32 v4, 0x100, v0
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_4) | instid1(VALU_DEP_4)
	v_cmp_gt_i32_e32 vcc_lo, s14, v7
	v_lshrrev_b32_e32 v7, 3, v6
	v_dual_mov_b32 v53, 0 :: v_dual_add_nc_u32 v10, s6, v3
	v_lshl_or_b32 v113, v3, 5, v1
	v_lshrrev_b32_e32 v11, 3, v5
	v_dual_mov_b32 v54, 0 :: v_dual_add_nc_u32 v3, s6, v7
	v_lshrrev_b32_e32 v9, 3, v4
	v_lshrrev_b32_e32 v116, 7, v0
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_dual_mov_b32 v52, 0 :: v_dual_add_nc_u32 v13, s6, v11
	v_mad_u64_u32 v[33:34], null, v3, s14, v[32:33]
	s_delay_alu instid0(VALU_DEP_4)
	v_dual_mov_b32 v55, 0 :: v_dual_add_nc_u32 v12, s6, v9
	v_lshrrev_b32_e32 v117, 7, v4
	v_lshrrev_b32_e32 v118, 7, v5
	v_lshrrev_b32_e32 v119, 7, v6
	v_lshl_or_b32 v8, v2, 2, 0x1000
	v_mad_u64_u32 v[34:35], null, v13, s14, v[32:33]
	v_mad_u64_u32 v[35:36], null, v12, s14, v[32:33]
	s_delay_alu instid0(VALU_DEP_4)
	v_mul_lo_u32 v125, s14, v119
	v_mul_lo_u32 v127, s14, v118
	v_mul_lo_u32 v128, s14, v117
	v_mul_lo_u32 v129, s14, v116
	v_mad_u64_u32 v[36:37], null, v10, s14, v[32:33]
	v_cmp_gt_i32_e64 s0, s14, v10
	v_cmp_gt_i32_e64 s1, s14, v12
	v_lshl_or_b32 v114, v9, 5, v1
	v_cmp_gt_i32_e64 s2, s14, v13
	v_lshl_or_b32 v115, v11, 5, v1
	v_cmp_gt_i32_e64 s3, s14, v3
	v_lshl_or_b32 v120, v7, 5, v1
	v_lshl_add_u32 v121, v116, 9, v8
	v_lshl_add_u32 v122, v117, 9, v8
	v_lshl_add_u32 v123, v118, 9, v8
	v_lshl_add_u32 v124, v119, 9, v8
	v_dual_mov_b32 v57, 0 :: v_dual_add_nc_u32 v126, s7, v2
	v_dual_mov_b32 v59, 0 :: v_dual_add_nc_u32 v130, 0x400, v112
	v_dual_mov_b32 v56, 0 :: v_dual_add_nc_u32 v131, 0x800, v112
	v_dual_mov_b32 v61, 0 :: v_dual_add_nc_u32 v132, 0xc00, v112
	v_dual_mov_b32 v58, 0 :: v_dual_mov_b32 v63, 0
	v_dual_mov_b32 v60, 0 :: v_dual_mov_b32 v65, 0
	v_dual_mov_b32 v62, 0 :: v_dual_mov_b32 v67, 0
	v_dual_mov_b32 v64, 0 :: v_dual_mov_b32 v69, 0
	v_dual_mov_b32 v66, 0 :: v_dual_mov_b32 v71, 0
	v_dual_mov_b32 v68, 0 :: v_dual_mov_b32 v73, 0
	v_dual_mov_b32 v70, 0 :: v_dual_mov_b32 v75, 0
	v_dual_mov_b32 v72, 0 :: v_dual_mov_b32 v77, 0
	v_dual_mov_b32 v74, 0 :: v_dual_mov_b32 v79, 0
	v_dual_mov_b32 v76, 0 :: v_dual_mov_b32 v81, 0
	v_dual_mov_b32 v78, 0 :: v_dual_mov_b32 v83, 0
	v_dual_mov_b32 v80, 0 :: v_dual_mov_b32 v85, 0
	v_dual_mov_b32 v82, 0 :: v_dual_mov_b32 v87, 0
	v_dual_mov_b32 v84, 0 :: v_dual_mov_b32 v89, 0
	v_dual_mov_b32 v86, 0 :: v_dual_mov_b32 v91, 0
	v_dual_mov_b32 v88, 0 :: v_dual_mov_b32 v93, 0
	v_dual_mov_b32 v90, 0 :: v_dual_mov_b32 v95, 0
	v_dual_mov_b32 v92, 0 :: v_dual_mov_b32 v97, 0
	v_dual_mov_b32 v94, 0 :: v_dual_mov_b32 v99, 0
	v_dual_mov_b32 v96, 0 :: v_dual_mov_b32 v101, 0
	v_dual_mov_b32 v98, 0 :: v_dual_mov_b32 v105, 0
	v_dual_mov_b32 v100, 0 :: v_dual_mov_b32 v107, 0
	v_dual_mov_b32 v104, 0 :: v_dual_mov_b32 v109, 0
	v_mov_b32_e32 v106, 0
	v_mov_b32_e32 v108, 0
	v_mov_b32_e32 v110, 0
	s_lshl_b32 s15, s14, 3
	s_mov_b32 s16, 0
	s_branch .LBB36_3
.LBB36_2:                               ; %.preheader127
                                        ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	ds_store_b32 v124, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	ds_load_b128 v[9:12], v111
	ds_load_2addr_b32 v[29:30], v112 offset1:16
	ds_load_2addr_b32 v[41:42], v112 offset0:32 offset1:48
	ds_load_2addr_b32 v[43:44], v112 offset0:64 offset1:80
	ds_load_2addr_b32 v[137:138], v112 offset0:96 offset1:112
	ds_load_b128 v[13:16], v111 offset:512
	ds_load_b128 v[0:3], v111 offset:16
	ds_load_b128 v[17:20], v111 offset:1024
	ds_load_b128 v[21:24], v111 offset:1536
	ds_load_b128 v[25:28], v111 offset:2048
	ds_load_b128 v[37:40], v111 offset:2560
	ds_load_b128 v[133:136], v111 offset:3072
	ds_load_b128 v[4:7], v111 offset:3584
	v_add_nc_u32_e32 v126, s15, v126
	s_add_i32 s16, s16, 8
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cmp_ge_i32 s16, s14
	s_waitcnt lgkmcnt(11)
	v_fmac_f32_e32 v110, v9, v29
	v_fmac_f32_e32 v109, v9, v30
	s_waitcnt lgkmcnt(10)
	v_fmac_f32_e32 v108, v9, v41
	v_fmac_f32_e32 v107, v9, v42
	s_waitcnt lgkmcnt(9)
	v_fmac_f32_e32 v106, v9, v43
	v_fmac_f32_e32 v105, v9, v44
	s_waitcnt lgkmcnt(8)
	v_fmac_f32_e32 v104, v9, v137
	v_fmac_f32_e32 v101, v9, v138
	ds_load_2addr_b32 v[8:9], v112 offset0:128 offset1:144
	s_waitcnt lgkmcnt(6)
	v_fmac_f32_e32 v92, v17, v29
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v84, v21, v29 :: v_dual_fmac_f32 v51, v4, v30
	v_fmac_f32_e32 v99, v13, v30
	v_fmac_f32_e32 v81, v21, v42
	v_fmac_f32_e32 v76, v25, v29
	v_fmac_f32_e32 v75, v25, v30
	v_fmac_f32_e32 v67, v37, v30
	v_dual_fmac_f32 v59, v133, v30 :: v_dual_fmac_f32 v52, v4, v29
	v_fmac_f32_e32 v96, v13, v43
	v_fmac_f32_e32 v50, v4, v41
	v_dual_fmac_f32 v100, v13, v29 :: v_dual_fmac_f32 v45, v4, v138
	v_fmac_f32_e32 v91, v17, v30
	v_fmac_f32_e32 v80, v21, v43
	v_fmac_f32_e32 v65, v37, v42
	v_fmac_f32_e32 v60, v133, v29
	v_fmac_f32_e32 v90, v17, v41
	s_waitcnt lgkmcnt(0)
	v_fmac_f32_e32 v110, v10, v8
	v_dual_fmac_f32 v88, v17, v43 :: v_dual_fmac_f32 v99, v14, v9
	v_fmac_f32_e32 v73, v25, v42
	v_fmac_f32_e32 v68, v37, v29
	v_fmac_f32_e32 v109, v10, v9
	v_fmac_f32_e32 v83, v21, v30
	ds_load_2addr_b32 v[29:30], v112 offset0:160 offset1:176
	v_fmac_f32_e32 v82, v21, v41
	v_fmac_f32_e32 v74, v25, v41
	v_fmac_f32_e32 v66, v37, v41
	v_fmac_f32_e32 v58, v133, v41
	v_fmac_f32_e32 v57, v133, v42
	v_fmac_f32_e32 v49, v4, v42
	v_dual_fmac_f32 v97, v13, v42 :: v_dual_fmac_f32 v48, v4, v43
	v_dual_fmac_f32 v98, v13, v41 :: v_dual_fmac_f32 v47, v4, v44
	v_fmac_f32_e32 v46, v4, v137
	s_waitcnt lgkmcnt(0)
	v_dual_fmac_f32 v52, v5, v8 :: v_dual_fmac_f32 v107, v10, v30
	v_dual_fmac_f32 v89, v17, v42 :: v_dual_fmac_f32 v100, v14, v8
	ds_load_2addr_b32 v[41:42], v112 offset0:192 offset1:208
	v_dual_fmac_f32 v95, v13, v44 :: v_dual_fmac_f32 v108, v10, v29
	v_fmac_f32_e32 v97, v14, v30
	v_fmac_f32_e32 v92, v18, v8
	v_dual_fmac_f32 v64, v37, v43 :: v_dual_fmac_f32 v75, v26, v9
	v_fmac_f32_e32 v89, v18, v30
	v_fmac_f32_e32 v84, v22, v8
	v_dual_fmac_f32 v56, v133, v43 :: v_dual_fmac_f32 v67, v38, v9
	v_fmac_f32_e32 v85, v17, v138
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_fmac_f32 v61, v37, v138 :: v_dual_fmac_f32 v56, v134, v41
	v_fmac_f32_e32 v105, v10, v42
	v_dual_fmac_f32 v87, v17, v44 :: v_dual_fmac_f32 v98, v14, v29
	v_fmac_f32_e32 v106, v10, v41
	v_fmac_f32_e32 v95, v14, v42
	v_dual_fmac_f32 v79, v21, v44 :: v_dual_fmac_f32 v90, v18, v29
	s_delay_alu instid0(VALU_DEP_4)
	v_fmac_f32_e32 v87, v18, v42
	v_dual_fmac_f32 v71, v25, v44 :: v_dual_fmac_f32 v82, v22, v29
	v_fmac_f32_e32 v96, v14, v41
	v_dual_fmac_f32 v72, v25, v43 :: v_dual_fmac_f32 v83, v22, v9
	v_fmac_f32_e32 v79, v22, v42
	v_dual_fmac_f32 v63, v37, v44 :: v_dual_fmac_f32 v74, v26, v29
	v_fmac_f32_e32 v71, v26, v42
	v_dual_fmac_f32 v55, v133, v44 :: v_dual_fmac_f32 v66, v38, v29
	ds_load_2addr_b32 v[43:44], v112 offset0:224 offset1:240
	v_fmac_f32_e32 v94, v13, v137
	v_fmac_f32_e32 v88, v18, v41
	v_fmac_f32_e32 v73, v26, v30
	v_dual_fmac_f32 v93, v13, v138 :: v_dual_fmac_f32 v68, v38, v8
	v_dual_fmac_f32 v78, v21, v137 :: v_dual_fmac_f32 v55, v134, v42
	v_fmac_f32_e32 v70, v25, v137
	v_fmac_f32_e32 v72, v26, v41
	v_dual_fmac_f32 v86, v17, v137 :: v_dual_fmac_f32 v57, v134, v30
	v_dual_fmac_f32 v53, v133, v138 :: v_dual_fmac_f32 v64, v38, v41
	v_dual_fmac_f32 v62, v37, v137 :: v_dual_fmac_f32 v63, v38, v42
	v_dual_fmac_f32 v69, v25, v138 :: v_dual_fmac_f32 v58, v134, v29
	v_fmac_f32_e32 v51, v5, v9
	v_fmac_f32_e32 v50, v5, v29
	s_waitcnt lgkmcnt(0)
	v_fmac_f32_e32 v104, v10, v43
	v_fmac_f32_e32 v101, v10, v44
	v_fmac_f32_e32 v94, v14, v43
	v_fmac_f32_e32 v91, v18, v9
	v_fmac_f32_e32 v81, v22, v30
	v_fmac_f32_e32 v80, v22, v41
	v_fmac_f32_e32 v76, v26, v8
	v_fmac_f32_e32 v65, v38, v30
	v_dual_fmac_f32 v77, v21, v138 :: v_dual_fmac_f32 v60, v134, v8
	v_fmac_f32_e32 v54, v133, v137
	v_fmac_f32_e32 v59, v134, v9
	ds_load_2addr_b32 v[8:9], v130 offset1:16
	v_dual_fmac_f32 v48, v5, v41 :: v_dual_fmac_f32 v61, v38, v44
	ds_load_2addr_b32 v[137:138], v130 offset0:64 offset1:80
	v_fmac_f32_e32 v93, v14, v44
	v_dual_fmac_f32 v49, v5, v30 :: v_dual_fmac_f32 v70, v26, v43
	ds_load_2addr_b32 v[29:30], v130 offset0:32 offset1:48
	v_fmac_f32_e32 v85, v18, v44
	v_dual_fmac_f32 v47, v5, v42 :: v_dual_fmac_f32 v62, v38, v43
	ds_load_2addr_b32 v[41:42], v130 offset0:96 offset1:112
	ds_load_2addr_b32 v[13:14], v130 offset0:128 offset1:144
	v_fmac_f32_e32 v86, v18, v43
	v_fmac_f32_e32 v77, v22, v44
	v_dual_fmac_f32 v54, v134, v43 :: v_dual_fmac_f32 v45, v5, v44
	v_dual_fmac_f32 v53, v134, v44 :: v_dual_fmac_f32 v46, v5, v43
	ds_load_2addr_b32 v[4:5], v130 offset0:160 offset1:176
	v_fmac_f32_e32 v78, v22, v43
	v_fmac_f32_e32 v69, v26, v44
	s_waitcnt lgkmcnt(5)
	v_dual_fmac_f32 v110, v11, v8 :: v_dual_fmac_f32 v51, v6, v9
	v_dual_fmac_f32 v109, v11, v9 :: v_dual_fmac_f32 v52, v6, v8
	s_waitcnt lgkmcnt(4)
	v_dual_fmac_f32 v106, v11, v137 :: v_dual_fmac_f32 v47, v6, v138
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v108, v11, v29 :: v_dual_fmac_f32 v49, v6, v30
	v_dual_fmac_f32 v107, v11, v30 :: v_dual_fmac_f32 v50, v6, v29
	v_dual_fmac_f32 v105, v11, v138 :: v_dual_fmac_f32 v48, v6, v137
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v104, v11, v41 :: v_dual_fmac_f32 v45, v6, v42
	v_dual_fmac_f32 v101, v11, v42 :: v_dual_fmac_f32 v46, v6, v41
	ds_load_2addr_b32 v[10:11], v130 offset0:224 offset1:240
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v100, v15, v8 :: v_dual_fmac_f32 v109, v12, v14
	v_fmac_f32_e32 v89, v19, v30
	ds_load_2addr_b32 v[43:44], v131 offset1:16
	ds_load_2addr_b32 v[37:38], v131 offset0:32 offset1:48
	v_fmac_f32_e32 v100, v16, v13
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v60, v135, v8 :: v_dual_fmac_f32 v89, v20, v5
	v_fmac_f32_e32 v61, v39, v42
	v_dual_fmac_f32 v99, v15, v9 :: v_dual_fmac_f32 v108, v12, v4
	s_delay_alu instid0(VALU_DEP_3)
	v_fmac_f32_e32 v60, v136, v13
	v_fmac_f32_e32 v64, v39, v137
	v_dual_fmac_f32 v92, v19, v8 :: v_dual_fmac_f32 v107, v12, v5
	v_dual_fmac_f32 v97, v15, v30 :: v_dual_fmac_f32 v110, v12, v13
	v_dual_fmac_f32 v96, v15, v137 :: v_dual_fmac_f32 v99, v16, v14
	s_waitcnt lgkmcnt(2)
	v_fmac_f32_e32 v61, v40, v11
	v_fmac_f32_e32 v69, v27, v42
	v_fmac_f32_e32 v72, v27, v137
	v_dual_fmac_f32 v91, v19, v9 :: v_dual_fmac_f32 v104, v12, v10
	s_delay_alu instid0(VALU_DEP_3)
	v_dual_fmac_f32 v84, v23, v8 :: v_dual_fmac_f32 v69, v28, v11
	v_fmac_f32_e32 v93, v15, v42
	v_fmac_f32_e32 v94, v15, v41
	v_fmac_f32_e32 v83, v23, v9
	v_dual_fmac_f32 v76, v27, v8 :: v_dual_fmac_f32 v97, v16, v5
	v_fmac_f32_e32 v68, v39, v8
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v86, v19, v41 :: v_dual_fmac_f32 v109, v0, v44
	v_fmac_f32_e32 v67, v39, v9
	s_waitcnt lgkmcnt(0)
	v_dual_fmac_f32 v78, v23, v41 :: v_dual_fmac_f32 v107, v0, v38
	v_fmac_f32_e32 v59, v135, v9
	v_fmac_f32_e32 v93, v16, v11
	v_dual_fmac_f32 v75, v27, v9 :: v_dual_fmac_f32 v94, v16, v10
	ds_load_2addr_b32 v[8:9], v130 offset0:192 offset1:208
	v_fmac_f32_e32 v95, v15, v138
	v_fmac_f32_e32 v86, v20, v10
	v_dual_fmac_f32 v66, v39, v29 :: v_dual_fmac_f32 v67, v40, v14
	v_fmac_f32_e32 v77, v23, v42
	v_dual_fmac_f32 v98, v15, v29 :: v_dual_fmac_f32 v101, v12, v11
	v_dual_fmac_f32 v90, v19, v29 :: v_dual_fmac_f32 v91, v20, v14
	v_dual_fmac_f32 v81, v23, v30 :: v_dual_fmac_f32 v92, v20, v13
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_fmac_f32 v79, v23, v138 :: v_dual_fmac_f32 v90, v20, v4
	v_fmac_f32_e32 v62, v39, v41
	v_fmac_f32_e32 v66, v40, v4
	v_dual_fmac_f32 v80, v23, v137 :: v_dual_fmac_f32 v77, v24, v11
	v_fmac_f32_e32 v63, v39, v138
	v_dual_fmac_f32 v74, v27, v29 :: v_dual_fmac_f32 v75, v28, v14
	s_waitcnt lgkmcnt(0)
	v_fmac_f32_e32 v106, v12, v8
	v_fmac_f32_e32 v96, v16, v8
	v_dual_fmac_f32 v82, v23, v29 :: v_dual_fmac_f32 v83, v24, v14
	v_fmac_f32_e32 v65, v39, v30
	v_fmac_f32_e32 v95, v16, v9
	v_dual_fmac_f32 v85, v19, v42 :: v_dual_fmac_f32 v68, v40, v13
	v_fmac_f32_e32 v88, v19, v137
	v_fmac_f32_e32 v105, v12, v9
	v_dual_fmac_f32 v71, v27, v138 :: v_dual_fmac_f32 v84, v24, v13
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_fmac_f32_e32 v85, v20, v11
	v_dual_fmac_f32 v73, v27, v30 :: v_dual_fmac_f32 v88, v20, v8
	v_fmac_f32_e32 v82, v24, v4
	v_dual_fmac_f32 v81, v24, v5 :: v_dual_fmac_f32 v48, v7, v8
	v_fmac_f32_e32 v80, v24, v8
	v_dual_fmac_f32 v79, v24, v9 :: v_dual_fmac_f32 v46, v7, v10
	v_fmac_f32_e32 v78, v24, v10
	v_dual_fmac_f32 v58, v135, v29 :: v_dual_fmac_f32 v59, v136, v14
	v_fmac_f32_e32 v53, v135, v42
	v_fmac_f32_e32 v65, v40, v5
	v_fmac_f32_e32 v64, v40, v8
	v_fmac_f32_e32 v63, v40, v9
	v_dual_fmac_f32 v62, v40, v10 :: v_dual_fmac_f32 v47, v7, v9
	ds_load_2addr_b32 v[39:40], v131 offset0:64 offset1:80
	v_fmac_f32_e32 v70, v27, v41
	ds_load_b128 v[24:27], v111 offset:528
	v_fmac_f32_e32 v54, v135, v41
	ds_load_2addr_b32 v[41:42], v131 offset0:96 offset1:112
	v_dual_fmac_f32 v87, v19, v138 :: v_dual_fmac_f32 v98, v16, v4
	v_dual_fmac_f32 v57, v135, v30 :: v_dual_fmac_f32 v76, v28, v13
	v_dual_fmac_f32 v55, v135, v138 :: v_dual_fmac_f32 v74, v28, v4
	v_fmac_f32_e32 v58, v136, v4
	v_dual_fmac_f32 v56, v135, v137 :: v_dual_fmac_f32 v53, v136, v11
	v_dual_fmac_f32 v87, v20, v9 :: v_dual_fmac_f32 v50, v7, v4
	v_fmac_f32_e32 v72, v28, v8
	v_fmac_f32_e32 v57, v136, v5
	s_delay_alu instid0(VALU_DEP_4)
	v_dual_fmac_f32 v56, v136, v8 :: v_dual_fmac_f32 v51, v7, v14
	v_fmac_f32_e32 v55, v136, v9
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v52, v7, v13 :: v_dual_fmac_f32 v97, v24, v38
	v_fmac_f32_e32 v49, v7, v5
	v_dual_fmac_f32 v45, v7, v11 :: v_dual_fmac_f32 v108, v0, v37
	v_fmac_f32_e32 v73, v28, v5
	v_fmac_f32_e32 v105, v0, v40
	v_fmac_f32_e32 v70, v28, v10
	s_waitcnt lgkmcnt(0)
	v_fmac_f32_e32 v101, v0, v42
	v_fmac_f32_e32 v104, v0, v41
	v_fmac_f32_e32 v71, v28, v9
	v_fmac_f32_e32 v99, v24, v44
	v_fmac_f32_e32 v54, v136, v10
	ds_load_b128 v[20:23], v111 offset:1040
	ds_load_b128 v[12:15], v111 offset:1552
	ds_load_b128 v[28:31], v111 offset:2064
	ds_load_b128 v[16:19], v111 offset:2576
	ds_load_b128 v[8:11], v111 offset:3088
	ds_load_b128 v[4:7], v111 offset:3600
	ds_load_2addr_b32 v[133:134], v131 offset0:128 offset1:144
	v_fmac_f32_e32 v100, v24, v43
	ds_load_2addr_b32 v[137:138], v131 offset0:192 offset1:208
	v_fmac_f32_e32 v110, v0, v43
	ds_load_2addr_b32 v[135:136], v131 offset0:160 offset1:176
	v_fmac_f32_e32 v106, v0, v39
	v_fmac_f32_e32 v98, v24, v37
	s_waitcnt lgkmcnt(7)
	v_fmac_f32_e32 v83, v12, v44
	v_fmac_f32_e32 v84, v12, v43
	s_waitcnt lgkmcnt(6)
	v_fmac_f32_e32 v75, v28, v44
	v_fmac_f32_e32 v76, v28, v43
	s_waitcnt lgkmcnt(5)
	v_fmac_f32_e32 v67, v16, v44
	v_fmac_f32_e32 v68, v16, v43
	s_waitcnt lgkmcnt(4)
	v_fmac_f32_e32 v59, v8, v44
	s_waitcnt lgkmcnt(3)
	v_fmac_f32_e32 v51, v4, v44
	v_fmac_f32_e32 v60, v8, v43
	v_fmac_f32_e32 v61, v16, v42
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v52, v4, v43 :: v_dual_fmac_f32 v99, v25, v134
	v_dual_fmac_f32 v91, v20, v44 :: v_dual_fmac_f32 v100, v25, v133
	v_fmac_f32_e32 v92, v20, v43
	ds_load_2addr_b32 v[43:44], v131 offset0:224 offset1:240
	v_fmac_f32_e32 v109, v1, v134
	v_dual_fmac_f32 v95, v24, v40 :: v_dual_fmac_f32 v110, v1, v133
	v_dual_fmac_f32 v96, v24, v39 :: v_dual_fmac_f32 v91, v21, v134
	v_dual_fmac_f32 v87, v20, v40 :: v_dual_fmac_f32 v92, v21, v133
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v88, v20, v39 :: v_dual_fmac_f32 v105, v1, v138
	v_dual_fmac_f32 v93, v24, v42 :: v_dual_fmac_f32 v106, v1, v137
	v_dual_fmac_f32 v94, v24, v41 :: v_dual_fmac_f32 v95, v25, v138
	v_dual_fmac_f32 v89, v20, v38 :: v_dual_fmac_f32 v96, v25, v137
	v_dual_fmac_f32 v90, v20, v37 :: v_dual_fmac_f32 v87, v21, v138
	v_dual_fmac_f32 v85, v20, v42 :: v_dual_fmac_f32 v88, v21, v137
	v_fmac_f32_e32 v86, v20, v41
	v_fmac_f32_e32 v81, v12, v38
	v_fmac_f32_e32 v82, v12, v37
	v_fmac_f32_e32 v79, v12, v40
	v_fmac_f32_e32 v80, v12, v39
	v_fmac_f32_e32 v77, v12, v42
	v_fmac_f32_e32 v78, v12, v41
	v_dual_fmac_f32 v62, v16, v41 :: v_dual_fmac_f32 v59, v9, v134
	s_waitcnt lgkmcnt(1)
	v_fmac_f32_e32 v97, v25, v136
	v_dual_fmac_f32 v98, v25, v135 :: v_dual_fmac_f32 v65, v16, v38
	s_waitcnt lgkmcnt(0)
	v_dual_fmac_f32 v66, v16, v37 :: v_dual_fmac_f32 v93, v25, v44
	v_dual_fmac_f32 v94, v25, v43 :: v_dual_fmac_f32 v63, v16, v40
	v_dual_fmac_f32 v64, v16, v39 :: v_dual_fmac_f32 v89, v21, v136
	v_fmac_f32_e32 v90, v21, v135
	v_fmac_f32_e32 v85, v21, v44
	v_fmac_f32_e32 v86, v21, v43
	ds_load_2addr_b32 v[20:21], v132 offset0:64 offset1:80
	ds_load_2addr_b32 v[24:25], v132 offset0:96 offset1:112
	v_fmac_f32_e32 v107, v1, v136
	v_fmac_f32_e32 v108, v1, v135
	v_fmac_f32_e32 v101, v1, v44
	v_fmac_f32_e32 v104, v1, v43
	v_fmac_f32_e32 v83, v13, v134
	v_fmac_f32_e32 v84, v13, v133
	v_fmac_f32_e32 v81, v13, v136
	v_fmac_f32_e32 v82, v13, v135
	v_fmac_f32_e32 v79, v13, v138
	v_fmac_f32_e32 v80, v13, v137
	v_fmac_f32_e32 v77, v13, v44
	v_fmac_f32_e32 v78, v13, v43
	v_fmac_f32_e32 v67, v17, v134
	v_fmac_f32_e32 v68, v17, v133
	v_fmac_f32_e32 v65, v17, v136
	v_fmac_f32_e32 v66, v17, v135
	v_fmac_f32_e32 v63, v17, v138
	v_fmac_f32_e32 v64, v17, v137
	v_fmac_f32_e32 v62, v17, v43
	ds_load_2addr_b32 v[0:1], v132 offset1:16
	ds_load_2addr_b32 v[12:13], v132 offset0:32 offset1:48
	v_fmac_f32_e32 v61, v17, v44
	ds_load_2addr_b32 v[16:17], v132 offset0:192 offset1:208
	v_fmac_f32_e32 v55, v8, v40
	v_fmac_f32_e32 v56, v8, v39
	v_fmac_f32_e32 v53, v8, v42
	v_fmac_f32_e32 v57, v8, v38
	v_fmac_f32_e32 v54, v8, v41
	v_fmac_f32_e32 v49, v4, v38
	v_fmac_f32_e32 v50, v4, v37
	v_fmac_f32_e32 v47, v4, v40
	v_fmac_f32_e32 v48, v4, v39
	v_fmac_f32_e32 v45, v4, v42
	v_dual_fmac_f32 v46, v4, v41 :: v_dual_fmac_f32 v55, v9, v138
	v_fmac_f32_e32 v56, v9, v137
	v_dual_fmac_f32 v53, v9, v44 :: v_dual_fmac_f32 v58, v8, v37
	v_fmac_f32_e32 v57, v9, v136
	v_fmac_f32_e32 v75, v29, v134
	v_fmac_f32_e32 v76, v29, v133
	v_fmac_f32_e32 v52, v5, v133
	v_fmac_f32_e32 v51, v5, v134
	v_fmac_f32_e32 v60, v9, v133
	v_fmac_f32_e32 v49, v5, v136
	v_fmac_f32_e32 v50, v5, v135
	v_fmac_f32_e32 v47, v5, v138
	v_fmac_f32_e32 v48, v5, v137
	v_fmac_f32_e32 v45, v5, v44
	v_fmac_f32_e32 v46, v5, v43
	ds_load_2addr_b32 v[4:5], v132 offset0:128 offset1:144
	s_waitcnt lgkmcnt(4)
	v_fmac_f32_e32 v53, v10, v25
	v_fmac_f32_e32 v56, v10, v20
	v_fmac_f32_e32 v58, v9, v135
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v54, v9, v43 :: v_dual_fmac_f32 v109, v2, v1
	v_fmac_f32_e32 v110, v2, v0
	v_fmac_f32_e32 v99, v26, v1
	v_fmac_f32_e32 v100, v26, v0
	v_fmac_f32_e32 v91, v22, v1
	v_fmac_f32_e32 v92, v22, v0
	v_fmac_f32_e32 v83, v14, v1
	v_fmac_f32_e32 v84, v14, v0
	v_fmac_f32_e32 v75, v30, v1
	v_fmac_f32_e32 v76, v30, v0
	v_fmac_f32_e32 v67, v18, v1
	v_fmac_f32_e32 v68, v18, v0
	v_fmac_f32_e32 v59, v10, v1
	v_fmac_f32_e32 v60, v10, v0
	ds_load_2addr_b32 v[8:9], v132 offset0:160 offset1:176
	v_fmac_f32_e32 v51, v6, v1
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v57, v10, v13 :: v_dual_fmac_f32 v56, v11, v16
	v_fmac_f32_e32 v52, v6, v0
	ds_load_2addr_b32 v[0:1], v132 offset0:224 offset1:240
	v_fmac_f32_e32 v73, v28, v38
	v_fmac_f32_e32 v74, v28, v37
	v_fmac_f32_e32 v71, v28, v40
	v_fmac_f32_e32 v72, v28, v39
	v_fmac_f32_e32 v69, v28, v42
	v_fmac_f32_e32 v70, v28, v41
	v_fmac_f32_e32 v54, v10, v24
	v_fmac_f32_e32 v73, v29, v136
	v_fmac_f32_e32 v74, v29, v135
	v_fmac_f32_e32 v71, v29, v138
	v_fmac_f32_e32 v72, v29, v137
	v_fmac_f32_e32 v69, v29, v44
	v_dual_fmac_f32 v70, v29, v43 :: v_dual_fmac_f32 v55, v10, v21
	v_fmac_f32_e32 v107, v2, v13
	v_fmac_f32_e32 v108, v2, v12
	v_fmac_f32_e32 v105, v2, v21
	v_fmac_f32_e32 v106, v2, v20
	s_waitcnt lgkmcnt(0)
	v_dual_fmac_f32 v101, v2, v25 :: v_dual_fmac_f32 v54, v11, v0
	v_dual_fmac_f32 v58, v10, v12 :: v_dual_fmac_f32 v55, v11, v17
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_fmac_f32 v104, v2, v24 :: v_dual_fmac_f32 v101, v3, v1
	v_fmac_f32_e32 v97, v26, v13
	v_fmac_f32_e32 v98, v26, v12
	v_fmac_f32_e32 v95, v26, v21
	v_fmac_f32_e32 v96, v26, v20
	v_fmac_f32_e32 v93, v26, v25
	v_fmac_f32_e32 v94, v26, v24
	v_fmac_f32_e32 v89, v22, v13
	v_fmac_f32_e32 v90, v22, v12
	v_fmac_f32_e32 v87, v22, v21
	v_fmac_f32_e32 v88, v22, v20
	v_fmac_f32_e32 v85, v22, v25
	v_fmac_f32_e32 v86, v22, v24
	v_fmac_f32_e32 v81, v14, v13
	v_fmac_f32_e32 v82, v14, v12
	v_fmac_f32_e32 v79, v14, v21
	v_fmac_f32_e32 v80, v14, v20
	v_fmac_f32_e32 v77, v14, v25
	v_fmac_f32_e32 v78, v14, v24
	v_fmac_f32_e32 v73, v30, v13
	v_fmac_f32_e32 v74, v30, v12
	v_fmac_f32_e32 v71, v30, v21
	v_fmac_f32_e32 v72, v30, v20
	v_fmac_f32_e32 v69, v30, v25
	v_fmac_f32_e32 v70, v30, v24
	v_fmac_f32_e32 v65, v18, v13
	v_fmac_f32_e32 v66, v18, v12
	v_fmac_f32_e32 v63, v18, v21
	v_fmac_f32_e32 v64, v18, v20
	v_dual_fmac_f32 v61, v18, v25 :: v_dual_fmac_f32 v58, v11, v8
	v_fmac_f32_e32 v62, v18, v24
	v_fmac_f32_e32 v49, v6, v13
	v_fmac_f32_e32 v50, v6, v12
	v_fmac_f32_e32 v47, v6, v21
	v_fmac_f32_e32 v48, v6, v20
	v_fmac_f32_e32 v45, v6, v25
	v_dual_fmac_f32 v46, v6, v24 :: v_dual_fmac_f32 v109, v3, v5
	v_fmac_f32_e32 v110, v3, v4
	v_fmac_f32_e32 v107, v3, v9
	v_fmac_f32_e32 v108, v3, v8
	v_fmac_f32_e32 v105, v3, v17
	v_fmac_f32_e32 v106, v3, v16
	v_fmac_f32_e32 v104, v3, v0
	v_fmac_f32_e32 v99, v27, v5
	v_fmac_f32_e32 v100, v27, v4
	v_fmac_f32_e32 v97, v27, v9
	v_fmac_f32_e32 v98, v27, v8
	v_fmac_f32_e32 v95, v27, v17
	v_fmac_f32_e32 v96, v27, v16
	v_fmac_f32_e32 v93, v27, v1
	v_fmac_f32_e32 v94, v27, v0
	v_fmac_f32_e32 v91, v23, v5
	v_fmac_f32_e32 v92, v23, v4
	v_fmac_f32_e32 v89, v23, v9
	v_fmac_f32_e32 v90, v23, v8
	v_fmac_f32_e32 v87, v23, v17
	v_fmac_f32_e32 v88, v23, v16
	v_fmac_f32_e32 v85, v23, v1
	v_fmac_f32_e32 v86, v23, v0
	v_fmac_f32_e32 v83, v15, v5
	v_fmac_f32_e32 v84, v15, v4
	v_fmac_f32_e32 v81, v15, v9
	v_fmac_f32_e32 v82, v15, v8
	v_fmac_f32_e32 v79, v15, v17
	v_fmac_f32_e32 v80, v15, v16
	v_fmac_f32_e32 v77, v15, v1
	v_fmac_f32_e32 v78, v15, v0
	v_fmac_f32_e32 v75, v31, v5
	v_fmac_f32_e32 v76, v31, v4
	v_fmac_f32_e32 v73, v31, v9
	v_fmac_f32_e32 v74, v31, v8
	v_fmac_f32_e32 v71, v31, v17
	v_fmac_f32_e32 v72, v31, v16
	v_fmac_f32_e32 v69, v31, v1
	v_fmac_f32_e32 v70, v31, v0
	v_fmac_f32_e32 v67, v19, v5
	v_fmac_f32_e32 v68, v19, v4
	v_fmac_f32_e32 v65, v19, v9
	v_fmac_f32_e32 v66, v19, v8
	v_fmac_f32_e32 v63, v19, v17
	v_fmac_f32_e32 v64, v19, v16
	v_fmac_f32_e32 v61, v19, v1
	v_fmac_f32_e32 v62, v19, v0
	v_fmac_f32_e32 v59, v11, v5
	v_fmac_f32_e32 v60, v11, v4
	v_fmac_f32_e32 v57, v11, v9
	v_fmac_f32_e32 v52, v7, v4
	v_fmac_f32_e32 v53, v11, v1
	v_fmac_f32_e32 v51, v7, v5
	v_fmac_f32_e32 v49, v7, v9
	v_fmac_f32_e32 v50, v7, v8
	v_fmac_f32_e32 v47, v7, v17
	v_fmac_f32_e32 v48, v7, v16
	v_fmac_f32_e32 v45, v7, v1
	v_fmac_f32_e32 v46, v7, v0
	s_barrier
	buffer_gl0_inv
	s_cbranch_scc1 .LBB36_20
.LBB36_3:                               ; %.preheader129
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v0, s16, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s4, s14, v0
	v_mov_b32_e32 v0, 0
	s_and_b32 s5, s0, s4
	s_and_saveexec_b32 s17, s5
	s_cbranch_execz .LBB36_5
; %bb.4:                                ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v0, s16, v36
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s5, s8, v0
	v_add_co_ci_u32_e64 v1, null, s9, v1, s5
	global_load_b32 v0, v[0:1], off
.LBB36_5:                               ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s17
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v2, 0
	s_and_b32 s5, s1, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v113, v0
	s_and_saveexec_b32 s17, s5
	s_cbranch_execz .LBB36_7
; %bb.6:                                ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v2, s16, v35
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, s5, s8, v2
	v_add_co_ci_u32_e64 v3, null, s9, v3, s5
	global_load_b32 v2, v[2:3], off
.LBB36_7:                               ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s17
	s_and_b32 s5, s2, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v114, v2
	s_and_saveexec_b32 s17, s5
	s_cbranch_execz .LBB36_9
; %bb.8:                                ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v0, s16, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s5, s8, v0
	v_add_co_ci_u32_e64 v1, null, s9, v1, s5
	global_load_b32 v1, v[0:1], off
.LBB36_9:                               ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s17
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v2, 0
	s_and_b32 s4, s3, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v115, v1
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB36_11
; %bb.10:                               ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v1, s16, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, s4, s8, v1
	v_add_co_ci_u32_e64 v2, null, s9, v2, s4
	global_load_b32 v2, v[1:2], off
.LBB36_11:                              ; %.preheader128.preheader
                                        ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v1, s16, v116
	s_waitcnt vmcnt(0)
	ds_store_b32 v120, v2
	v_cmp_gt_i32_e64 s4, s14, v1
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB36_13
; %bb.12:                               ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v0, v129, v126
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s4, s10, v0
	v_add_co_ci_u32_e64 v1, null, s11, v1, s4
	global_load_b32 v0, v[0:1], off
.LBB36_13:                              ; %.preheader128.1
                                        ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_dual_mov_b32 v2, 0 :: v_dual_add_nc_u32 v1, s16, v117
	s_waitcnt vmcnt(0)
	ds_store_b32 v121, v0
	v_cmp_gt_i32_e64 s4, s14, v1
	v_mov_b32_e32 v1, 0
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB36_15
; %bb.14:                               ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v2, v128, v126
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, s4, s10, v2
	v_add_co_ci_u32_e64 v3, null, s11, v3, s4
	global_load_b32 v2, v[2:3], off
.LBB36_15:                              ; %.preheader128.2
                                        ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v0, s16, v118
	s_waitcnt vmcnt(0)
	ds_store_b32 v122, v2
	v_cmp_gt_i32_e64 s4, s14, v0
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB36_17
; %bb.16:                               ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v0, v127, v126
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s4, s10, v0
	v_add_co_ci_u32_e64 v1, null, s11, v1, s4
	global_load_b32 v1, v[0:1], off
.LBB36_17:                              ; %.preheader128.3
                                        ;   in Loop: Header=BB36_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v0, s16, v119
	s_waitcnt vmcnt(0)
	ds_store_b32 v123, v1
	v_cmp_gt_i32_e64 s4, s14, v0
	v_mov_b32_e32 v0, 0
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB36_2
; %bb.18:                               ;   in Loop: Header=BB36_3 Depth=1
	v_add_nc_u32_e32 v0, v125, v126
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s4, s10, v0
	v_add_co_ci_u32_e64 v1, null, s11, v1, s4
	global_load_b32 v0, v[0:1], off
	s_branch .LBB36_2
.LBB36_19:
	v_dual_mov_b32 v110, 0 :: v_dual_mov_b32 v109, 0
	v_dual_mov_b32 v108, 0 :: v_dual_mov_b32 v107, 0
	v_dual_mov_b32 v106, 0 :: v_dual_mov_b32 v105, 0
	v_dual_mov_b32 v104, 0 :: v_dual_mov_b32 v101, 0
	v_dual_mov_b32 v100, 0 :: v_dual_mov_b32 v99, 0
	v_dual_mov_b32 v98, 0 :: v_dual_mov_b32 v97, 0
	v_dual_mov_b32 v96, 0 :: v_dual_mov_b32 v95, 0
	v_dual_mov_b32 v94, 0 :: v_dual_mov_b32 v93, 0
	v_dual_mov_b32 v92, 0 :: v_dual_mov_b32 v91, 0
	v_dual_mov_b32 v90, 0 :: v_dual_mov_b32 v89, 0
	v_dual_mov_b32 v88, 0 :: v_dual_mov_b32 v87, 0
	v_dual_mov_b32 v86, 0 :: v_dual_mov_b32 v85, 0
	v_dual_mov_b32 v84, 0 :: v_dual_mov_b32 v83, 0
	v_dual_mov_b32 v82, 0 :: v_dual_mov_b32 v81, 0
	v_dual_mov_b32 v80, 0 :: v_dual_mov_b32 v79, 0
	v_dual_mov_b32 v78, 0 :: v_dual_mov_b32 v77, 0
	v_dual_mov_b32 v76, 0 :: v_dual_mov_b32 v75, 0
	v_dual_mov_b32 v74, 0 :: v_dual_mov_b32 v73, 0
	v_dual_mov_b32 v72, 0 :: v_dual_mov_b32 v71, 0
	v_dual_mov_b32 v70, 0 :: v_dual_mov_b32 v69, 0
	v_dual_mov_b32 v68, 0 :: v_dual_mov_b32 v67, 0
	v_dual_mov_b32 v66, 0 :: v_dual_mov_b32 v65, 0
	v_dual_mov_b32 v64, 0 :: v_dual_mov_b32 v63, 0
	v_dual_mov_b32 v62, 0 :: v_dual_mov_b32 v61, 0
	v_dual_mov_b32 v60, 0 :: v_dual_mov_b32 v59, 0
	v_dual_mov_b32 v58, 0 :: v_dual_mov_b32 v57, 0
	v_dual_mov_b32 v56, 0 :: v_dual_mov_b32 v55, 0
	v_dual_mov_b32 v54, 0 :: v_dual_mov_b32 v53, 0
	v_dual_mov_b32 v52, 0 :: v_dual_mov_b32 v51, 0
	v_dual_mov_b32 v50, 0 :: v_dual_mov_b32 v49, 0
	v_dual_mov_b32 v48, 0 :: v_dual_mov_b32 v47, 0
	v_dual_mov_b32 v46, 0 :: v_dual_mov_b32 v45, 0
.LBB36_20:                              ; %.preheader123
	v_add_nc_u32_e32 v4, s6, v102
	v_add_nc_u32_e32 v0, s7, v103
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v9, v4, s14
	v_cmp_gt_i32_e64 s7, s14, v4
	v_cmp_gt_i32_e32 vcc_lo, s14, v0
	s_and_b32 s0, s7, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB36_22
; %bb.21:
	v_add_nc_u32_e32 v1, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, s0, s12, v1
	v_add_co_ci_u32_e64 v2, null, s13, v2, s0
	global_store_b32 v[1:2], v110, off
.LBB36_22:
	s_or_b32 exec_lo, exec_lo, s1
	v_add_nc_u32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s0, s14, v1
	s_and_b32 s1, s7, s0
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB36_24
; %bb.23:
	v_add_nc_u32_e32 v2, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, s1, s12, v2
	v_add_co_ci_u32_e64 v3, null, s13, v3, s1
	global_store_b32 v[2:3], v109, off
.LBB36_24:
	s_or_b32 exec_lo, exec_lo, s2
	v_add_nc_u32_e32 v2, 32, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s1, s14, v2
	s_and_b32 s2, s7, s1
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB36_26
; %bb.25:
	v_add_nc_u32_e32 v5, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64 v[5:6], 2, v[5:6]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v5, s2, s12, v5
	v_add_co_ci_u32_e64 v6, null, s13, v6, s2
	global_store_b32 v[5:6], v108, off
.LBB36_26:
	s_or_b32 exec_lo, exec_lo, s3
	v_add_nc_u32_e32 v3, 48, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s2, s14, v3
	s_and_b32 s3, s7, s2
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB36_28
; %bb.27:
	v_add_nc_u32_e32 v5, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v6, 31, v5
	v_lshlrev_b64 v[5:6], 2, v[5:6]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v5, s3, s12, v5
	v_add_co_ci_u32_e64 v6, null, s13, v6, s3
	global_store_b32 v[5:6], v107, off
.LBB36_28:
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v5, 64, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s3, s14, v5
	s_and_b32 s4, s7, s3
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB36_30
; %bb.29:
	v_add_nc_u32_e32 v6, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s12, v6
	v_add_co_ci_u32_e64 v7, null, s13, v7, s4
	global_store_b32 v[6:7], v106, off
.LBB36_30:
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v6, 0x50, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s4, s14, v6
	s_and_b32 s5, s7, s4
	s_and_saveexec_b32 s6, s5
	s_cbranch_execz .LBB36_32
; %bb.31:
	v_add_nc_u32_e32 v7, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v8, 31, v7
	v_lshlrev_b64 v[7:8], 2, v[7:8]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v7, s5, s12, v7
	v_add_co_ci_u32_e64 v8, null, s13, v8, s5
	global_store_b32 v[7:8], v105, off
.LBB36_32:
	s_or_b32 exec_lo, exec_lo, s6
	v_add_nc_u32_e32 v7, 0x60, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s5, s14, v7
	s_and_b32 s6, s7, s5
	s_and_saveexec_b32 s8, s6
	s_cbranch_execz .LBB36_34
; %bb.33:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s6, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s6
	global_store_b32 v[10:11], v104, off
.LBB36_34:
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v8, 0x70, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s6, s14, v8
	s_and_b32 s7, s7, s6
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_36
; %bb.35:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v101, off
.LBB36_36:                              ; %.preheader.1
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v10, 16, v4
	s_lshl_b32 s9, s14, 4
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v9, s9, v9
	v_cmp_gt_i32_e64 s7, s14, v10
	s_and_b32 s8, s7, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_99
; %bb.37:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_100
.LBB36_38:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_101
.LBB36_39:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_102
.LBB36_40:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_103
.LBB36_41:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_104
.LBB36_42:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_105
.LBB36_43:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_45
.LBB36_44:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v93, off
.LBB36_45:                              ; %.preheader.2
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v10, 32, v4
	v_add_nc_u32_e32 v9, s9, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v10
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_106
; %bb.46:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_107
.LBB36_47:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_108
.LBB36_48:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_109
.LBB36_49:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_110
.LBB36_50:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_111
.LBB36_51:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_112
.LBB36_52:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_54
.LBB36_53:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v85, off
.LBB36_54:                              ; %.preheader.3
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v10, 48, v4
	v_add_nc_u32_e32 v9, s9, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v10
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_113
; %bb.55:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_114
.LBB36_56:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_115
.LBB36_57:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_116
.LBB36_58:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_117
.LBB36_59:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_118
.LBB36_60:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_119
.LBB36_61:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_63
.LBB36_62:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v77, off
.LBB36_63:                              ; %.preheader.4
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v10, 64, v4
	v_add_nc_u32_e32 v9, s9, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v10
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_120
; %bb.64:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_121
.LBB36_65:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_122
.LBB36_66:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_123
.LBB36_67:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_124
.LBB36_68:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_125
.LBB36_69:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_126
.LBB36_70:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_72
.LBB36_71:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v69, off
.LBB36_72:                              ; %.preheader.5
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v10, 0x50, v4
	v_add_nc_u32_e32 v9, s9, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v10
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_127
; %bb.73:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_128
.LBB36_74:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_129
.LBB36_75:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_130
.LBB36_76:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_131
.LBB36_77:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_132
.LBB36_78:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_133
.LBB36_79:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_81
.LBB36_80:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v61, off
.LBB36_81:                              ; %.preheader.6
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v10, 0x60, v4
	v_add_nc_u32_e32 v9, s9, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v10
	s_and_b32 s8, s7, vcc_lo
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_134
; %bb.82:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_135
.LBB36_83:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_136
.LBB36_84:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_137
.LBB36_85:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_138
.LBB36_86:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_139
.LBB36_87:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execnz .LBB36_140
.LBB36_88:
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execz .LBB36_90
.LBB36_89:
	v_add_nc_u32_e32 v10, v8, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s7, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s7
	global_store_b32 v[10:11], v53, off
.LBB36_90:                              ; %.preheader.7
	s_or_b32 exec_lo, exec_lo, s8
	v_add_nc_u32_e32 v4, 0x70, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s7, s14, v4
	v_add_nc_u32_e32 v4, s9, v9
	s_and_b32 s9, s7, vcc_lo
	s_and_saveexec_b32 s8, s9
	s_cbranch_execnz .LBB36_141
; %bb.91:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s8
	s_cbranch_execnz .LBB36_142
.LBB36_92:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB36_143
.LBB36_93:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB36_144
.LBB36_94:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB36_145
.LBB36_95:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB36_146
.LBB36_96:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB36_147
.LBB36_97:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execnz .LBB36_148
.LBB36_98:
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
.LBB36_99:
	v_add_nc_u32_e32 v10, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v100, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_38
.LBB36_100:
	v_add_nc_u32_e32 v10, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v99, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_39
.LBB36_101:
	v_add_nc_u32_e32 v10, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v98, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_40
.LBB36_102:
	v_add_nc_u32_e32 v10, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v97, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_41
.LBB36_103:
	v_add_nc_u32_e32 v10, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v96, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_42
.LBB36_104:
	v_add_nc_u32_e32 v10, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v95, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_43
.LBB36_105:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v94, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB36_44
	s_branch .LBB36_45
.LBB36_106:
	v_add_nc_u32_e32 v10, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v92, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_47
.LBB36_107:
	v_add_nc_u32_e32 v10, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v91, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_48
.LBB36_108:
	v_add_nc_u32_e32 v10, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v90, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_49
.LBB36_109:
	v_add_nc_u32_e32 v10, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v89, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_50
.LBB36_110:
	v_add_nc_u32_e32 v10, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v88, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_51
.LBB36_111:
	v_add_nc_u32_e32 v10, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v87, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_52
.LBB36_112:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v86, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB36_53
	s_branch .LBB36_54
.LBB36_113:
	v_add_nc_u32_e32 v10, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v84, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_56
.LBB36_114:
	v_add_nc_u32_e32 v10, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v83, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_57
.LBB36_115:
	v_add_nc_u32_e32 v10, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v82, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_58
.LBB36_116:
	v_add_nc_u32_e32 v10, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v81, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_59
.LBB36_117:
	v_add_nc_u32_e32 v10, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v80, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_60
.LBB36_118:
	v_add_nc_u32_e32 v10, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v79, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_61
.LBB36_119:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v78, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB36_62
	s_branch .LBB36_63
.LBB36_120:
	v_add_nc_u32_e32 v10, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v76, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_65
.LBB36_121:
	v_add_nc_u32_e32 v10, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v75, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_66
.LBB36_122:
	v_add_nc_u32_e32 v10, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v74, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_67
.LBB36_123:
	v_add_nc_u32_e32 v10, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v73, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_68
.LBB36_124:
	v_add_nc_u32_e32 v10, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v72, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_69
.LBB36_125:
	v_add_nc_u32_e32 v10, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v71, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_70
.LBB36_126:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v70, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB36_71
	s_branch .LBB36_72
.LBB36_127:
	v_add_nc_u32_e32 v10, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v68, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_74
.LBB36_128:
	v_add_nc_u32_e32 v10, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v67, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_75
.LBB36_129:
	v_add_nc_u32_e32 v10, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v66, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_76
.LBB36_130:
	v_add_nc_u32_e32 v10, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v65, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_77
.LBB36_131:
	v_add_nc_u32_e32 v10, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v64, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_78
.LBB36_132:
	v_add_nc_u32_e32 v10, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v63, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_79
.LBB36_133:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v62, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB36_80
	s_branch .LBB36_81
.LBB36_134:
	v_add_nc_u32_e32 v10, v0, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v60, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_83
.LBB36_135:
	v_add_nc_u32_e32 v10, v1, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v59, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_84
.LBB36_136:
	v_add_nc_u32_e32 v10, v2, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v58, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_85
.LBB36_137:
	v_add_nc_u32_e32 v10, v3, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v57, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_86
.LBB36_138:
	v_add_nc_u32_e32 v10, v5, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v56, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_87
.LBB36_139:
	v_add_nc_u32_e32 v10, v6, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v55, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s8, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s10, s8
	s_cbranch_execz .LBB36_88
.LBB36_140:
	v_add_nc_u32_e32 v10, v7, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshlrev_b64 v[10:11], 2, v[10:11]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v10, s8, s12, v10
	v_add_co_ci_u32_e64 v11, null, s13, v11, s8
	global_store_b32 v[10:11], v54, off
	s_or_b32 exec_lo, exec_lo, s10
	s_and_b32 s7, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s7
	s_cbranch_execnz .LBB36_89
	s_branch .LBB36_90
.LBB36_141:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v9, v0, v4
	v_ashrrev_i32_e32 v10, 31, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[9:10], 2, v[9:10]
	v_add_co_u32 v9, vcc_lo, s12, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v10, null, s13, v10, vcc_lo
	global_store_b32 v[9:10], v52, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s8, s7, s0
	s_and_saveexec_b32 s0, s8
	s_cbranch_execz .LBB36_92
.LBB36_142:
	v_add_nc_u32_e32 v0, v1, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v51, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB36_93
.LBB36_143:
	v_add_nc_u32_e32 v0, v2, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v50, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB36_94
.LBB36_144:
	v_add_nc_u32_e32 v0, v3, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v49, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s3
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB36_95
.LBB36_145:
	v_add_nc_u32_e32 v0, v5, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v48, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s4
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB36_96
.LBB36_146:
	v_add_nc_u32_e32 v0, v6, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v47, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s7, s5
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB36_97
.LBB36_147:
	v_add_nc_u32_e32 v0, v7, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v46, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s7, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB36_98
.LBB36_148:
	v_add_nc_u32_e32 v0, v8, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s12, v0
	v_add_co_ci_u32_e64 v1, null, s13, v1, vcc_lo
	global_store_b32 v[0:1], v45, off
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _ZN3clk3hip8gemm_regILi128ELi128ELi8ELi8ELi8ELb0EEEviPKfS3_Pf
		.amdhsa_group_segment_fixed_size 8192
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
		.amdhsa_next_free_vgpr 139
		.amdhsa_next_free_sgpr 18
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
	.section	.text._ZN3clk3hip8gemm_regILi128ELi128ELi8ELi8ELi8ELb0EEEviPKfS3_Pf,"axG",@progbits,_ZN3clk3hip8gemm_regILi128ELi128ELi8ELi8ELi8ELb0EEEviPKfS3_Pf,comdat
