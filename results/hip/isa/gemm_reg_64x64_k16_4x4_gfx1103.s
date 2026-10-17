_ZN3clk3hip8gemm_regILi64ELi64ELi16ELi4ELi4ELb0EEEviPKfS3_Pf: ; @_ZN3clk3hip8gemm_regILi64ELi64ELi16ELi4ELi4ELb0EEEviPKfS3_Pf
; %bb.0:                                ; %.preheader131
	s_clause 0x2
	s_load_b32 s12, s[0:1], 0x0
	s_load_b128 s[8:11], s[0:1], 0x8
	s_load_b64 s[6:7], s[0:1], 0x18
	v_bfe_u32 v25, v0, 10, 10
	v_and_b32_e32 v26, 0x3ff, v0
	s_lshl_b32 s13, s3, 6
	s_lshl_b32 s14, s2, 6
	s_waitcnt lgkmcnt(0)
	s_cmp_lt_i32 s12, 1
	s_cbranch_scc1 .LBB24_19
; %bb.1:                                ; %.preheader129.lr.ph
	v_lshl_add_u32 v0, v25, 4, v26
	v_and_b32_e32 v8, 15, v26
	v_lshl_or_b32 v31, v26, 2, 0x1000
	v_dual_mov_b32 v15, 0 :: v_dual_lshlrev_b32 v30, 6, v25
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v17, 0 :: v_dual_and_b32 v2, 63, v0
	v_dual_mov_b32 v21, 0 :: v_dual_add_nc_u32 v6, 0x300, v0
	v_lshlrev_b32_e32 v1, 2, v8
	v_or_b32_e32 v7, s14, v2
	v_lshrrev_b32_e32 v3, 4, v0
	v_dual_mov_b32 v19, 0 :: v_dual_add_nc_u32 v4, 0x100, v0
	v_dual_mov_b32 v16, 0 :: v_dual_add_nc_u32 v5, 0x200, v0
	s_delay_alu instid0(VALU_DEP_4)
	v_cmp_gt_i32_e32 vcc_lo, s12, v7
	v_lshrrev_b32_e32 v7, 4, v6
	v_lshl_or_b32 v9, v2, 2, 0x1000
	v_lshrrev_b32_e32 v10, 4, v4
	v_dual_mov_b32 v23, 0 :: v_dual_add_nc_u32 v14, s13, v3
	v_lshl_or_b32 v33, v3, 6, v1
	v_dual_mov_b32 v20, 0 :: v_dual_add_nc_u32 v3, s13, v7
	v_lshrrev_b32_e32 v36, 6, v0
	v_lshrrev_b32_e32 v37, 6, v4
	v_lshrrev_b32_e32 v38, 6, v5
	v_lshrrev_b32_e32 v39, 6, v6
	v_lshrrev_b32_e32 v11, 4, v5
	v_dual_mov_b32 v18, 0 :: v_dual_add_nc_u32 v13, s13, v10
	v_lshl_or_b32 v34, v10, 6, v1
	v_lshl_add_u32 v41, v36, 8, v9
	v_lshl_add_u32 v42, v37, 8, v9
	v_lshl_add_u32 v43, v38, 8, v9
	v_lshl_add_u32 v44, v39, 8, v9
	v_mad_u64_u32 v[9:10], null, v3, s12, v[8:9]
	v_dual_mov_b32 v27, 0 :: v_dual_add_nc_u32 v12, s13, v11
	v_lshl_or_b32 v35, v11, 6, v1
	v_cmp_gt_i32_e64 s1, s12, v13
	v_mul_lo_u32 v45, s12, v39
	s_delay_alu instid0(VALU_DEP_4)
	v_cmp_gt_i32_e64 s2, s12, v12
	v_mad_u64_u32 v[10:11], null, v12, s12, v[8:9]
	v_mad_u64_u32 v[11:12], null, v13, s12, v[8:9]
	v_mul_lo_u32 v47, s12, v38
	v_mul_lo_u32 v48, s12, v37
	v_mul_lo_u32 v49, s12, v36
	v_mad_u64_u32 v[12:13], null, v14, s12, v[8:9]
	v_cmp_gt_i32_e64 s0, s12, v14
	v_cmp_gt_i32_e64 s3, s12, v3
	v_dual_mov_b32 v29, 0 :: v_dual_add_nc_u32 v46, s14, v2
	v_dual_mov_b32 v13, 0 :: v_dual_add_nc_u32 v50, 0x400, v31
	v_dual_mov_b32 v22, 0 :: v_dual_add_nc_u32 v51, 0x800, v31
	v_add_nc_u32_e32 v52, 0xc00, v31
	v_mov_b32_e32 v14, 0
	v_lshl_or_b32 v40, v7, 6, v1
	v_mov_b32_e32 v24, 0
	v_mov_b32_e32 v28, 0
	v_mov_b32_e32 v32, 0
	s_lshl_b32 s15, s12, 4
	s_mov_b32 s16, 0
	s_branch .LBB24_3
