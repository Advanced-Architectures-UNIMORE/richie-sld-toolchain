// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rgb2hsv_cv_AXIvideo2xfMat_patch_32_9_128_128_1_0_s (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        start_out,
        start_write,
        img_in_TDATA,
        img_in_TVALID,
        img_in_TREADY,
        img_in_TKEEP,
        img_in_TSTRB,
        img_in_TUSER,
        img_in_TLAST,
        img_in_TID,
        img_in_TDEST,
        img_1_dout,
        img_1_num_data_valid,
        img_1_fifo_cap,
        img_1_empty_n,
        img_1_read,
        img_2_dout,
        img_2_num_data_valid,
        img_2_fifo_cap,
        img_2_empty_n,
        img_2_read,
        rgb2hsv_in_data18_din,
        rgb2hsv_in_data18_num_data_valid,
        rgb2hsv_in_data18_fifo_cap,
        rgb2hsv_in_data18_full_n,
        rgb2hsv_in_data18_write,
        rgb2hsv_in_rows_c_din,
        rgb2hsv_in_rows_c_num_data_valid,
        rgb2hsv_in_rows_c_fifo_cap,
        rgb2hsv_in_rows_c_full_n,
        rgb2hsv_in_rows_c_write,
        rgb2hsv_in_cols_c_din,
        rgb2hsv_in_cols_c_num_data_valid,
        rgb2hsv_in_cols_c_fifo_cap,
        rgb2hsv_in_cols_c_full_n,
        rgb2hsv_in_cols_c_write
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output   start_out;
output   start_write;
input  [31:0] img_in_TDATA;
input   img_in_TVALID;
output   img_in_TREADY;
input  [3:0] img_in_TKEEP;
input  [3:0] img_in_TSTRB;
input  [0:0] img_in_TUSER;
input  [0:0] img_in_TLAST;
input  [0:0] img_in_TID;
input  [0:0] img_in_TDEST;
input  [31:0] img_1_dout;
input  [1:0] img_1_num_data_valid;
input  [1:0] img_1_fifo_cap;
input   img_1_empty_n;
output   img_1_read;
input  [31:0] img_2_dout;
input  [1:0] img_2_num_data_valid;
input  [1:0] img_2_fifo_cap;
input   img_2_empty_n;
output   img_2_read;
output  [23:0] rgb2hsv_in_data18_din;
input  [1:0] rgb2hsv_in_data18_num_data_valid;
input  [1:0] rgb2hsv_in_data18_fifo_cap;
input   rgb2hsv_in_data18_full_n;
output   rgb2hsv_in_data18_write;
output  [31:0] rgb2hsv_in_rows_c_din;
input  [1:0] rgb2hsv_in_rows_c_num_data_valid;
input  [1:0] rgb2hsv_in_rows_c_fifo_cap;
input   rgb2hsv_in_rows_c_full_n;
output   rgb2hsv_in_rows_c_write;
output  [31:0] rgb2hsv_in_cols_c_din;
input  [1:0] rgb2hsv_in_cols_c_num_data_valid;
input  [1:0] rgb2hsv_in_cols_c_fifo_cap;
input   rgb2hsv_in_cols_c_full_n;
output   rgb2hsv_in_cols_c_write;

reg ap_done;
reg ap_idle;
reg start_write;
reg img_1_read;
reg img_2_read;
reg rgb2hsv_in_data18_write;
reg rgb2hsv_in_rows_c_write;
reg rgb2hsv_in_cols_c_write;

