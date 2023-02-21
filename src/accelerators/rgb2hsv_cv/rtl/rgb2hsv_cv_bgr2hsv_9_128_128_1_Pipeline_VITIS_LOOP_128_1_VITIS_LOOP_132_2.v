// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rgb2hsv_cv_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        rgb2hsv_in_data23_dout,
        rgb2hsv_in_data23_num_data_valid,
        rgb2hsv_in_data23_fifo_cap,
        rgb2hsv_in_data23_empty_n,
        rgb2hsv_in_data23_read,
        rgb2hsv_out_data24_din,
        rgb2hsv_out_data24_num_data_valid,
        rgb2hsv_out_data24_fifo_cap,
        rgb2hsv_out_data24_full_n,
        rgb2hsv_out_data24_write,
        bound
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [23:0] rgb2hsv_in_data23_dout;
input  [1:0] rgb2hsv_in_data23_num_data_valid;
input  [1:0] rgb2hsv_in_data23_fifo_cap;
input   rgb2hsv_in_data23_empty_n;
output   rgb2hsv_in_data23_read;
output  [23:0] rgb2hsv_out_data24_din;
input  [1:0] rgb2hsv_out_data24_num_data_valid;
input  [1:0] rgb2hsv_out_data24_fifo_cap;
input   rgb2hsv_out_data24_full_n;
output   rgb2hsv_out_data24_write;
input  [63:0] bound;

