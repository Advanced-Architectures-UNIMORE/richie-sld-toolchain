// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="dilate_cv_dilate_cv,hls_ip_2022_2_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu9eg-ffvb1156-2-e,HLS_INPUT_CLOCK=3.300000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=2.409000,HLS_SYN_LAT=-1,HLS_SYN_TPT=-1,HLS_SYN_MEM=3,HLS_SYN_DSP=0,HLS_SYN_FF=1860,HLS_SYN_LUT=2527,HLS_VERSION=2022_2_1}" *)

module dilate_cv (
        img_in_TDATA,
        img_in_TKEEP,
        img_in_TSTRB,
        img_in_TUSER,
        img_in_TLAST,
        img_in_TID,
        img_in_TDEST,
        img_out_TDATA,
        img_out_TKEEP,
        img_out_TSTRB,
        img_out_TUSER,
        img_out_TLAST,
        img_out_TID,
        img_out_TDEST,
        rows,
        cols,
        ap_clk,
        ap_rst_n,
        ap_start,
        img_in_TVALID,
        img_in_TREADY,
        img_out_TVALID,
        img_out_TREADY,
        ap_done,
        ap_ready,
        ap_idle
);


input  [7:0] img_in_TDATA;
input  [0:0] img_in_TKEEP;
input  [0:0] img_in_TSTRB;
input  [0:0] img_in_TUSER;
input  [0:0] img_in_TLAST;
input  [0:0] img_in_TID;
input  [0:0] img_in_TDEST;
output  [7:0] img_out_TDATA;
output  [0:0] img_out_TKEEP;
output  [0:0] img_out_TSTRB;
output  [0:0] img_out_TUSER;
output  [0:0] img_out_TLAST;
output  [0:0] img_out_TID;
output  [0:0] img_out_TDEST;
input  [31:0] rows;
input  [31:0] cols;
input   ap_clk;
input   ap_rst_n;
input   ap_start;
input   img_in_TVALID;
output   img_in_TREADY;
output   img_out_TVALID;
input   img_out_TREADY;
output   ap_done;
output   ap_ready;
output   ap_idle;

 reg    ap_rst_n_inv;