reg    real_start;
reg    start_once_reg;
reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    internal_ap_ready;
reg    img_1_blk_n;
reg    img_2_blk_n;
reg    rgb2hsv_in_rows_c_blk_n;
reg    rgb2hsv_in_cols_c_blk_n;
reg   [31:0] cols_reg_164;
reg   [31:0] rows_reg_169;
wire    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start;
wire    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_done;
wire    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_idle;
wire    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_ready;
wire   [23:0] grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_rgb2hsv_in_data18_din;
wire    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_rgb2hsv_in_data18_write;
wire    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_img_in_TREADY;
reg    grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start_reg;
wire    ap_CS_fsm_state3;
wire    ap_CS_fsm_state4;
reg   [7:0] i_fu_76;
wire   [7:0] i_4_fu_146_p2;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln65_fu_141_p2;
reg    ap_block_state1;
wire   [31:0] zext_ln65_fu_137_p1;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    regslice_both_img_in_V_data_V_U_apdone_blk;
wire   [31:0] img_in_TDATA_int_regslice;
wire    img_in_TVALID_int_regslice;
reg    img_in_TREADY_int_regslice;
wire    regslice_both_img_in_V_data_V_U_ack_in;
wire    regslice_both_img_in_V_keep_V_U_apdone_blk;
wire   [3:0] img_in_TKEEP_int_regslice;
wire    regslice_both_img_in_V_keep_V_U_vld_out;
wire    regslice_both_img_in_V_keep_V_U_ack_in;
wire    regslice_both_img_in_V_strb_V_U_apdone_blk;
wire   [3:0] img_in_TSTRB_int_regslice;
wire    regslice_both_img_in_V_strb_V_U_vld_out;
wire    regslice_both_img_in_V_strb_V_U_ack_in;
wire    regslice_both_img_in_V_user_V_U_apdone_blk;
wire   [0:0] img_in_TUSER_int_regslice;
wire    regslice_both_img_in_V_user_V_U_vld_out;
wire    regslice_both_img_in_V_user_V_U_ack_in;
wire    regslice_both_img_in_V_last_V_U_apdone_blk;
wire   [0:0] img_in_TLAST_int_regslice;
wire    regslice_both_img_in_V_last_V_U_vld_out;
wire    regslice_both_img_in_V_last_V_U_ack_in;
wire    regslice_both_img_in_V_id_V_U_apdone_blk;
wire   [0:0] img_in_TID_int_regslice;
wire    regslice_both_img_in_V_id_V_U_vld_out;
wire    regslice_both_img_in_V_id_V_U_ack_in;
wire    regslice_both_img_in_V_dest_V_U_apdone_blk;
wire   [0:0] img_in_TDEST_int_regslice;
wire    regslice_both_img_in_V_dest_V_U_vld_out;
wire    regslice_both_img_in_V_dest_V_U_ack_in;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
#0 grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start_reg = 1'b0;
end

rgb2hsv_cv_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start),
    .ap_done(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_done),
    .ap_idle(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_idle),
    .ap_ready(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_ready),
    .img_in_TVALID(img_in_TVALID_int_regslice),
    .rgb2hsv_in_data18_din(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_rgb2hsv_in_data18_din),
    .rgb2hsv_in_data18_num_data_valid(2'd0),
    .rgb2hsv_in_data18_fifo_cap(2'd0),
    .rgb2hsv_in_data18_full_n(rgb2hsv_in_data18_full_n),
    .rgb2hsv_in_data18_write(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_rgb2hsv_in_data18_write),
    .cols(cols_reg_164),
    .img_in_TDATA(img_in_TDATA_int_regslice),
    .img_in_TREADY(grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_img_in_TREADY),
    .img_in_TKEEP(img_in_TKEEP_int_regslice),
    .img_in_TSTRB(img_in_TSTRB_int_regslice),
    .img_in_TUSER(img_in_TUSER_int_regslice),
    .img_in_TLAST(img_in_TLAST_int_regslice),
    .img_in_TID(img_in_TID_int_regslice),
    .img_in_TDEST(img_in_TDEST_int_regslice)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 32 ))
regslice_both_img_in_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TDATA),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_data_V_U_ack_in),
    .data_out(img_in_TDATA_int_regslice),
    .vld_out(img_in_TVALID_int_regslice),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_data_V_U_apdone_blk)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 4 ))
regslice_both_img_in_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TKEEP),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_keep_V_U_ack_in),
    .data_out(img_in_TKEEP_int_regslice),
    .vld_out(regslice_both_img_in_V_keep_V_U_vld_out),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_keep_V_U_apdone_blk)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 4 ))