.LBB24_2:                               ; %.preheader127
                                        ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	s_waitcnt vmcnt(0)
	ds_store_b32 v44, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	ds_load_b128 v[4:7], v30
	ds_load_2addr_b32 v[65:66], v31 offset1:16
	ds_load_2addr_b32 v[67:68], v31 offset0:32 offset1:48
	ds_load_b128 v[53:56], v30 offset:1024
	ds_load_b128 v[57:60], v30 offset:2048
	ds_load_b128 v[61:64], v30 offset:3072
	ds_load_2addr_b32 v[69:70], v31 offset0:64 offset1:80
	ds_load_b128 v[0:3], v30 offset:16
	ds_load_2addr_b32 v[71:72], v31 offset0:96 offset1:112
	ds_load_2addr_b32 v[73:74], v31 offset0:224 offset1:240
	v_add_nc_u32_e32 v46, s15, v46
	s_add_i32 s16, s16, 16
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cmp_ge_i32 s16, s12
	s_waitcnt lgkmcnt(8)
	v_fmac_f32_e32 v32, v4, v65
	s_waitcnt lgkmcnt(6)
	v_dual_fmac_f32 v29, v4, v66 :: v_dual_fmac_f32 v24, v53, v65
	v_dual_fmac_f32 v28, v4, v67 :: v_dual_fmac_f32 v21, v53, v68
	v_dual_fmac_f32 v27, v4, v68 :: v_dual_fmac_f32 v22, v53, v67
	v_fmac_f32_e32 v23, v53, v66
	s_waitcnt lgkmcnt(5)
	v_fmac_f32_e32 v20, v57, v65
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v19, v57, v66 :: v_dual_fmac_f32 v24, v54, v69
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v18, v57, v67 :: v_dual_fmac_f32 v21, v54, v72
	v_dual_fmac_f32 v17, v57, v68 :: v_dual_fmac_f32 v22, v54, v71
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dual_fmac_f32 v16, v61, v65 :: v_dual_fmac_f32 v19, v58, v70
	v_dual_fmac_f32 v14, v61, v67 :: v_dual_fmac_f32 v17, v58, v72
	s_delay_alu instid0(VALU_DEP_4)
	v_dual_fmac_f32 v13, v61, v68 :: v_dual_fmac_f32 v18, v58, v71
	ds_load_2addr_b32 v[67:68], v31 offset0:160 offset1:176
	v_fmac_f32_e32 v23, v54, v70
	v_dual_fmac_f32 v15, v61, v66 :: v_dual_fmac_f32 v20, v58, v69
	ds_load_2addr_b32 v[65:66], v31 offset0:128 offset1:144
	v_fmac_f32_e32 v32, v5, v69
	v_dual_fmac_f32 v29, v5, v70 :: v_dual_fmac_f32 v16, v62, v69
	v_fmac_f32_e32 v15, v62, v70
	ds_load_2addr_b32 v[69:70], v31 offset0:192 offset1:208
	v_dual_fmac_f32 v28, v5, v71 :: v_dual_fmac_f32 v13, v62, v72
	v_dual_fmac_f32 v27, v5, v72 :: v_dual_fmac_f32 v14, v62, v71
	s_waitcnt lgkmcnt(2)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dual_fmac_f32 v28, v6, v67 :: v_dual_fmac_f32 v21, v55, v68
	v_dual_fmac_f32 v27, v6, v68 :: v_dual_fmac_f32 v22, v55, v67
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v32, v6, v65 :: v_dual_fmac_f32 v23, v55, v66
	v_dual_fmac_f32 v29, v6, v66 :: v_dual_fmac_f32 v24, v55, v65
	v_fmac_f32_e32 v20, v59, v65
	v_fmac_f32_e32 v19, v59, v66
	v_dual_fmac_f32 v18, v59, v67 :: v_dual_fmac_f32 v21, v56, v74
	v_dual_fmac_f32 v17, v59, v68 :: v_dual_fmac_f32 v22, v56, v73
	v_fmac_f32_e32 v14, v63, v67
	s_delay_alu instid0(VALU_DEP_3)
	v_dual_fmac_f32 v13, v63, v68 :: v_dual_fmac_f32 v18, v60, v73
	v_fmac_f32_e32 v28, v7, v73
	s_waitcnt lgkmcnt(0)
	v_fmac_f32_e32 v24, v56, v69
	v_dual_fmac_f32 v16, v63, v65 :: v_dual_fmac_f32 v19, v60, v70
	v_fmac_f32_e32 v29, v7, v70
	ds_load_2addr_b32 v[67:68], v50 offset0:32 offset1:48
	v_fmac_f32_e32 v23, v56, v70
	v_dual_fmac_f32 v15, v63, v66 :: v_dual_fmac_f32 v20, v60, v69
	v_fmac_f32_e32 v32, v7, v69
	ds_load_2addr_b32 v[65:66], v50 offset1:16
	ds_load_b128 v[53:56], v30 offset:2064
	v_fmac_f32_e32 v17, v60, v74
	v_dual_fmac_f32 v27, v7, v74 :: v_dual_fmac_f32 v14, v64, v73
	ds_load_b128 v[4:7], v30 offset:1040
	ds_load_b128 v[57:60], v30 offset:3088
	v_fmac_f32_e32 v16, v64, v69
	v_fmac_f32_e32 v15, v64, v70
	v_fmac_f32_e32 v13, v64, v74
	ds_load_2addr_b32 v[69:70], v50 offset0:64 offset1:80
	ds_load_b128 v[61:64], v30 offset:32
	ds_load_2addr_b32 v[71:72], v50 offset0:96 offset1:112
	ds_load_2addr_b32 v[73:74], v51 offset0:32 offset1:48
	s_waitcnt lgkmcnt(8)
	v_fmac_f32_e32 v28, v0, v67
	v_fmac_f32_e32 v27, v0, v68
	s_waitcnt lgkmcnt(6)
	v_dual_fmac_f32 v32, v0, v65 :: v_dual_fmac_f32 v19, v53, v66
	v_dual_fmac_f32 v29, v0, v66 :: v_dual_fmac_f32 v20, v53, v65
	v_fmac_f32_e32 v18, v53, v67
	s_waitcnt lgkmcnt(4)
	v_dual_fmac_f32 v24, v4, v65 :: v_dual_fmac_f32 v15, v57, v66
	v_dual_fmac_f32 v23, v4, v66 :: v_dual_fmac_f32 v16, v57, v65
	v_dual_fmac_f32 v22, v4, v67 :: v_dual_fmac_f32 v13, v57, v68
	v_dual_fmac_f32 v21, v4, v68 :: v_dual_fmac_f32 v14, v57, v67
	v_fmac_f32_e32 v17, v53, v68
	ds_load_2addr_b32 v[65:66], v50 offset0:128 offset1:144
	ds_load_2addr_b32 v[67:68], v50 offset0:160 offset1:176
	s_waitcnt lgkmcnt(5)
	v_dual_fmac_f32 v32, v1, v69 :: v_dual_fmac_f32 v19, v54, v70
	v_dual_fmac_f32 v29, v1, v70 :: v_dual_fmac_f32 v20, v54, v69
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v28, v1, v71 :: v_dual_fmac_f32 v17, v54, v72
	v_dual_fmac_f32 v27, v1, v72 :: v_dual_fmac_f32 v18, v54, v71
	ds_load_2addr_b32 v[0:1], v50 offset0:192 offset1:208
	ds_load_2addr_b32 v[53:54], v50 offset0:224 offset1:240
	v_dual_fmac_f32 v24, v5, v69 :: v_dual_fmac_f32 v15, v58, v70
	v_dual_fmac_f32 v23, v5, v70 :: v_dual_fmac_f32 v16, v58, v69
	v_dual_fmac_f32 v22, v5, v71 :: v_dual_fmac_f32 v13, v58, v72
	v_dual_fmac_f32 v21, v5, v72 :: v_dual_fmac_f32 v14, v58, v71
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v32, v2, v65 :: v_dual_fmac_f32 v19, v55, v66
	v_dual_fmac_f32 v29, v2, v66 :: v_dual_fmac_f32 v20, v55, v65
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v28, v2, v67 :: v_dual_fmac_f32 v17, v55, v68
	v_dual_fmac_f32 v27, v2, v68 :: v_dual_fmac_f32 v18, v55, v67
	v_dual_fmac_f32 v24, v6, v65 :: v_dual_fmac_f32 v15, v59, v66
	v_dual_fmac_f32 v23, v6, v66 :: v_dual_fmac_f32 v16, v59, v65
	v_dual_fmac_f32 v22, v6, v67 :: v_dual_fmac_f32 v13, v59, v68
	v_dual_fmac_f32 v21, v6, v68 :: v_dual_fmac_f32 v14, v59, v67
	ds_load_2addr_b32 v[57:58], v51 offset1:16
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v32, v3, v0 :: v_dual_fmac_f32 v19, v56, v1
	v_dual_fmac_f32 v29, v3, v1 :: v_dual_fmac_f32 v20, v56, v0
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v28, v3, v53 :: v_dual_fmac_f32 v17, v56, v54
	v_dual_fmac_f32 v27, v3, v54 :: v_dual_fmac_f32 v18, v56, v53
	v_dual_fmac_f32 v24, v7, v0 :: v_dual_fmac_f32 v15, v60, v1
	v_dual_fmac_f32 v23, v7, v1 :: v_dual_fmac_f32 v16, v60, v0
	ds_load_b128 v[65:68], v30 offset:1056
	ds_load_b128 v[69:72], v30 offset:2080
	v_dual_fmac_f32 v22, v7, v53 :: v_dual_fmac_f32 v13, v60, v54
	v_dual_fmac_f32 v21, v7, v54 :: v_dual_fmac_f32 v14, v60, v53
	ds_load_b128 v[4:7], v30 offset:3104
	ds_load_2addr_b32 v[53:54], v51 offset0:64 offset1:80
	ds_load_b128 v[0:3], v30 offset:48
	ds_load_2addr_b32 v[55:56], v51 offset0:96 offset1:112
	s_waitcnt lgkmcnt(6)
	v_fmac_f32_e32 v32, v61, v57
	v_fmac_f32_e32 v29, v61, v58
	v_fmac_f32_e32 v28, v61, v73
	v_fmac_f32_e32 v27, v61, v74
	ds_load_2addr_b32 v[75:76], v52 offset0:32 offset1:48
	s_waitcnt lgkmcnt(4)
	v_fmac_f32_e32 v16, v4, v57
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v24, v65, v57 :: v_dual_fmac_f32 v29, v62, v54
	v_fmac_f32_e32 v19, v69, v58
	v_fmac_f32_e32 v15, v4, v58
	v_dual_fmac_f32 v23, v65, v58 :: v_dual_fmac_f32 v32, v62, v53
	v_fmac_f32_e32 v20, v69, v57
	v_fmac_f32_e32 v14, v4, v73
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v22, v65, v73 :: v_dual_fmac_f32 v27, v62, v56
	v_fmac_f32_e32 v17, v69, v74
	v_fmac_f32_e32 v13, v4, v74
	v_dual_fmac_f32 v21, v65, v74 :: v_dual_fmac_f32 v28, v62, v55
	v_fmac_f32_e32 v18, v69, v73
	ds_load_2addr_b32 v[57:58], v51 offset0:128 offset1:144
	ds_load_2addr_b32 v[73:74], v51 offset0:160 offset1:176
	v_fmac_f32_e32 v24, v66, v53
	v_fmac_f32_e32 v23, v66, v54
	v_fmac_f32_e32 v22, v66, v55
	v_fmac_f32_e32 v21, v66, v56
	v_dual_fmac_f32 v20, v70, v53 :: v_dual_fmac_f32 v15, v5, v54
	v_dual_fmac_f32 v19, v70, v54 :: v_dual_fmac_f32 v16, v5, v53
	v_dual_fmac_f32 v18, v70, v55 :: v_dual_fmac_f32 v13, v5, v56
	v_dual_fmac_f32 v17, v70, v56 :: v_dual_fmac_f32 v14, v5, v55
	ds_load_2addr_b32 v[65:66], v51 offset0:192 offset1:208
	ds_load_2addr_b32 v[69:70], v51 offset0:224 offset1:240
	ds_load_2addr_b32 v[4:5], v52 offset1:16
	ds_load_b128 v[53:56], v30 offset:1072
	s_waitcnt lgkmcnt(5)
	v_dual_fmac_f32 v32, v63, v57 :: v_dual_fmac_f32 v15, v6, v58
	v_dual_fmac_f32 v29, v63, v58 :: v_dual_fmac_f32 v16, v6, v57
	s_waitcnt lgkmcnt(4)
	v_fmac_f32_e32 v28, v63, v73
	v_dual_fmac_f32 v27, v63, v74 :: v_dual_fmac_f32 v14, v6, v73
	v_fmac_f32_e32 v24, v67, v57
	v_fmac_f32_e32 v23, v67, v58
	s_waitcnt lgkmcnt(3)
	v_dual_fmac_f32 v13, v6, v74 :: v_dual_fmac_f32 v32, v64, v65
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_fmac_f32 v22, v67, v73 :: v_dual_fmac_f32 v23, v68, v66
	v_fmac_f32_e32 v17, v71, v74
	v_fmac_f32_e32 v29, v64, v66
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v21, v67, v74 :: v_dual_fmac_f32 v28, v64, v69
	v_dual_fmac_f32 v20, v71, v57 :: v_dual_fmac_f32 v27, v64, v70
	v_dual_fmac_f32 v19, v71, v58 :: v_dual_fmac_f32 v24, v68, v65
	v_fmac_f32_e32 v18, v71, v73
	v_fmac_f32_e32 v22, v68, v69
	v_fmac_f32_e32 v21, v68, v70
	v_fmac_f32_e32 v20, v72, v65
	ds_load_b128 v[57:60], v30 offset:2096
	v_fmac_f32_e32 v19, v72, v66
	v_dual_fmac_f32 v18, v72, v69 :: v_dual_fmac_f32 v15, v7, v66
	v_dual_fmac_f32 v17, v72, v70 :: v_dual_fmac_f32 v16, v7, v65
	ds_load_2addr_b32 v[65:66], v52 offset0:64 offset1:80
	ds_load_b128 v[61:64], v30 offset:3120
	v_dual_fmac_f32 v14, v7, v69 :: v_dual_fmac_f32 v27, v0, v76
	s_waitcnt lgkmcnt(4)
	v_dual_fmac_f32 v13, v7, v70 :: v_dual_fmac_f32 v32, v0, v4
	ds_load_2addr_b32 v[6:7], v52 offset0:96 offset1:112
	s_waitcnt lgkmcnt(4)
	v_dual_fmac_f32 v29, v0, v5 :: v_dual_fmac_f32 v24, v53, v4
	v_dual_fmac_f32 v28, v0, v75 :: v_dual_fmac_f32 v23, v53, v5
	v_fmac_f32_e32 v22, v53, v75
	v_fmac_f32_e32 v21, v53, v76
	ds_load_2addr_b32 v[67:68], v52 offset0:160 offset1:176
	s_waitcnt lgkmcnt(3)
	v_fmac_f32_e32 v24, v54, v65
	v_dual_fmac_f32 v20, v57, v4 :: v_dual_fmac_f32 v23, v54, v66
	s_waitcnt lgkmcnt(1)
	v_dual_fmac_f32 v19, v57, v5 :: v_dual_fmac_f32 v22, v54, v6
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_fmac_f32 v18, v57, v75 :: v_dual_fmac_f32 v19, v58, v66
	v_fmac_f32_e32 v15, v61, v5
	v_fmac_f32_e32 v21, v54, v7
	v_dual_fmac_f32 v17, v57, v76 :: v_dual_fmac_f32 v20, v58, v65
	v_fmac_f32_e32 v16, v61, v4
	ds_load_2addr_b32 v[4:5], v52 offset0:128 offset1:144
	v_fmac_f32_e32 v18, v58, v6
	v_fmac_f32_e32 v17, v58, v7
	v_dual_fmac_f32 v13, v61, v76 :: v_dual_fmac_f32 v16, v62, v65
	v_fmac_f32_e32 v32, v1, v65
	v_dual_fmac_f32 v14, v61, v75 :: v_dual_fmac_f32 v15, v62, v66
	v_fmac_f32_e32 v27, v1, v7
	ds_load_2addr_b32 v[53:54], v52 offset0:224 offset1:240
	v_fmac_f32_e32 v13, v62, v7
	v_fmac_f32_e32 v29, v1, v66
	v_fmac_f32_e32 v14, v62, v6
	s_waitcnt lgkmcnt(2)
	v_dual_fmac_f32 v27, v2, v68 :: v_dual_fmac_f32 v22, v55, v67
	v_fmac_f32_e32 v21, v55, v68
	s_waitcnt lgkmcnt(1)
	v_fmac_f32_e32 v32, v2, v4
	v_dual_fmac_f32 v28, v1, v6 :: v_dual_fmac_f32 v29, v2, v5
	ds_load_2addr_b32 v[0:1], v52 offset0:192 offset1:208
	v_fmac_f32_e32 v23, v55, v5
	v_fmac_f32_e32 v24, v55, v4
	v_fmac_f32_e32 v28, v2, v67
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_fmac_f32_e32 v22, v56, v53
	v_dual_fmac_f32 v20, v59, v4 :: v_dual_fmac_f32 v21, v56, v54
	v_fmac_f32_e32 v15, v63, v5
	v_fmac_f32_e32 v28, v3, v53
	v_fmac_f32_e32 v27, v3, v54
	buffer_gl0_inv
	v_fmac_f32_e32 v23, v56, v1
	v_dual_fmac_f32 v19, v59, v5 :: v_dual_fmac_f32 v24, v56, v0
	v_fmac_f32_e32 v18, v59, v67
	v_fmac_f32_e32 v20, v60, v0
	v_dual_fmac_f32 v14, v63, v67 :: v_dual_fmac_f32 v15, v64, v1
	v_fmac_f32_e32 v13, v63, v68
	v_fmac_f32_e32 v19, v60, v1
	v_dual_fmac_f32 v17, v59, v68 :: v_dual_fmac_f32 v18, v60, v53
	v_fmac_f32_e32 v16, v63, v4
	v_fmac_f32_e32 v14, v64, v53
	v_dual_fmac_f32 v32, v3, v0 :: v_dual_fmac_f32 v13, v64, v54
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_fmac_f32_e32 v17, v60, v54
	v_dual_fmac_f32 v29, v3, v1 :: v_dual_fmac_f32 v16, v64, v0
	s_cbranch_scc1 .LBB24_20