wire    Block_entry1_proc_U0_ap_start;
wire    Block_entry1_proc_U0_ap_done;
wire    Block_entry1_proc_U0_ap_continue;
wire    Block_entry1_proc_U0_ap_idle;
wire    Block_entry1_proc_U0_ap_ready;
wire   [31:0] Block_entry1_proc_U0_ap_return_0;
wire   [31:0] Block_entry1_proc_U0_ap_return_1;
wire   [31:0] Block_entry1_proc_U0_ap_return_2;
wire   [31:0] Block_entry1_proc_U0_ap_return_3;
wire    ap_channel_done_dilate_in_cols_c10_channel;
wire    dilate_in_cols_c10_channel_full_n;
reg    ap_sync_reg_channel_write_dilate_in_cols_c10_channel;
wire    ap_sync_channel_write_dilate_in_cols_c10_channel;
wire    ap_channel_done_dilate_in_rows_c9_channel;
wire    dilate_in_rows_c9_channel_full_n;
reg    ap_sync_reg_channel_write_dilate_in_rows_c9_channel;
wire    ap_sync_channel_write_dilate_in_rows_c9_channel;
wire    ap_channel_done_dilate_out_cols_channel;
wire    dilate_out_cols_channel_full_n;
reg    ap_sync_reg_channel_write_dilate_out_cols_channel;
wire    ap_sync_channel_write_dilate_out_cols_channel;
wire    ap_channel_done_dilate_out_rows_channel;
wire    dilate_out_rows_channel_full_n;
reg    ap_sync_reg_channel_write_dilate_out_rows_channel;
wire    ap_sync_channel_write_dilate_out_rows_channel;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_ap_start;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_ap_done;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_ap_continue;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_ap_idle;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_ap_ready;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_start_out;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_start_write;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_img_in_TREADY;
wire   [7:0] AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_data24_din;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_data24_write;
wire   [31:0] AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_rows_c_din;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_rows_c_write;
wire   [31:0] AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_cols_c_din;
wire    AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_cols_c_write;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_ap_start;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_ap_done;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_ap_continue;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_ap_idle;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_ap_ready;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_p_src_rows_read;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_p_src_cols_read;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_dilate_in_data24_read;
wire   [7:0] dilate_0_0_128_128_0_3_3_1_1_U0_dilate_out_data25_din;
wire    dilate_0_0_128_128_0_3_3_1_1_U0_dilate_out_data25_write;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_ap_start;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_ap_done;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_ap_continue;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_ap_idle;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_ap_ready;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_dilate_out_data25_read;
wire   [7:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TDATA;
wire    xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TVALID;
wire   [0:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TKEEP;
wire   [0:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TSTRB;
wire   [0:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TUSER;
wire   [0:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TLAST;
wire   [0:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TID;
wire   [0:0] xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TDEST;
wire   [31:0] dilate_out_rows_channel_dout;
wire   [2:0] dilate_out_rows_channel_num_data_valid;
wire   [2:0] dilate_out_rows_channel_fifo_cap;
wire    dilate_out_rows_channel_empty_n;
wire   [31:0] dilate_out_cols_channel_dout;
wire   [2:0] dilate_out_cols_channel_num_data_valid;
wire   [2:0] dilate_out_cols_channel_fifo_cap;
wire    dilate_out_cols_channel_empty_n;
wire   [31:0] dilate_in_rows_c9_channel_dout;
wire   [1:0] dilate_in_rows_c9_channel_num_data_valid;
wire   [1:0] dilate_in_rows_c9_channel_fifo_cap;
wire    dilate_in_rows_c9_channel_empty_n;
wire   [31:0] dilate_in_cols_c10_channel_dout;
wire   [1:0] dilate_in_cols_c10_channel_num_data_valid;
wire   [1:0] dilate_in_cols_c10_channel_fifo_cap;
wire    dilate_in_cols_c10_channel_empty_n;
wire    dilate_in_data_full_n;
wire   [7:0] dilate_in_data_dout;
wire   [1:0] dilate_in_data_num_data_valid;
wire   [1:0] dilate_in_data_fifo_cap;
wire    dilate_in_data_empty_n;
wire    dilate_in_rows_c_full_n;
wire   [31:0] dilate_in_rows_c_dout;
wire   [1:0] dilate_in_rows_c_num_data_valid;
wire   [1:0] dilate_in_rows_c_fifo_cap;
wire    dilate_in_rows_c_empty_n;
wire    dilate_in_cols_c_full_n;
wire   [31:0] dilate_in_cols_c_dout;
wire   [1:0] dilate_in_cols_c_num_data_valid;
wire   [1:0] dilate_in_cols_c_fifo_cap;
wire    dilate_in_cols_c_empty_n;
wire    dilate_out_data_full_n;
wire   [7:0] dilate_out_data_dout;
wire   [1:0] dilate_out_data_num_data_valid;
wire   [1:0] dilate_out_data_fifo_cap;
wire    dilate_out_data_empty_n;
wire   [0:0] start_for_dilate_0_0_128_128_0_3_3_1_1_U0_din;
wire    start_for_dilate_0_0_128_128_0_3_3_1_1_U0_full_n;
wire   [0:0] start_for_dilate_0_0_128_128_0_3_3_1_1_U0_dout;
wire    start_for_dilate_0_0_128_128_0_3_3_1_1_U0_empty_n;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_sync_reg_channel_write_dilate_in_cols_c10_channel = 1'b0;
#0 ap_sync_reg_channel_write_dilate_in_rows_c9_channel = 1'b0;
#0 ap_sync_reg_channel_write_dilate_out_cols_channel = 1'b0;
#0 ap_sync_reg_channel_write_dilate_out_rows_channel = 1'b0;
end

dilate_cv_Block_entry1_proc Block_entry1_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(Block_entry1_proc_U0_ap_start),
    .ap_done(Block_entry1_proc_U0_ap_done),
    .ap_continue(Block_entry1_proc_U0_ap_continue),
    .ap_idle(Block_entry1_proc_U0_ap_idle),
    .ap_ready(Block_entry1_proc_U0_ap_ready),
    .rows(rows),
    .cols(cols),
    .ap_return_0(Block_entry1_proc_U0_ap_return_0),
    .ap_return_1(Block_entry1_proc_U0_ap_return_1),
    .ap_return_2(Block_entry1_proc_U0_ap_return_2),
    .ap_return_3(Block_entry1_proc_U0_ap_return_3)
);

dilate_cv_AXIvideo2xfMat_8_0_128_128_1_s AXIvideo2xfMat_8_0_128_128_1_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(AXIvideo2xfMat_8_0_128_128_1_U0_ap_start),
    .start_full_n(start_for_dilate_0_0_128_128_0_3_3_1_1_U0_full_n),
    .ap_done(AXIvideo2xfMat_8_0_128_128_1_U0_ap_done),
    .ap_continue(AXIvideo2xfMat_8_0_128_128_1_U0_ap_continue),
    .ap_idle(AXIvideo2xfMat_8_0_128_128_1_U0_ap_idle),
    .ap_ready(AXIvideo2xfMat_8_0_128_128_1_U0_ap_ready),
    .start_out(AXIvideo2xfMat_8_0_128_128_1_U0_start_out),
    .start_write(AXIvideo2xfMat_8_0_128_128_1_U0_start_write),
    .img_in_TDATA(img_in_TDATA),
    .img_in_TVALID(img_in_TVALID),
    .img_in_TREADY(AXIvideo2xfMat_8_0_128_128_1_U0_img_in_TREADY),
    .img_in_TKEEP(img_in_TKEEP),
    .img_in_TSTRB(img_in_TSTRB),
    .img_in_TUSER(img_in_TUSER),
    .img_in_TLAST(img_in_TLAST),
    .img_in_TID(img_in_TID),
    .img_in_TDEST(img_in_TDEST),
    .p_read(dilate_in_rows_c9_channel_dout),
    .p_read1(dilate_in_cols_c10_channel_dout),
    .dilate_in_data24_din(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_data24_din),
    .dilate_in_data24_num_data_valid(dilate_in_data_num_data_valid),
    .dilate_in_data24_fifo_cap(dilate_in_data_fifo_cap),
    .dilate_in_data24_full_n(dilate_in_data_full_n),
    .dilate_in_data24_write(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_data24_write),
    .dilate_in_rows_c_din(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_rows_c_din),
    .dilate_in_rows_c_num_data_valid(dilate_in_rows_c_num_data_valid),
    .dilate_in_rows_c_fifo_cap(dilate_in_rows_c_fifo_cap),
    .dilate_in_rows_c_full_n(dilate_in_rows_c_full_n),
    .dilate_in_rows_c_write(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_rows_c_write),
    .dilate_in_cols_c_din(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_cols_c_din),
    .dilate_in_cols_c_num_data_valid(dilate_in_cols_c_num_data_valid),
    .dilate_in_cols_c_fifo_cap(dilate_in_cols_c_fifo_cap),
    .dilate_in_cols_c_full_n(dilate_in_cols_c_full_n),
    .dilate_in_cols_c_write(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_cols_c_write)
);

dilate_cv_dilate_0_0_128_128_0_3_3_1_1_s dilate_0_0_128_128_0_3_3_1_1_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(dilate_0_0_128_128_0_3_3_1_1_U0_ap_start),
    .ap_done(dilate_0_0_128_128_0_3_3_1_1_U0_ap_done),
    .ap_continue(dilate_0_0_128_128_0_3_3_1_1_U0_ap_continue),
    .ap_idle(dilate_0_0_128_128_0_3_3_1_1_U0_ap_idle),
    .ap_ready(dilate_0_0_128_128_0_3_3_1_1_U0_ap_ready),
    .p_src_rows_dout(dilate_in_rows_c_dout),
    .p_src_rows_num_data_valid(dilate_in_rows_c_num_data_valid),
    .p_src_rows_fifo_cap(dilate_in_rows_c_fifo_cap),
    .p_src_rows_empty_n(dilate_in_rows_c_empty_n),
    .p_src_rows_read(dilate_0_0_128_128_0_3_3_1_1_U0_p_src_rows_read),
    .p_src_cols_dout(dilate_in_cols_c_dout),
    .p_src_cols_num_data_valid(dilate_in_cols_c_num_data_valid),
    .p_src_cols_fifo_cap(dilate_in_cols_c_fifo_cap),
    .p_src_cols_empty_n(dilate_in_cols_c_empty_n),
    .p_src_cols_read(dilate_0_0_128_128_0_3_3_1_1_U0_p_src_cols_read),
    .dilate_in_data24_dout(dilate_in_data_dout),
    .dilate_in_data24_num_data_valid(dilate_in_data_num_data_valid),
    .dilate_in_data24_fifo_cap(dilate_in_data_fifo_cap),
    .dilate_in_data24_empty_n(dilate_in_data_empty_n),
    .dilate_in_data24_read(dilate_0_0_128_128_0_3_3_1_1_U0_dilate_in_data24_read),
    .dilate_out_data25_din(dilate_0_0_128_128_0_3_3_1_1_U0_dilate_out_data25_din),
    .dilate_out_data25_num_data_valid(dilate_out_data_num_data_valid),
    .dilate_out_data25_fifo_cap(dilate_out_data_fifo_cap),
    .dilate_out_data25_full_n(dilate_out_data_full_n),
    .dilate_out_data25_write(dilate_0_0_128_128_0_3_3_1_1_U0_dilate_out_data25_write)
);

dilate_cv_xfMat2AXIvideo_8_0_128_128_1_s xfMat2AXIvideo_8_0_128_128_1_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(xfMat2AXIvideo_8_0_128_128_1_U0_ap_start),
    .ap_done(xfMat2AXIvideo_8_0_128_128_1_U0_ap_done),
    .ap_continue(xfMat2AXIvideo_8_0_128_128_1_U0_ap_continue),
    .ap_idle(xfMat2AXIvideo_8_0_128_128_1_U0_ap_idle),
    .ap_ready(xfMat2AXIvideo_8_0_128_128_1_U0_ap_ready),
    .p_read(dilate_out_rows_channel_dout),
    .p_read1(dilate_out_cols_channel_dout),
    .dilate_out_data25_dout(dilate_out_data_dout),
    .dilate_out_data25_num_data_valid(dilate_out_data_num_data_valid),
    .dilate_out_data25_fifo_cap(dilate_out_data_fifo_cap),
    .dilate_out_data25_empty_n(dilate_out_data_empty_n),
    .dilate_out_data25_read(xfMat2AXIvideo_8_0_128_128_1_U0_dilate_out_data25_read),
    .img_out_TDATA(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TDATA),
    .img_out_TVALID(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TVALID),
    .img_out_TREADY(img_out_TREADY),
    .img_out_TKEEP(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TKEEP),
    .img_out_TSTRB(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TSTRB),
    .img_out_TUSER(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TUSER),
    .img_out_TLAST(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TLAST),
    .img_out_TID(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TID),
    .img_out_TDEST(xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TDEST)
);

dilate_cv_fifo_w32_d4_S dilate_out_rows_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Block_entry1_proc_U0_ap_return_0),
    .if_full_n(dilate_out_rows_channel_full_n),
    .if_write(ap_channel_done_dilate_out_rows_channel),
    .if_dout(dilate_out_rows_channel_dout),
    .if_num_data_valid(dilate_out_rows_channel_num_data_valid),
    .if_fifo_cap(dilate_out_rows_channel_fifo_cap),
    .if_empty_n(dilate_out_rows_channel_empty_n),
    .if_read(xfMat2AXIvideo_8_0_128_128_1_U0_ap_ready)
);