reg ap_idle;
reg rgb2hsv_in_data23_read;
reg rgb2hsv_out_data24_write;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_enable_reg_pp0_iter8;
reg    ap_enable_reg_pp0_iter9;
reg    ap_enable_reg_pp0_iter10;
reg    ap_enable_reg_pp0_iter11;
reg    ap_enable_reg_pp0_iter12;
reg    ap_enable_reg_pp0_iter13;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
wire    ap_block_state8_pp0_stage0_iter7;
wire    ap_block_state9_pp0_stage0_iter8;
wire    ap_block_state10_pp0_stage0_iter9;
wire    ap_block_state11_pp0_stage0_iter10;
wire    ap_block_state12_pp0_stage0_iter11;
wire    ap_block_state13_pp0_stage0_iter12;
reg    ap_block_state14_pp0_stage0_iter13;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln128_fu_216_p2;
reg    ap_condition_exit_pp0_iter1_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
wire   [9:0] xf_cv_icvSaturate8u_cv_address0;
reg    xf_cv_icvSaturate8u_cv_ce0;
wire   [7:0] xf_cv_icvSaturate8u_cv_q0;
wire   [9:0] xf_cv_icvSaturate8u_cv_address1;
reg    xf_cv_icvSaturate8u_cv_ce1;
wire   [7:0] xf_cv_icvSaturate8u_cv_q1;
wire   [9:0] xf_cv_icvSaturate8u_cv_address2;
reg    xf_cv_icvSaturate8u_cv_ce2;
wire   [7:0] xf_cv_icvSaturate8u_cv_q2;
wire   [9:0] xf_cv_icvSaturate8u_cv_address3;
reg    xf_cv_icvSaturate8u_cv_ce3;
wire   [7:0] xf_cv_icvSaturate8u_cv_q3;
wire   [7:0] void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_address0;
reg    void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_ce0;
wire   [31:0] void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_q0;
wire   [7:0] void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_address0;
reg    void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_ce0;
wire   [31:0] void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_q0;
reg    rgb2hsv_in_data23_blk_n;
wire    ap_block_pp0_stage0;
reg    rgb2hsv_out_data24_blk_n;
reg    ap_block_pp0_stage0_11001;
wire   [7:0] b_V_fu_232_p1;
reg   [7:0] b_V_reg_637;
reg   [7:0] b_V_reg_637_pp0_iter3_reg;
reg   [7:0] b_V_reg_637_pp0_iter4_reg;
reg   [7:0] b_V_reg_637_pp0_iter5_reg;
reg   [7:0] g_V_reg_644;
reg   [7:0] g_V_reg_644_pp0_iter3_reg;
reg   [7:0] g_V_reg_644_pp0_iter4_reg;
reg   [7:0] g_V_reg_644_pp0_iter5_reg;
reg   [7:0] g_V_reg_644_pp0_iter6_reg;
reg   [7:0] r_V_reg_650;
reg   [7:0] r_V_reg_650_pp0_iter3_reg;
reg   [7:0] r_V_reg_650_pp0_iter4_reg;
reg   [7:0] r_V_reg_650_pp0_iter5_reg;
wire   [8:0] zext_ln123_fu_256_p1;
reg   [8:0] zext_ln123_reg_656;
reg   [8:0] zext_ln123_reg_656_pp0_iter4_reg;
reg   [8:0] zext_ln123_reg_656_pp0_iter5_reg;
reg   [8:0] zext_ln123_reg_656_pp0_iter6_reg;
wire   [8:0] zext_ln1496_fu_259_p1;
reg   [8:0] zext_ln1496_reg_664;
reg   [8:0] zext_ln1496_reg_664_pp0_iter4_reg;
reg   [8:0] zext_ln1496_reg_664_pp0_iter5_reg;
reg   [8:0] zext_ln1496_reg_664_pp0_iter6_reg;
reg   [7:0] xf_cv_icvSaturate8u_cv_load_reg_676;
reg   [7:0] xf_cv_icvSaturate8u_cv_load_reg_676_pp0_iter5_reg;
wire   [8:0] v_3_fu_283_p2;
reg   [8:0] v_3_reg_681;
wire   [9:0] zext_ln123_1_fu_303_p1;
reg   [9:0] zext_ln123_1_reg_691;
wire   [9:0] zext_ln1496_1_fu_306_p1;
reg   [9:0] zext_ln1496_1_reg_696;
reg   [9:0] zext_ln1496_1_reg_696_pp0_iter6_reg;
wire   [7:0] vmin_V_fu_326_p2;
reg   [7:0] vmin_V_reg_706;
reg   [7:0] vmin_V_reg_706_pp0_iter6_reg;
wire   [9:0] v_fu_335_p2;
reg   [9:0] v_reg_712;
wire   [8:0] zext_ln186_1_fu_343_p1;
reg   [8:0] zext_ln186_1_reg_719;
wire   [7:0] add_ln186_fu_368_p2;
reg   [7:0] add_ln186_reg_730;
reg   [7:0] add_ln186_reg_730_pp0_iter7_reg;
reg   [7:0] add_ln186_reg_730_pp0_iter8_reg;
reg   [7:0] add_ln186_reg_730_pp0_iter9_reg;
reg   [7:0] add_ln186_reg_730_pp0_iter10_reg;
reg   [7:0] add_ln186_reg_730_pp0_iter11_reg;
reg   [7:0] add_ln186_reg_730_pp0_iter12_reg;
wire   [7:0] diff_V_fu_378_p2;
reg   [7:0] diff_V_reg_736;
wire   [0:0] vr_fu_383_p2;
reg   [0:0] vr_reg_744;
wire   [0:0] vg_fu_390_p2;
reg   [0:0] vg_reg_750;
wire   [8:0] ret_V_16_fu_399_p2;
reg   [8:0] ret_V_16_reg_761;
wire   [8:0] ret_V_10_fu_403_p2;
reg   [8:0] ret_V_10_reg_766;
wire   [8:0] ret_V_11_fu_407_p2;
reg   [8:0] ret_V_11_reg_771;
wire   [8:0] ret_V_9_fu_432_p2;
reg  signed [8:0] ret_V_9_reg_786;
wire   [12:0] and_ln157_2_fu_529_p2;
reg  signed [12:0] and_ln157_2_reg_791;
reg   [7:0] trunc_ln2_reg_806;
reg   [7:0] trunc_ln2_reg_806_pp0_iter12_reg;
wire   [7:0] add_ln161_fu_586_p2;
reg   [7:0] add_ln161_reg_811;
wire   [63:0] zext_ln541_1_fu_274_p1;
wire   [63:0] zext_ln541_2_fu_298_p1;
wire  signed [63:0] sext_ln541_fu_321_p1;
wire   [63:0] zext_ln541_3_fu_358_p1;
wire   [63:0] zext_ln156_fu_395_p1;
wire   [63:0] zext_ln541_fu_535_p1;
reg   [63:0] indvar_flatten_fu_110;
wire   [63:0] add_ln128_fu_221_p2;
wire    ap_loop_init;
reg    ap_block_pp0_stage0_01001;
wire   [8:0] ret_V_12_fu_262_p2;
wire   [8:0] add_ln1495_fu_268_p2;
wire   [8:0] zext_ln147_fu_279_p1;
wire   [8:0] ret_V_14_fu_288_p2;
wire   [8:0] ret_V_4_fu_292_p2;
wire   [9:0] ret_V_13_fu_309_p2;
wire   [9:0] ret_V_fu_315_p2;
wire   [9:0] zext_ln148_fu_331_p1;
wire   [8:0] zext_ln186_fu_340_p1;
wire   [8:0] ret_V_15_fu_346_p2;
wire   [8:0] ret_V_6_fu_352_p2;
wire   [7:0] add_ln186_1_fu_363_p2;
wire   [7:0] sub_ln186_fu_373_p2;
wire   [9:0] zext_ln1019_fu_387_p1;
wire   [8:0] select_ln126_fu_411_p3;
wire   [0:0] xor_ln157_fu_437_p2;
wire   [8:0] shl_ln_fu_453_p3;
wire   [10:0] zext_ln157_fu_460_p1;
wire  signed [10:0] sext_ln157_fu_450_p1;
wire   [10:0] add_ln157_fu_464_p2;
wire   [10:0] select_ln126_1_fu_418_p3;
wire   [10:0] and_ln157_fu_470_p2;
wire   [0:0] xor_ln157_1_fu_480_p2;
wire   [9:0] shl_ln157_1_fu_496_p3;
wire   [11:0] zext_ln157_1_fu_503_p1;
wire  signed [11:0] sext_ln157_2_fu_493_p1;
wire   [11:0] add_ln157_1_fu_507_p2;
wire   [11:0] select_ln1496_1_fu_485_p3;
wire   [11:0] and_ln157_1_fu_513_p2;
wire  signed [12:0] sext_ln157_3_fu_519_p1;
wire  signed [12:0] sext_ln157_1_fu_476_p1;
wire   [12:0] add_ln157_2_fu_523_p2;
wire   [12:0] select_ln1496_fu_442_p3;
wire   [16:0] trunc_ln158_fu_545_p1;
wire  signed [19:0] trunc_ln2_fu_553_p1;
wire   [19:0] grp_fu_600_p3;
wire  signed [29:0] tmp_fu_562_p1;
wire   [29:0] grp_fu_609_p4;
wire  signed [29:0] trunc_ln159_1_fu_569_p1;
wire   [0:0] tmp_fu_562_p3;
wire   [7:0] select_ln159_fu_578_p3;
wire   [7:0] trunc_ln159_1_fu_569_p4;
wire  signed [19:0] grp_fu_600_p0;
wire   [7:0] grp_fu_600_p1;
wire   [11:0] grp_fu_600_p2;
wire   [16:0] grp_fu_609_p2;
wire   [11:0] grp_fu_609_p3;
reg    grp_fu_600_ce;
reg    grp_fu_609_ce;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg    ap_loop_exit_ready_pp0_iter4_reg;
reg    ap_loop_exit_ready_pp0_iter5_reg;
reg    ap_loop_exit_ready_pp0_iter6_reg;
reg    ap_loop_exit_ready_pp0_iter7_reg;
reg    ap_loop_exit_ready_pp0_iter8_reg;
reg    ap_loop_exit_ready_pp0_iter9_reg;
reg    ap_loop_exit_ready_pp0_iter10_reg;
reg    ap_loop_exit_ready_pp0_iter11_reg;
reg    ap_loop_exit_ready_pp0_iter12_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire   [19:0] grp_fu_600_p10;
wire   [29:0] grp_fu_609_p20;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter7 = 1'b0;
#0 ap_enable_reg_pp0_iter8 = 1'b0;
#0 ap_enable_reg_pp0_iter9 = 1'b0;
#0 ap_enable_reg_pp0_iter10 = 1'b0;
#0 ap_enable_reg_pp0_iter11 = 1'b0;
#0 ap_enable_reg_pp0_iter12 = 1'b0;
#0 ap_enable_reg_pp0_iter13 = 1'b0;
#0 ap_done_reg = 1'b0;
end