.LBB24_3:                               ; %.preheader129
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v0, s16, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s4, s12, v0
	v_mov_b32_e32 v0, 0
	s_and_b32 s5, s0, s4
	s_and_saveexec_b32 s17, s5
	s_cbranch_execz .LBB24_5
; %bb.4:                                ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v0, s16, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s5, s8, v0
	v_add_co_ci_u32_e64 v1, null, s9, v1, s5
	global_load_b32 v0, v[0:1], off
.LBB24_5:                               ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s17
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v2, 0
	s_and_b32 s5, s1, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v33, v0
	s_and_saveexec_b32 s17, s5
	s_cbranch_execz .LBB24_7
; %bb.6:                                ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v2, s16, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, s5, s8, v2
	v_add_co_ci_u32_e64 v3, null, s9, v3, s5
	global_load_b32 v2, v[2:3], off
.LBB24_7:                               ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s17
	s_and_b32 s5, s2, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v34, v2
	s_and_saveexec_b32 s17, s5
	s_cbranch_execz .LBB24_9
; %bb.8:                                ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v0, s16, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s5, s8, v0
	v_add_co_ci_u32_e64 v1, null, s9, v1, s5
	global_load_b32 v1, v[0:1], off
.LBB24_9:                               ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s17
	v_mov_b32_e32 v0, 0
	v_mov_b32_e32 v2, 0
	s_and_b32 s4, s3, s4
	s_waitcnt vmcnt(0)
	ds_store_b32 v35, v1
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB24_11
; %bb.10:                               ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v1, s16, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, s4, s8, v1
	v_add_co_ci_u32_e64 v2, null, s9, v2, s4
	global_load_b32 v2, v[1:2], off