dilate_cv_fifo_w32_d4_S dilate_out_cols_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Block_entry1_proc_U0_ap_return_1),
    .if_full_n(dilate_out_cols_channel_full_n),
    .if_write(ap_channel_done_dilate_out_cols_channel),
    .if_dout(dilate_out_cols_channel_dout),
    .if_num_data_valid(dilate_out_cols_channel_num_data_valid),
    .if_fifo_cap(dilate_out_cols_channel_fifo_cap),
    .if_empty_n(dilate_out_cols_channel_empty_n),
    .if_read(xfMat2AXIvideo_8_0_128_128_1_U0_ap_ready)
);

dilate_cv_fifo_w32_d2_S dilate_in_rows_c9_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Block_entry1_proc_U0_ap_return_2),
    .if_full_n(dilate_in_rows_c9_channel_full_n),
    .if_write(ap_channel_done_dilate_in_rows_c9_channel),
    .if_dout(dilate_in_rows_c9_channel_dout),
    .if_num_data_valid(dilate_in_rows_c9_channel_num_data_valid),
    .if_fifo_cap(dilate_in_rows_c9_channel_fifo_cap),
    .if_empty_n(dilate_in_rows_c9_channel_empty_n),
    .if_read(AXIvideo2xfMat_8_0_128_128_1_U0_ap_ready)
);