rgb2hsv_cv_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2_xf_cv_icvSaturbkb #(
    .DataWidth( 8 ),
    .AddressRange( 769 ),
    .AddressWidth( 10 ))
xf_cv_icvSaturate8u_cv_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(xf_cv_icvSaturate8u_cv_address0),
    .ce0(xf_cv_icvSaturate8u_cv_ce0),
    .q0(xf_cv_icvSaturate8u_cv_q0),
    .address1(xf_cv_icvSaturate8u_cv_address1),
    .ce1(xf_cv_icvSaturate8u_cv_ce1),
    .q1(xf_cv_icvSaturate8u_cv_q1),
    .address2(xf_cv_icvSaturate8u_cv_address2),
    .ce2(xf_cv_icvSaturate8u_cv_ce2),
    .q2(xf_cv_icvSaturate8u_cv_q2),
    .address3(xf_cv_icvSaturate8u_cv_address3),
    .ce3(xf_cv_icvSaturate8u_cv_ce3),
    .q3(xf_cv_icvSaturate8u_cv_q3)
);

rgb2hsv_cv_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2_void_bgr2hsv_Mcud #(
    .DataWidth( 32 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_address0),
    .ce0(void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_ce0),
    .q0(void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_q0)
);

rgb2hsv_cv_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2_void_bgr2hsv_MdEe #(
    .DataWidth( 32 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_address0),
    .ce0(void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_ce0),
    .q0(void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_q0)
);