.LBB24_11:                              ; %.preheader128.preheader
                                        ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v1, s16, v36
	s_waitcnt vmcnt(0)
	ds_store_b32 v40, v2
	v_cmp_gt_i32_e64 s4, s12, v1
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB24_13
; %bb.12:                               ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v0, v49, v46
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s4, s10, v0
	v_add_co_ci_u32_e64 v1, null, s11, v1, s4
	global_load_b32 v0, v[0:1], off
.LBB24_13:                              ; %.preheader128.1
                                        ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_dual_mov_b32 v2, 0 :: v_dual_add_nc_u32 v1, s16, v37
	s_waitcnt vmcnt(0)
	ds_store_b32 v41, v0
	v_cmp_gt_i32_e64 s4, s12, v1
	v_mov_b32_e32 v1, 0
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB24_15
; %bb.14:                               ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v2, v48, v46
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, s4, s10, v2
	v_add_co_ci_u32_e64 v3, null, s11, v3, s4
	global_load_b32 v2, v[2:3], off
.LBB24_15:                              ; %.preheader128.2
                                        ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v0, s16, v38
	s_waitcnt vmcnt(0)
	ds_store_b32 v42, v2
	v_cmp_gt_i32_e64 s4, s12, v0
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB24_17
; %bb.16:                               ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v0, v47, v46
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s4, s10, v0
	v_add_co_ci_u32_e64 v1, null, s11, v1, s4
	global_load_b32 v1, v[0:1], off