dilate_cv_fifo_w32_d2_S dilate_in_cols_c10_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Block_entry1_proc_U0_ap_return_3),
    .if_full_n(dilate_in_cols_c10_channel_full_n),
    .if_write(ap_channel_done_dilate_in_cols_c10_channel),
    .if_dout(dilate_in_cols_c10_channel_dout),
    .if_num_data_valid(dilate_in_cols_c10_channel_num_data_valid),
    .if_fifo_cap(dilate_in_cols_c10_channel_fifo_cap),
    .if_empty_n(dilate_in_cols_c10_channel_empty_n),
    .if_read(AXIvideo2xfMat_8_0_128_128_1_U0_ap_ready)
);

dilate_cv_fifo_w8_d2_S dilate_in_data_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_data24_din),
    .if_full_n(dilate_in_data_full_n),
    .if_write(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_data24_write),
    .if_dout(dilate_in_data_dout),
    .if_num_data_valid(dilate_in_data_num_data_valid),
    .if_fifo_cap(dilate_in_data_fifo_cap),
    .if_empty_n(dilate_in_data_empty_n),
    .if_read(dilate_0_0_128_128_0_3_3_1_1_U0_dilate_in_data24_read)
);

dilate_cv_fifo_w32_d2_S dilate_in_rows_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_rows_c_din),
    .if_full_n(dilate_in_rows_c_full_n),
    .if_write(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_rows_c_write),
    .if_dout(dilate_in_rows_c_dout),
    .if_num_data_valid(dilate_in_rows_c_num_data_valid),
    .if_fifo_cap(dilate_in_rows_c_fifo_cap),
    .if_empty_n(dilate_in_rows_c_empty_n),
    .if_read(dilate_0_0_128_128_0_3_3_1_1_U0_p_src_rows_read)
);

