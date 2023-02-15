// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module color_detect_xferode_128_128_1_0_1_0_129_3_3_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        imgHelper4_data6_dout,
        imgHelper4_data6_num_data_valid,
        imgHelper4_data6_fifo_cap,
        imgHelper4_data6_empty_n,
        imgHelper4_data6_read,
        imgOutput_data7_din,
        imgOutput_data7_num_data_valid,
        imgOutput_data7_fifo_cap,
        imgOutput_data7_full_n,
        imgOutput_data7_write,
        img_height,
        img_width
);

parameter    ap_ST_fsm_state1 = 9'd1;
parameter    ap_ST_fsm_state2 = 9'd2;
parameter    ap_ST_fsm_state3 = 9'd4;
parameter    ap_ST_fsm_state4 = 9'd8;
parameter    ap_ST_fsm_state5 = 9'd16;
parameter    ap_ST_fsm_state6 = 9'd32;
parameter    ap_ST_fsm_state7 = 9'd64;
parameter    ap_ST_fsm_state8 = 9'd128;
parameter    ap_ST_fsm_state9 = 9'd256;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] imgHelper4_data6_dout;
input  [1:0] imgHelper4_data6_num_data_valid;
input  [1:0] imgHelper4_data6_fifo_cap;
input   imgHelper4_data6_empty_n;
output   imgHelper4_data6_read;
output  [7:0] imgOutput_data7_din;
input  [1:0] imgOutput_data7_num_data_valid;
input  [1:0] imgOutput_data7_fifo_cap;
input   imgOutput_data7_full_n;
output   imgOutput_data7_write;
input  [15:0] img_height;
input  [15:0] img_width;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg imgHelper4_data6_read;
reg imgOutput_data7_write;

(* fsm_encoding = "none" *) reg   [8:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln1027_fu_170_p2;
reg   [0:0] icmp_ln1027_reg_324;
wire    ap_CS_fsm_state3;
wire   [0:0] cmp_i_i142_i_fu_256_p2;
reg   [0:0] cmp_i_i142_i_reg_384;
wire    ap_CS_fsm_state7;
wire   [0:0] icmp_ln1027_3_fu_248_p2;
wire   [1:0] empty_38_fu_261_p1;
reg   [1:0] empty_38_reg_389;
wire   [1:0] empty_39_fu_265_p1;
reg   [1:0] empty_39_reg_394;
wire   [1:0] empty_40_fu_269_p1;
reg   [1:0] empty_40_reg_399;
reg    buf_V_ce0;
wire   [7:0] buf_V_q0;
reg   [6:0] buf_V_address1;
reg    buf_V_ce1;
reg    buf_V_we1;
reg   [7:0] buf_V_d1;
reg    buf_V_1_ce0;
wire   [7:0] buf_V_1_q0;
reg   [6:0] buf_V_1_address1;
reg    buf_V_1_ce1;
reg    buf_V_1_we1;
reg   [7:0] buf_V_1_d1;
wire   [7:0] buf_V_2_q0;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_done;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_idle;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_ready;
wire   [12:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_2_out;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_2_out_ap_vld;
wire   [12:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_1_out;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_1_out_ap_vld;
wire   [12:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_out;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_out_ap_vld;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_done;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_idle;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_ready;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_imgHelper4_data6_read;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_address1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_ce1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_we1;
wire   [7:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_d1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_done;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_idle;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_ready;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgHelper4_data6_read;
wire   [7:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgOutput_data7_din;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgOutput_data7_write;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_address0;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_ce0;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_address1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_ce1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_we1;
wire   [7:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_d1;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_address0;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_ce0;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_address1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_ce1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_we1;
wire   [7:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_d1;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_address0;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_ce0;
wire   [6:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_address1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_ce1;
wire    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_we1;
wire   [7:0] grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_d1;
reg    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start_reg;
reg    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start_reg;
wire    ap_CS_fsm_state4;
reg    grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start_reg;
wire    ap_CS_fsm_state8;
wire    ap_CS_fsm_state9;
wire   [63:0] zext_ln541_fu_208_p1;
wire    ap_CS_fsm_state6;
wire   [0:0] icmp_ln1027_2_fu_197_p2;
reg   [12:0] i_col_V_2_fu_90;
wire   [12:0] i_col_V_3_fu_202_p2;
reg   [12:0] row_V_fu_94;
wire   [12:0] row_V_3_fu_273_p2;
reg   [12:0] empty_35_fu_98;
reg   [12:0] empty_36_fu_102;
reg   [12:0] empty_37_fu_106;
wire   [15:0] zext_ln1027_fu_193_p1;
wire   [15:0] zext_ln1027_1_fu_244_p1;
reg   [8:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
wire    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
wire    ap_ST_fsm_state8_blk;
reg    ap_ST_fsm_state9_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 9'd1;
#0 grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start_reg = 1'b0;
#0 grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start_reg = 1'b0;
#0 grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start_reg = 1'b0;
end

color_detect_xferode_128_128_1_0_1_0_129_3_3_s_buf_V_RAM_S2P_BRAM_1R1W #(
    .DataWidth( 8 ),
    .AddressRange( 128 ),
    .AddressWidth( 7 ))
buf_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_address0),
    .ce0(buf_V_ce0),
    .q0(buf_V_q0),
    .address1(buf_V_address1),
    .ce1(buf_V_ce1),
    .we1(buf_V_we1),
    .d1(buf_V_d1)
);

color_detect_xferode_128_128_1_0_1_0_129_3_3_s_buf_V_RAM_S2P_BRAM_1R1W #(
    .DataWidth( 8 ),
    .AddressRange( 128 ),
    .AddressWidth( 7 ))
buf_V_1_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_address0),
    .ce0(buf_V_1_ce0),
    .q0(buf_V_1_q0),
    .address1(buf_V_1_address1),
    .ce1(buf_V_1_ce1),
    .we1(buf_V_1_we1),
    .d1(buf_V_1_d1)
);

color_detect_xferode_128_128_1_0_1_0_129_3_3_s_buf_V_RAM_S2P_BRAM_1R1W #(
    .DataWidth( 8 ),
    .AddressRange( 128 ),
    .AddressWidth( 7 ))
buf_V_2_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_address0),
    .ce0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_ce0),
    .q0(buf_V_2_q0),
    .address1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_address1),
    .ce1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_ce1),
    .we1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_we1),
    .d1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_d1)
);