.LBB24_17:                              ; %.preheader128.3
                                        ;   in Loop: Header=BB24_3 Depth=1
	s_or_b32 exec_lo, exec_lo, s5
	v_add_nc_u32_e32 v0, s16, v39
	s_waitcnt vmcnt(0)
	ds_store_b32 v43, v1
	v_cmp_gt_i32_e64 s4, s12, v0
	v_mov_b32_e32 v0, 0
	s_and_b32 s4, s4, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s5, s4
	s_cbranch_execz .LBB24_2
; %bb.18:                               ;   in Loop: Header=BB24_3 Depth=1
	v_add_nc_u32_e32 v0, v45, v46
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, s4, s10, v0
	v_add_co_ci_u32_e64 v1, null, s11, v1, s4
	global_load_b32 v0, v[0:1], off
	s_branch .LBB24_2
.LBB24_19:
	v_dual_mov_b32 v32, 0 :: v_dual_mov_b32 v29, 0
	v_dual_mov_b32 v28, 0 :: v_dual_mov_b32 v27, 0
	v_dual_mov_b32 v24, 0 :: v_dual_mov_b32 v23, 0
	v_dual_mov_b32 v22, 0 :: v_dual_mov_b32 v21, 0
	v_dual_mov_b32 v20, 0 :: v_dual_mov_b32 v19, 0
	v_dual_mov_b32 v18, 0 :: v_dual_mov_b32 v17, 0
	v_dual_mov_b32 v16, 0 :: v_dual_mov_b32 v15, 0
	v_dual_mov_b32 v14, 0 :: v_dual_mov_b32 v13, 0