dilate_cv_fifo_w32_d2_S dilate_in_cols_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_cols_c_din),
    .if_full_n(dilate_in_cols_c_full_n),
    .if_write(AXIvideo2xfMat_8_0_128_128_1_U0_dilate_in_cols_c_write),
    .if_dout(dilate_in_cols_c_dout),
    .if_num_data_valid(dilate_in_cols_c_num_data_valid),
    .if_fifo_cap(dilate_in_cols_c_fifo_cap),
    .if_empty_n(dilate_in_cols_c_empty_n),
    .if_read(dilate_0_0_128_128_0_3_3_1_1_U0_p_src_cols_read)
);

dilate_cv_fifo_w8_d2_S dilate_out_data_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(dilate_0_0_128_128_0_3_3_1_1_U0_dilate_out_data25_din),
    .if_full_n(dilate_out_data_full_n),
    .if_write(dilate_0_0_128_128_0_3_3_1_1_U0_dilate_out_data25_write),
    .if_dout(dilate_out_data_dout),
    .if_num_data_valid(dilate_out_data_num_data_valid),
    .if_fifo_cap(dilate_out_data_fifo_cap),
    .if_empty_n(dilate_out_data_empty_n),
    .if_read(xfMat2AXIvideo_8_0_128_128_1_U0_dilate_out_data25_read)
);