rgb2hsv_cv_mac_muladd_20s_8ns_12ns_20_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 20 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 12 ),
    .dout_WIDTH( 20 ))
mac_muladd_20s_8ns_12ns_20_4_1_U57(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_600_p0),
    .din1(grp_fu_600_p1),
    .din2(grp_fu_600_p2),
    .ce(grp_fu_600_ce),
    .dout(grp_fu_600_p3)
);

rgb2hsv_cv_ama_addmuladd_13s_9s_17ns_12ns_30_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 13 ),
    .din1_WIDTH( 9 ),
    .din2_WIDTH( 17 ),
    .din3_WIDTH( 12 ),
    .dout_WIDTH( 30 ))
ama_addmuladd_13s_9s_17ns_12ns_30_4_1_U58(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(and_ln157_2_reg_791),
    .din1(ret_V_9_reg_786),
    .din2(grp_fu_609_p2),
    .din3(grp_fu_609_p3),
    .ce(grp_fu_609_ce),
    .dout(grp_fu_609_p4)
);

rgb2hsv_cv_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter1_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_loop_exit_ready_pp0_iter12_reg == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter1_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter10 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter10 <= ap_enable_reg_pp0_iter9;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter11 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter11 <= ap_enable_reg_pp0_iter10;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter12 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter12 <= ap_enable_reg_pp0_iter11;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter13 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter13 <= ap_enable_reg_pp0_iter12;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter1_stage0)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter8 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter8 <= ap_enable_reg_pp0_iter7;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter9 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter9 <= ap_enable_reg_pp0_iter8;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        if ((ap_loop_init == 1'b1)) begin
            indvar_flatten_fu_110 <= 64'd0;
        end else if (((ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln128_fu_216_p2 == 1'd0))) begin
            indvar_flatten_fu_110 <= add_ln128_fu_221_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        add_ln161_reg_811 <= add_ln161_fu_586_p2;
        add_ln186_reg_730 <= add_ln186_fu_368_p2;
        add_ln186_reg_730_pp0_iter10_reg <= add_ln186_reg_730_pp0_iter9_reg;
        add_ln186_reg_730_pp0_iter11_reg <= add_ln186_reg_730_pp0_iter10_reg;
        add_ln186_reg_730_pp0_iter12_reg <= add_ln186_reg_730_pp0_iter11_reg;
        add_ln186_reg_730_pp0_iter7_reg <= add_ln186_reg_730;
        add_ln186_reg_730_pp0_iter8_reg <= add_ln186_reg_730_pp0_iter7_reg;
        add_ln186_reg_730_pp0_iter9_reg <= add_ln186_reg_730_pp0_iter8_reg;
        and_ln157_2_reg_791 <= and_ln157_2_fu_529_p2;
        ap_loop_exit_ready_pp0_iter10_reg <= ap_loop_exit_ready_pp0_iter9_reg;
        ap_loop_exit_ready_pp0_iter11_reg <= ap_loop_exit_ready_pp0_iter10_reg;
        ap_loop_exit_ready_pp0_iter12_reg <= ap_loop_exit_ready_pp0_iter11_reg;
        ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
        ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
        ap_loop_exit_ready_pp0_iter6_reg <= ap_loop_exit_ready_pp0_iter5_reg;
        ap_loop_exit_ready_pp0_iter7_reg <= ap_loop_exit_ready_pp0_iter6_reg;
        ap_loop_exit_ready_pp0_iter8_reg <= ap_loop_exit_ready_pp0_iter7_reg;
        ap_loop_exit_ready_pp0_iter9_reg <= ap_loop_exit_ready_pp0_iter8_reg;
        b_V_reg_637 <= b_V_fu_232_p1;
        b_V_reg_637_pp0_iter3_reg <= b_V_reg_637;
        b_V_reg_637_pp0_iter4_reg <= b_V_reg_637_pp0_iter3_reg;
        b_V_reg_637_pp0_iter5_reg <= b_V_reg_637_pp0_iter4_reg;
        diff_V_reg_736 <= diff_V_fu_378_p2;
        g_V_reg_644 <= {{rgb2hsv_in_data23_dout[15:8]}};
        g_V_reg_644_pp0_iter3_reg <= g_V_reg_644;
        g_V_reg_644_pp0_iter4_reg <= g_V_reg_644_pp0_iter3_reg;
        g_V_reg_644_pp0_iter5_reg <= g_V_reg_644_pp0_iter4_reg;
        g_V_reg_644_pp0_iter6_reg <= g_V_reg_644_pp0_iter5_reg;
        r_V_reg_650 <= {{rgb2hsv_in_data23_dout[23:16]}};
        r_V_reg_650_pp0_iter3_reg <= r_V_reg_650;
        r_V_reg_650_pp0_iter4_reg <= r_V_reg_650_pp0_iter3_reg;
        r_V_reg_650_pp0_iter5_reg <= r_V_reg_650_pp0_iter4_reg;
        ret_V_10_reg_766 <= ret_V_10_fu_403_p2;
        ret_V_11_reg_771 <= ret_V_11_fu_407_p2;
        ret_V_16_reg_761 <= ret_V_16_fu_399_p2;
        ret_V_9_reg_786 <= ret_V_9_fu_432_p2;
        trunc_ln2_reg_806 <= {{trunc_ln2_fu_553_p1[19:12]}};
        trunc_ln2_reg_806_pp0_iter12_reg <= trunc_ln2_reg_806;
        v_3_reg_681 <= v_3_fu_283_p2;
        v_reg_712 <= v_fu_335_p2;
        vg_reg_750 <= vg_fu_390_p2;
        vmin_V_reg_706 <= vmin_V_fu_326_p2;
        vmin_V_reg_706_pp0_iter6_reg <= vmin_V_reg_706;
        vr_reg_744 <= vr_fu_383_p2;
        xf_cv_icvSaturate8u_cv_load_reg_676_pp0_iter5_reg <= xf_cv_icvSaturate8u_cv_load_reg_676;
        zext_ln123_1_reg_691[8 : 0] <= zext_ln123_1_fu_303_p1[8 : 0];
        zext_ln123_reg_656[7 : 0] <= zext_ln123_fu_256_p1[7 : 0];
        zext_ln123_reg_656_pp0_iter4_reg[7 : 0] <= zext_ln123_reg_656[7 : 0];
        zext_ln123_reg_656_pp0_iter5_reg[7 : 0] <= zext_ln123_reg_656_pp0_iter4_reg[7 : 0];
        zext_ln123_reg_656_pp0_iter6_reg[7 : 0] <= zext_ln123_reg_656_pp0_iter5_reg[7 : 0];
        zext_ln1496_1_reg_696[7 : 0] <= zext_ln1496_1_fu_306_p1[7 : 0];
        zext_ln1496_1_reg_696_pp0_iter6_reg[7 : 0] <= zext_ln1496_1_reg_696[7 : 0];
        zext_ln1496_reg_664[7 : 0] <= zext_ln1496_fu_259_p1[7 : 0];
        zext_ln1496_reg_664_pp0_iter4_reg[7 : 0] <= zext_ln1496_reg_664[7 : 0];
        zext_ln1496_reg_664_pp0_iter5_reg[7 : 0] <= zext_ln1496_reg_664_pp0_iter4_reg[7 : 0];
        zext_ln1496_reg_664_pp0_iter6_reg[7 : 0] <= zext_ln1496_reg_664_pp0_iter5_reg[7 : 0];
        zext_ln186_1_reg_719[7 : 0] <= zext_ln186_1_fu_343_p1[7 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        xf_cv_icvSaturate8u_cv_load_reg_676 <= xf_cv_icvSaturate8u_cv_q3;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln128_fu_216_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_exit_ready_pp0_iter12_reg == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter13 == 1'b0) & (ap_enable_reg_pp0_iter12 == 1'b0) & (ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        grp_fu_600_ce = 1'b1;
    end else begin
        grp_fu_600_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        grp_fu_609_ce = 1'b1;
    end else begin
        grp_fu_609_ce = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rgb2hsv_in_data23_blk_n = rgb2hsv_in_data23_empty_n;
    end else begin
        rgb2hsv_in_data23_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rgb2hsv_in_data23_read = 1'b1;
    end else begin
        rgb2hsv_in_data23_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter13 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rgb2hsv_out_data24_blk_n = rgb2hsv_out_data24_full_n;
    end else begin
        rgb2hsv_out_data24_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter13 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rgb2hsv_out_data24_write = 1'b1;
    end else begin
        rgb2hsv_out_data24_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter8 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_ce0 = 1'b1;
    end else begin
        void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter7 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_ce0 = 1'b1;
    end else begin
        void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter6 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        xf_cv_icvSaturate8u_cv_ce0 = 1'b1;
    end else begin
        xf_cv_icvSaturate8u_cv_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter5 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        xf_cv_icvSaturate8u_cv_ce1 = 1'b1;
    end else begin
        xf_cv_icvSaturate8u_cv_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        xf_cv_icvSaturate8u_cv_ce2 = 1'b1;
    end else begin
        xf_cv_icvSaturate8u_cv_ce2 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        xf_cv_icvSaturate8u_cv_ce3 = 1'b1;
    end else begin
        xf_cv_icvSaturate8u_cv_ce3 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln128_fu_221_p2 = (indvar_flatten_fu_110 + 64'd1);

assign add_ln1495_fu_268_p2 = (ret_V_12_fu_262_p2 + zext_ln1496_fu_259_p1);

assign add_ln157_1_fu_507_p2 = ($signed(zext_ln157_1_fu_503_p1) + $signed(sext_ln157_2_fu_493_p1));

assign add_ln157_2_fu_523_p2 = ($signed(sext_ln157_3_fu_519_p1) + $signed(sext_ln157_1_fu_476_p1));

assign add_ln157_fu_464_p2 = ($signed(zext_ln157_fu_460_p1) + $signed(sext_ln157_fu_450_p1));

assign add_ln161_fu_586_p2 = (select_ln159_fu_578_p3 + trunc_ln159_1_fu_569_p4);

assign add_ln186_1_fu_363_p2 = (xf_cv_icvSaturate8u_cv_q1 + b_V_reg_637_pp0_iter5_reg);

assign add_ln186_fu_368_p2 = (add_ln186_1_fu_363_p2 + xf_cv_icvSaturate8u_cv_load_reg_676_pp0_iter5_reg);

assign and_ln157_1_fu_513_p2 = (select_ln1496_1_fu_485_p3 & add_ln157_1_fu_507_p2);

assign and_ln157_2_fu_529_p2 = (select_ln1496_fu_442_p3 & add_ln157_2_fu_523_p2);

assign and_ln157_fu_470_p2 = (select_ln126_1_fu_418_p3 & add_ln157_fu_464_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((rgb2hsv_out_data24_full_n == 1'b0) & (ap_enable_reg_pp0_iter13 == 1'b1)) | ((rgb2hsv_in_data23_empty_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((rgb2hsv_out_data24_full_n == 1'b0) & (ap_enable_reg_pp0_iter13 == 1'b1)) | ((rgb2hsv_in_data23_empty_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((rgb2hsv_out_data24_full_n == 1'b0) & (ap_enable_reg_pp0_iter13 == 1'b1)) | ((rgb2hsv_in_data23_empty_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)));
end

assign ap_block_state10_pp0_stage0_iter9 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage0_iter10 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage0_iter11 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage0_iter12 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state14_pp0_stage0_iter13 = (rgb2hsv_out_data24_full_n == 1'b0);
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (rgb2hsv_in_data23_empty_n == 1'b0);
end

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter7 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage0_iter8 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter1_stage0;

assign b_V_fu_232_p1 = rgb2hsv_in_data23_dout[7:0];

assign diff_V_fu_378_p2 = (sub_ln186_fu_373_p2 + add_ln186_reg_730);

assign grp_fu_600_p0 = void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_q0[19:0];

assign grp_fu_600_p1 = grp_fu_600_p10;

assign grp_fu_600_p10 = diff_V_reg_736;

assign grp_fu_600_p2 = 20'd2048;

assign grp_fu_609_p2 = grp_fu_609_p20;

assign grp_fu_609_p20 = trunc_ln158_fu_545_p1;

assign grp_fu_609_p3 = 30'd2048;

assign icmp_ln128_fu_216_p2 = ((indvar_flatten_fu_110 == bound) ? 1'b1 : 1'b0);

assign ret_V_10_fu_403_p2 = (zext_ln123_reg_656_pp0_iter6_reg - zext_ln186_1_reg_719);

assign ret_V_11_fu_407_p2 = (zext_ln186_1_reg_719 - zext_ln1496_reg_664_pp0_iter6_reg);

assign ret_V_12_fu_262_p2 = ($signed(9'd256) - $signed(zext_ln123_fu_256_p1));

assign ret_V_13_fu_309_p2 = (zext_ln1496_1_fu_306_p1 - zext_ln123_1_fu_303_p1);

assign ret_V_14_fu_288_p2 = (zext_ln123_reg_656 - zext_ln1496_reg_664);

assign ret_V_15_fu_346_p2 = (zext_ln186_fu_340_p1 - zext_ln186_1_fu_343_p1);

assign ret_V_16_fu_399_p2 = (zext_ln1496_reg_664_pp0_iter6_reg - zext_ln123_reg_656_pp0_iter6_reg);

assign ret_V_4_fu_292_p2 = (ret_V_14_fu_288_p2 ^ 9'd256);

assign ret_V_6_fu_352_p2 = (ret_V_15_fu_346_p2 ^ 9'd256);

assign ret_V_9_fu_432_p2 = (select_ln126_fu_411_p3 & ret_V_16_reg_761);

assign ret_V_fu_315_p2 = (ret_V_13_fu_309_p2 + 10'd256);

assign rgb2hsv_out_data24_din = {{{add_ln186_reg_730_pp0_iter12_reg}, {trunc_ln2_reg_806_pp0_iter12_reg}}, {add_ln161_reg_811}};

assign select_ln126_1_fu_418_p3 = ((vg_reg_750[0:0] == 1'b1) ? 11'd2047 : 11'd0);

assign select_ln126_fu_411_p3 = ((vr_reg_744[0:0] == 1'b1) ? 9'd511 : 9'd0);

assign select_ln1496_1_fu_485_p3 = ((xor_ln157_1_fu_480_p2[0:0] == 1'b1) ? 12'd4095 : 12'd0);

assign select_ln1496_fu_442_p3 = ((xor_ln157_fu_437_p2[0:0] == 1'b1) ? 13'd8191 : 13'd0);

assign select_ln159_fu_578_p3 = ((tmp_fu_562_p3[0:0] == 1'b1) ? 8'd180 : 8'd0);

assign sext_ln157_1_fu_476_p1 = $signed(and_ln157_fu_470_p2);

assign sext_ln157_2_fu_493_p1 = $signed(ret_V_11_reg_771);

assign sext_ln157_3_fu_519_p1 = $signed(and_ln157_1_fu_513_p2);

assign sext_ln157_fu_450_p1 = $signed(ret_V_10_reg_766);

assign sext_ln541_fu_321_p1 = $signed(ret_V_fu_315_p2);

assign shl_ln157_1_fu_496_p3 = {{diff_V_reg_736}, {2'd0}};

assign shl_ln_fu_453_p3 = {{diff_V_reg_736}, {1'd0}};

assign sub_ln186_fu_373_p2 = (xf_cv_icvSaturate8u_cv_q0 - vmin_V_reg_706_pp0_iter6_reg);

assign tmp_fu_562_p1 = grp_fu_609_p4;

assign tmp_fu_562_p3 = tmp_fu_562_p1[32'd29];

assign trunc_ln158_fu_545_p1 = void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_q0[16:0];

assign trunc_ln159_1_fu_569_p1 = grp_fu_609_p4;

assign trunc_ln159_1_fu_569_p4 = {{trunc_ln159_1_fu_569_p1[19:12]}};

assign trunc_ln2_fu_553_p1 = grp_fu_600_p3;

assign v_3_fu_283_p2 = (zext_ln147_fu_279_p1 + zext_ln123_reg_656);

assign v_fu_335_p2 = (zext_ln123_1_reg_691 + zext_ln148_fu_331_p1);

assign vg_fu_390_p2 = ((v_reg_712 == zext_ln1019_fu_387_p1) ? 1'b1 : 1'b0);

assign vmin_V_fu_326_p2 = (b_V_reg_637_pp0_iter4_reg - xf_cv_icvSaturate8u_cv_q2);

assign void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_hdiv_address0 = zext_ln541_fu_535_p1;

assign void_bgr2hsv_Mat_9_128_128_1_2_Mat_9_128_128_1_2_sdiv_address0 = zext_ln156_fu_395_p1;

assign vr_fu_383_p2 = ((v_reg_712 == zext_ln1496_1_reg_696_pp0_iter6_reg) ? 1'b1 : 1'b0);

assign xf_cv_icvSaturate8u_cv_address0 = zext_ln541_3_fu_358_p1;

assign xf_cv_icvSaturate8u_cv_address1 = sext_ln541_fu_321_p1;

assign xf_cv_icvSaturate8u_cv_address2 = zext_ln541_2_fu_298_p1;

assign xf_cv_icvSaturate8u_cv_address3 = zext_ln541_1_fu_274_p1;

assign xor_ln157_1_fu_480_p2 = (vg_reg_750 ^ 1'd1);

assign xor_ln157_fu_437_p2 = (vr_reg_744 ^ 1'd1);

assign zext_ln1019_fu_387_p1 = g_V_reg_644_pp0_iter6_reg;

assign zext_ln123_1_fu_303_p1 = v_3_reg_681;

assign zext_ln123_fu_256_p1 = b_V_reg_637;

assign zext_ln147_fu_279_p1 = xf_cv_icvSaturate8u_cv_q3;

assign zext_ln148_fu_331_p1 = xf_cv_icvSaturate8u_cv_q1;

assign zext_ln1496_1_fu_306_p1 = r_V_reg_650_pp0_iter4_reg;

assign zext_ln1496_fu_259_p1 = g_V_reg_644;

assign zext_ln156_fu_395_p1 = v_reg_712;

assign zext_ln157_1_fu_503_p1 = shl_ln157_1_fu_496_p3;

assign zext_ln157_fu_460_p1 = shl_ln_fu_453_p3;

assign zext_ln186_1_fu_343_p1 = r_V_reg_650_pp0_iter5_reg;

assign zext_ln186_fu_340_p1 = vmin_V_reg_706;

assign zext_ln541_1_fu_274_p1 = add_ln1495_fu_268_p2;

assign zext_ln541_2_fu_298_p1 = ret_V_4_fu_292_p2;

assign zext_ln541_3_fu_358_p1 = ret_V_6_fu_352_p2;

assign zext_ln541_fu_535_p1 = diff_V_reg_736;

always @ (posedge ap_clk) begin
    zext_ln123_reg_656[8] <= 1'b0;
    zext_ln123_reg_656_pp0_iter4_reg[8] <= 1'b0;
    zext_ln123_reg_656_pp0_iter5_reg[8] <= 1'b0;
    zext_ln123_reg_656_pp0_iter6_reg[8] <= 1'b0;
    zext_ln1496_reg_664[8] <= 1'b0;
    zext_ln1496_reg_664_pp0_iter4_reg[8] <= 1'b0;
    zext_ln1496_reg_664_pp0_iter5_reg[8] <= 1'b0;
    zext_ln1496_reg_664_pp0_iter6_reg[8] <= 1'b0;
    zext_ln123_1_reg_691[9] <= 1'b0;
    zext_ln1496_1_reg_696[9:8] <= 2'b00;
    zext_ln1496_1_reg_696_pp0_iter6_reg[9:8] <= 2'b00;
    zext_ln186_1_reg_719[8] <= 1'b0;
end

endmodule //rgb2hsv_cv_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2