.LBB24_20:                              ; %.preheader123
	v_add_nc_u32_e32 v4, s13, v25
	v_add_nc_u32_e32 v0, s14, v26
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v5, v4, s12
	v_cmp_gt_i32_e64 s3, s12, v4
	v_cmp_gt_i32_e32 vcc_lo, s12, v0
	s_and_b32 s0, s3, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB24_22
; %bb.21:
	v_add_nc_u32_e32 v1, v0, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v2, 31, v1
	v_lshlrev_b64 v[1:2], 2, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, s0, s6, v1
	v_add_co_ci_u32_e64 v2, null, s7, v2, s0
	global_store_b32 v[1:2], v32, off
.LBB24_22:
	s_or_b32 exec_lo, exec_lo, s1
	v_add_nc_u32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s0, s12, v1
	s_and_b32 s1, s3, s0
	s_and_saveexec_b32 s2, s1
	s_cbranch_execz .LBB24_24
; %bb.23:
	v_add_nc_u32_e32 v2, v1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, s1, s6, v2
	v_add_co_ci_u32_e64 v3, null, s7, v3, s1
	global_store_b32 v[2:3], v29, off
.LBB24_24:
	s_or_b32 exec_lo, exec_lo, s2
	v_add_nc_u32_e32 v2, 32, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s1, s12, v2
	s_and_b32 s2, s3, s1
	s_and_saveexec_b32 s4, s2
	s_cbranch_execz .LBB24_26