color_detect_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1 grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start),
    .ap_done(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_done),
    .ap_idle(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_idle),
    .ap_ready(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_ready),
    .row_ind_V_2_out(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_2_out),
    .row_ind_V_2_out_ap_vld(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_2_out_ap_vld),
    .row_ind_V_1_out(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_1_out),
    .row_ind_V_1_out_ap_vld(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_1_out_ap_vld),
    .row_ind_V_out(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_out),
    .row_ind_V_out_ap_vld(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_out_ap_vld)
);

color_detect_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2 grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start),
    .ap_done(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_done),
    .ap_idle(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_idle),
    .ap_ready(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_ready),
    .imgHelper4_data6_dout(imgHelper4_data6_dout),
    .imgHelper4_data6_num_data_valid(2'd0),
    .imgHelper4_data6_fifo_cap(2'd0),
    .imgHelper4_data6_empty_n(imgHelper4_data6_empty_n),
    .imgHelper4_data6_read(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_imgHelper4_data6_read),
    .img_width(img_width),
    .buf_V_1_address1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_address1),
    .buf_V_1_ce1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_ce1),
    .buf_V_1_we1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_we1),
    .buf_V_1_d1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_d1)
);

color_detect_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start),
    .ap_done(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_done),
    .ap_idle(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_idle),
    .ap_ready(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_ready),
    .imgHelper4_data6_dout(imgHelper4_data6_dout),
    .imgHelper4_data6_num_data_valid(2'd0),
    .imgHelper4_data6_fifo_cap(2'd0),
    .imgHelper4_data6_empty_n(imgHelper4_data6_empty_n),
    .imgHelper4_data6_read(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgHelper4_data6_read),
    .imgOutput_data7_din(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgOutput_data7_din),
    .imgOutput_data7_num_data_valid(2'd0),
    .imgOutput_data7_fifo_cap(2'd0),
    .imgOutput_data7_full_n(imgOutput_data7_full_n),
    .imgOutput_data7_write(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgOutput_data7_write),
    .img_width(img_width),
    .buf_V_2_address0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_address0),
    .buf_V_2_ce0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_ce0),
    .buf_V_2_q0(buf_V_2_q0),
    .buf_V_2_address1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_address1),
    .buf_V_2_ce1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_ce1),
    .buf_V_2_we1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_we1),
    .buf_V_2_d1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_2_d1),
    .buf_V_1_address0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_address0),
    .buf_V_1_ce0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_ce0),
    .buf_V_1_q0(buf_V_1_q0),
    .buf_V_1_address1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_address1),
    .buf_V_1_ce1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_ce1),
    .buf_V_1_we1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_we1),
    .buf_V_1_d1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_d1),
    .buf_V_address0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_address0),
    .buf_V_ce0(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_ce0),
    .buf_V_q0(buf_V_q0),
    .buf_V_address1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_address1),
    .buf_V_ce1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_ce1),
    .buf_V_we1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_we1),
    .buf_V_d1(grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_d1),
    .p_cast1(empty_39_reg_394),
    .p_cast2(empty_40_reg_399),
    .p_cast(empty_38_reg_389),
    .cmp_i_i142_i(cmp_i_i142_i_reg_384)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state8)) begin
            grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start_reg <= 1'b1;
        end else if ((grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_ready == 1'b1)) begin
            grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start_reg <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
            grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start_reg <= 1'b1;
        end else if ((grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_ready == 1'b1)) begin
            grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start_reg <= 1'b0;
    end else begin
        if (((icmp_ln1027_reg_324 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
            grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start_reg <= 1'b1;
        end else if ((grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_ready == 1'b1)) begin
            grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state6) & ((icmp_ln1027_reg_324 == 1'd1) | (icmp_ln1027_2_fu_197_p2 == 1'd0)))) begin
        empty_35_fu_98 <= grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_out;
    end else if (((icmp_ln1027_3_fu_248_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        empty_35_fu_98 <= empty_36_fu_102;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state6) & ((icmp_ln1027_reg_324 == 1'd1) | (icmp_ln1027_2_fu_197_p2 == 1'd0)))) begin
        empty_36_fu_102 <= grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_1_out;
    end else if (((icmp_ln1027_3_fu_248_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        empty_36_fu_102 <= empty_37_fu_106;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state6) & ((icmp_ln1027_reg_324 == 1'd1) | (icmp_ln1027_2_fu_197_p2 == 1'd0)))) begin
        empty_37_fu_106 <= grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_row_ind_V_2_out;
    end else if (((icmp_ln1027_3_fu_248_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        empty_37_fu_106 <= empty_35_fu_98;
    end
end

always @ (posedge ap_clk) begin
    if ((icmp_ln1027_reg_324 == 1'd0)) begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            i_col_V_2_fu_90 <= 13'd0;
        end else if (((icmp_ln1027_2_fu_197_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state6))) begin
            i_col_V_2_fu_90 <= i_col_V_3_fu_202_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state6) & ((icmp_ln1027_reg_324 == 1'd1) | (icmp_ln1027_2_fu_197_p2 == 1'd0)))) begin
        row_V_fu_94 <= 13'd1;
    end else if (((icmp_ln1027_3_fu_248_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        row_V_fu_94 <= row_V_3_fu_273_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1027_3_fu_248_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        cmp_i_i142_i_reg_384 <= cmp_i_i142_i_fu_256_p2;
        empty_38_reg_389 <= empty_38_fu_261_p1;
        empty_39_reg_394 <= empty_39_fu_265_p1;
        empty_40_reg_399 <= empty_40_fu_269_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        icmp_ln1027_reg_324 <= icmp_ln1027_fu_170_p2;
    end
end

always @ (*) begin
    if ((ap_start == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_done == 1'b0)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_done == 1'b0)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

assign ap_ST_fsm_state5_blk = 1'b0;

assign ap_ST_fsm_state6_blk = 1'b0;

assign ap_ST_fsm_state7_blk = 1'b0;

assign ap_ST_fsm_state8_blk = 1'b0;

always @ (*) begin
    if ((grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_done == 1'b0)) begin
        ap_ST_fsm_state9_blk = 1'b1;
    end else begin
        ap_ST_fsm_state9_blk = 1'b0;
    end
end

always @ (*) begin
    if ((((icmp_ln1027_3_fu_248_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state7)) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1027_3_fu_248_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state7))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_1_address1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_address1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_V_1_address1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_address1;
    end else begin
        buf_V_1_address1 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_1_ce0 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_ce0;
    end else begin
        buf_V_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_1_ce1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_ce1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_V_1_ce1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_ce1;
    end else begin
        buf_V_1_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_1_d1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_d1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_V_1_d1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_d1;
    end else begin
        buf_V_1_d1 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_1_we1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_1_we1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_V_1_we1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_buf_V_1_we1;
    end else begin
        buf_V_1_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        buf_V_address1 = zext_ln541_fu_208_p1;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_address1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_address1;
    end else begin
        buf_V_address1 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_ce0 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_ce0;
    end else begin
        buf_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        buf_V_ce1 = 1'b1;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_ce1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_ce1;
    end else begin
        buf_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        buf_V_d1 = 8'd255;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_d1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_d1;
    end else begin
        buf_V_d1 = 'bx;
    end
end

always @ (*) begin
    if (((icmp_ln1027_reg_324 == 1'd0) & (icmp_ln1027_2_fu_197_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state6))) begin
        buf_V_we1 = 1'b1;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        buf_V_we1 = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_buf_V_we1;
    end else begin
        buf_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        imgHelper4_data6_read = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgHelper4_data6_read;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        imgHelper4_data6_read = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_imgHelper4_data6_read;
    end else begin
        imgHelper4_data6_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        imgOutput_data7_write = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgOutput_data7_write;
    end else begin
        imgOutput_data7_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b1 == ap_CS_fsm_state2) & (grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((icmp_ln1027_reg_324 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            if (((1'b1 == ap_CS_fsm_state6) & ((icmp_ln1027_reg_324 == 1'd1) | (icmp_ln1027_2_fu_197_p2 == 1'd0)))) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        ap_ST_fsm_state7 : begin
            if (((icmp_ln1027_3_fu_248_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state7))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            if (((1'b1 == ap_CS_fsm_state9) & (grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state9;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];

assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];

assign cmp_i_i142_i_fu_256_p2 = ((zext_ln1027_1_fu_244_p1 < img_height) ? 1'b1 : 1'b0);

assign empty_38_fu_261_p1 = empty_37_fu_106[1:0];

assign empty_39_fu_265_p1 = empty_35_fu_98[1:0];

assign empty_40_fu_269_p1 = empty_36_fu_102[1:0];

assign grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_ap_start_reg;

assign grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_263_1_fu_139_ap_start_reg;

assign grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_VITIS_LOOP_278_2_fu_146_ap_start_reg;

assign i_col_V_3_fu_202_p2 = (i_col_V_2_fu_90 + 13'd1);

assign icmp_ln1027_2_fu_197_p2 = ((zext_ln1027_fu_193_p1 < img_width) ? 1'b1 : 1'b0);

assign icmp_ln1027_3_fu_248_p2 = ((zext_ln1027_1_fu_244_p1 > img_height) ? 1'b1 : 1'b0);

assign icmp_ln1027_fu_170_p2 = ((img_width == 16'd0) ? 1'b1 : 1'b0);

assign imgOutput_data7_din = grp_xferode_128_128_1_0_1_0_129_3_3_Pipeline_Col_Loop_fu_154_imgOutput_data7_din;

assign row_V_3_fu_273_p2 = (row_V_fu_94 + 13'd1);

assign zext_ln1027_1_fu_244_p1 = row_V_fu_94;

assign zext_ln1027_fu_193_p1 = i_col_V_2_fu_90;

assign zext_ln541_fu_208_p1 = i_col_V_2_fu_90;

endmodule //color_detect_xferode_128_128_1_0_1_0_129_3_3_s