regslice_both_img_in_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TSTRB),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_strb_V_U_ack_in),
    .data_out(img_in_TSTRB_int_regslice),
    .vld_out(regslice_both_img_in_V_strb_V_U_vld_out),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_strb_V_U_apdone_blk)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_in_V_user_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TUSER),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_user_V_U_ack_in),
    .data_out(img_in_TUSER_int_regslice),
    .vld_out(regslice_both_img_in_V_user_V_U_vld_out),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_user_V_U_apdone_blk)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_in_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TLAST),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_last_V_U_ack_in),
    .data_out(img_in_TLAST_int_regslice),
    .vld_out(regslice_both_img_in_V_last_V_U_vld_out),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_last_V_U_apdone_blk)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_in_V_id_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TID),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_id_V_U_ack_in),
    .data_out(img_in_TID_int_regslice),
    .vld_out(regslice_both_img_in_V_id_V_U_vld_out),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_id_V_U_apdone_blk)
);

rgb2hsv_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_in_V_dest_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(img_in_TDEST),
    .vld_in(img_in_TVALID),
    .ack_in(regslice_both_img_in_V_dest_V_U_ack_in),
    .data_out(img_in_TDEST_int_regslice),
    .vld_out(regslice_both_img_in_V_dest_V_U_vld_out),
    .ack_out(img_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_img_in_V_dest_V_U_apdone_blk)
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
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln65_fu_141_p2 == 1'd0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start_reg <= 1'b1;
        end else if ((grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_ready == 1'b1)) begin
            grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((internal_ap_ready == 1'b0) & (real_start == 1'b1))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        i_fu_76 <= 8'd0;
    end else if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln65_fu_141_p2 == 1'd1))) begin
        i_fu_76 <= i_4_fu_146_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        cols_reg_164 <= img_2_dout;
        rows_reg_169 <= img_1_dout;
    end
end

always @ (*) begin
    if (((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_done == 1'b0)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln65_fu_141_p2 == 1'd0))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (real_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_1_blk_n = img_1_empty_n;
    end else begin
        img_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_1_read = 1'b1;
    end else begin
        img_1_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_2_blk_n = img_2_empty_n;
    end else begin
        img_2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_2_read = 1'b1;
    end else begin
        img_2_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        img_in_TREADY_int_regslice = grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_img_in_TREADY;
    end else begin
        img_in_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln65_fu_141_p2 == 1'd0))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((start_once_reg == 1'b0) & (start_full_n == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        rgb2hsv_in_cols_c_blk_n = rgb2hsv_in_cols_c_full_n;
    end else begin
        rgb2hsv_in_cols_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        rgb2hsv_in_cols_c_write = 1'b1;
    end else begin
        rgb2hsv_in_cols_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        rgb2hsv_in_data18_write = grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_rgb2hsv_in_data18_write;
    end else begin
        rgb2hsv_in_data18_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        rgb2hsv_in_rows_c_blk_n = rgb2hsv_in_rows_c_full_n;
    end else begin
        rgb2hsv_in_rows_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        rgb2hsv_in_rows_c_write = 1'b1;
    end else begin
        rgb2hsv_in_rows_c_write = 1'b0;
    end
end

always @ (*) begin
    if (((start_once_reg == 1'b0) & (real_start == 1'b1))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b1 == ap_CS_fsm_state2) & (icmp_ln65_fu_141_p2 == 1'd0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            if (((grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
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

always @ (*) begin
    ap_block_state1 = ((rgb2hsv_in_cols_c_full_n == 1'b0) | (rgb2hsv_in_rows_c_full_n == 1'b0) | (img_2_empty_n == 1'b0) | (img_1_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0));
end

assign ap_ready = internal_ap_ready;

assign grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start = grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_ap_start_reg;

assign i_4_fu_146_p2 = (i_fu_76 + 8'd1);

assign icmp_ln65_fu_141_p2 = (($signed(zext_ln65_fu_137_p1) < $signed(rows_reg_169)) ? 1'b1 : 1'b0);

assign img_in_TREADY = regslice_both_img_in_V_data_V_U_ack_in;

assign rgb2hsv_in_cols_c_din = img_2_dout;

assign rgb2hsv_in_data18_din = grp_AXIvideo2xfMat_patch_32_9_128_128_1_0_Pipeline_loop_col_zxi2mat_fu_108_rgb2hsv_in_data18_din;

assign rgb2hsv_in_rows_c_din = img_1_dout;

assign start_out = real_start;

assign zext_ln65_fu_137_p1 = i_fu_76;

endmodule //rgb2hsv_cv_AXIvideo2xfMat_patch_32_9_128_128_1_0_s