; %bb.25:
	v_add_nc_u32_e32 v6, v2, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s2, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s2
	global_store_b32 v[6:7], v28, off
.LBB24_26:
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v3, 48, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s2, s12, v3
	s_and_b32 s3, s3, s2
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB24_28
; %bb.27:
	v_add_nc_u32_e32 v6, v3, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s3, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s3
	global_store_b32 v[6:7], v27, off
.LBB24_28:                              ; %.preheader.1
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v6, 16, v4
	s_lshl_b32 s5, s12, 4
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v5, s5, v5
	v_cmp_gt_i32_e64 s3, s12, v6
	s_and_b32 s4, s3, vcc_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execnz .LBB24_43
; %bb.29:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execnz .LBB24_44
.LBB24_30:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execnz .LBB24_45
.LBB24_31:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s3, s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB24_33
.LBB24_32:
	v_add_nc_u32_e32 v6, v3, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s3, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s3
	global_store_b32 v[6:7], v21, off
.LBB24_33:                              ; %.preheader.2
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v6, 32, v4
	v_add_nc_u32_e32 v5, s5, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s3, s12, v6
	s_and_b32 s4, s3, vcc_lo
	s_and_saveexec_b32 s8, s4
	s_cbranch_execnz .LBB24_46
; %bb.34:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execnz .LBB24_47
.LBB24_35:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execnz .LBB24_48
.LBB24_36:
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s3, s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s4, s3
	s_cbranch_execz .LBB24_38