dilate_cv_start_for_dilate_0_0_128_128_0_3_3_1_1_U0 start_for_dilate_0_0_128_128_0_3_3_1_1_U0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_dilate_0_0_128_128_0_3_3_1_1_U0_din),
    .if_full_n(start_for_dilate_0_0_128_128_0_3_3_1_1_U0_full_n),
    .if_write(AXIvideo2xfMat_8_0_128_128_1_U0_start_write),
    .if_dout(start_for_dilate_0_0_128_128_0_3_3_1_1_U0_dout),
    .if_empty_n(start_for_dilate_0_0_128_128_0_3_3_1_1_U0_empty_n),
    .if_read(dilate_0_0_128_128_0_3_3_1_1_U0_ap_ready)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_channel_write_dilate_in_cols_c10_channel <= 1'b0;
    end else begin
        if (((Block_entry1_proc_U0_ap_done & Block_entry1_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_dilate_in_cols_c10_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_dilate_in_cols_c10_channel <= ap_sync_channel_write_dilate_in_cols_c10_channel;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_channel_write_dilate_in_rows_c9_channel <= 1'b0;
    end else begin
        if (((Block_entry1_proc_U0_ap_done & Block_entry1_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_dilate_in_rows_c9_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_dilate_in_rows_c9_channel <= ap_sync_channel_write_dilate_in_rows_c9_channel;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_channel_write_dilate_out_cols_channel <= 1'b0;
    end else begin
        if (((Block_entry1_proc_U0_ap_done & Block_entry1_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_dilate_out_cols_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_dilate_out_cols_channel <= ap_sync_channel_write_dilate_out_cols_channel;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_channel_write_dilate_out_rows_channel <= 1'b0;
    end else begin
        if (((Block_entry1_proc_U0_ap_done & Block_entry1_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_dilate_out_rows_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_dilate_out_rows_channel <= ap_sync_channel_write_dilate_out_rows_channel;
        end
    end
end

assign AXIvideo2xfMat_8_0_128_128_1_U0_ap_continue = 1'b1;

assign AXIvideo2xfMat_8_0_128_128_1_U0_ap_start = (dilate_in_rows_c9_channel_empty_n & dilate_in_cols_c10_channel_empty_n);

assign Block_entry1_proc_U0_ap_continue = (ap_sync_channel_write_dilate_out_rows_channel & ap_sync_channel_write_dilate_out_cols_channel & ap_sync_channel_write_dilate_in_rows_c9_channel & ap_sync_channel_write_dilate_in_cols_c10_channel);

assign Block_entry1_proc_U0_ap_start = ap_start;

assign ap_channel_done_dilate_in_cols_c10_channel = ((ap_sync_reg_channel_write_dilate_in_cols_c10_channel ^ 1'b1) & Block_entry1_proc_U0_ap_done);

assign ap_channel_done_dilate_in_rows_c9_channel = ((ap_sync_reg_channel_write_dilate_in_rows_c9_channel ^ 1'b1) & Block_entry1_proc_U0_ap_done);

assign ap_channel_done_dilate_out_cols_channel = ((ap_sync_reg_channel_write_dilate_out_cols_channel ^ 1'b1) & Block_entry1_proc_U0_ap_done);

assign ap_channel_done_dilate_out_rows_channel = ((ap_sync_reg_channel_write_dilate_out_rows_channel ^ 1'b1) & Block_entry1_proc_U0_ap_done);

assign ap_done = xfMat2AXIvideo_8_0_128_128_1_U0_ap_done;

assign ap_idle = (xfMat2AXIvideo_8_0_128_128_1_U0_ap_idle & (dilate_in_cols_c10_channel_empty_n ^ 1'b1) & (dilate_in_rows_c9_channel_empty_n ^ 1'b1) & (dilate_out_cols_channel_empty_n ^ 1'b1) & (dilate_out_rows_channel_empty_n ^ 1'b1) & dilate_0_0_128_128_0_3_3_1_1_U0_ap_idle & Block_entry1_proc_U0_ap_idle & AXIvideo2xfMat_8_0_128_128_1_U0_ap_idle);

assign ap_ready = Block_entry1_proc_U0_ap_ready;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_channel_write_dilate_in_cols_c10_channel = ((dilate_in_cols_c10_channel_full_n & ap_channel_done_dilate_in_cols_c10_channel) | ap_sync_reg_channel_write_dilate_in_cols_c10_channel);

assign ap_sync_channel_write_dilate_in_rows_c9_channel = ((dilate_in_rows_c9_channel_full_n & ap_channel_done_dilate_in_rows_c9_channel) | ap_sync_reg_channel_write_dilate_in_rows_c9_channel);

assign ap_sync_channel_write_dilate_out_cols_channel = ((dilate_out_cols_channel_full_n & ap_channel_done_dilate_out_cols_channel) | ap_sync_reg_channel_write_dilate_out_cols_channel);

assign ap_sync_channel_write_dilate_out_rows_channel = ((dilate_out_rows_channel_full_n & ap_channel_done_dilate_out_rows_channel) | ap_sync_reg_channel_write_dilate_out_rows_channel);

assign dilate_0_0_128_128_0_3_3_1_1_U0_ap_continue = 1'b1;

assign dilate_0_0_128_128_0_3_3_1_1_U0_ap_start = start_for_dilate_0_0_128_128_0_3_3_1_1_U0_empty_n;

assign img_in_TREADY = AXIvideo2xfMat_8_0_128_128_1_U0_img_in_TREADY;

assign img_out_TDATA = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TDATA;

assign img_out_TDEST = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TDEST;

assign img_out_TID = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TID;

assign img_out_TKEEP = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TKEEP;

assign img_out_TLAST = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TLAST;

assign img_out_TSTRB = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TSTRB;

assign img_out_TUSER = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TUSER;

assign img_out_TVALID = xfMat2AXIvideo_8_0_128_128_1_U0_img_out_TVALID;

assign start_for_dilate_0_0_128_128_0_3_3_1_1_U0_din = 1'b1;

assign xfMat2AXIvideo_8_0_128_128_1_U0_ap_continue = 1'b1;

assign xfMat2AXIvideo_8_0_128_128_1_U0_ap_start = (dilate_out_rows_channel_empty_n & dilate_out_cols_channel_empty_n);

endmodule //dilate_cv