.LBB24_37:
	v_add_nc_u32_e32 v6, v3, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s3, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s3
	global_store_b32 v[6:7], v17, off
.LBB24_38:                              ; %.preheader.3
	s_or_b32 exec_lo, exec_lo, s4
	v_add_nc_u32_e32 v4, 48, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	v_cmp_gt_i32_e64 s3, s12, v4
	v_add_nc_u32_e32 v4, s5, v5
	s_and_b32 s5, s3, vcc_lo
	s_and_saveexec_b32 s4, s5
	s_cbranch_execnz .LBB24_49
; %bb.39:
	s_or_b32 exec_lo, exec_lo, s4
	s_and_b32 s4, s3, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s4
	s_cbranch_execnz .LBB24_50
.LBB24_40:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s3, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execnz .LBB24_51
.LBB24_41:
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execnz .LBB24_52
.LBB24_42:
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
.LBB24_43:
	v_add_nc_u32_e32 v6, v0, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s4
	global_store_b32 v[6:7], v24, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execz .LBB24_30
.LBB24_44:
	v_add_nc_u32_e32 v6, v1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s4
	global_store_b32 v[6:7], v23, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execz .LBB24_31
.LBB24_45:
	v_add_nc_u32_e32 v6, v2, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s4
	global_store_b32 v[6:7], v22, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s3, s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s4, s3
	s_cbranch_execnz .LBB24_32
	s_branch .LBB24_33
.LBB24_46:
	v_add_nc_u32_e32 v6, v0, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s4
	global_store_b32 v[6:7], v20, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execz .LBB24_35
.LBB24_47:
	v_add_nc_u32_e32 v6, v1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s4
	global_store_b32 v[6:7], v19, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s4, s3, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s8, s4
	s_cbranch_execz .LBB24_36
.LBB24_48:
	v_add_nc_u32_e32 v6, v2, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshlrev_b64 v[6:7], 2, v[6:7]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, s4, s6, v6
	v_add_co_ci_u32_e64 v7, null, s7, v7, s4
	global_store_b32 v[6:7], v18, off
	s_or_b32 exec_lo, exec_lo, s8
	s_and_b32 s3, s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s4, s3
	s_cbranch_execnz .LBB24_37
	s_branch .LBB24_38
.LBB24_49:
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v5, v0, v4
	v_ashrrev_i32_e32 v6, 31, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[5:6], 2, v[5:6]
	v_add_co_u32 v5, vcc_lo, s6, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_add_co_ci_u32_e64 v6, null, s7, v6, vcc_lo
	global_store_b32 v[5:6], v16, off
	s_or_b32 exec_lo, exec_lo, s4
	s_and_b32 s4, s3, s0
	s_and_saveexec_b32 s0, s4
	s_cbranch_execz .LBB24_40
.LBB24_50:
	v_add_nc_u32_e32 v0, v1, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s6, v0
	v_add_co_ci_u32_e64 v1, null, s7, v1, vcc_lo
	global_store_b32 v[0:1], v15, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s1, s3, s1
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s0, s1
	s_cbranch_execz .LBB24_41
.LBB24_51:
	v_add_nc_u32_e32 v0, v2, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s6, v0
	v_add_co_ci_u32_e64 v1, null, s7, v1, vcc_lo
	global_store_b32 v[0:1], v14, off
	s_or_b32 exec_lo, exec_lo, s0
	s_and_b32 s0, s3, s2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_saveexec_b32 s1, s0
	s_cbranch_execz .LBB24_42
.LBB24_52:
	v_add_nc_u32_e32 v0, v3, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, s6, v0
	v_add_co_ci_u32_e64 v1, null, s7, v1, vcc_lo
	global_store_b32 v[0:1], v13, off
	s_nop 0
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _ZN3clk3hip8gemm_regILi64ELi64ELi16ELi4ELi4ELb0EEEviPKfS3_Pf
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
		.amdhsa_next_free_vgpr 77
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
		.amdhsa_inst_pref_size 34
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._ZN3clk3hip8gemm_regILi64ELi64ELi16ELi4ELi4ELb0EEEviPKfS3_Pf,"axG",@progbits,_ZN3clk3hip8gemm_regILi64ELi64ELi16ELi4ELi4ELb0EEEviPKfS3_Pf,comdat
