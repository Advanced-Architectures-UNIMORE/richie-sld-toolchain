// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module threshold_cv_xfMat2AXIvideo_8_0_128_128_1_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        p_read,
        p_read1,
        threshold_out_data23_dout,
        threshold_out_data23_num_data_valid,
        threshold_out_data23_fifo_cap,
        threshold_out_data23_empty_n,
        threshold_out_data23_read,
        img_out_TDATA,
        img_out_TVALID,
        img_out_TREADY,
        img_out_TKEEP,
        img_out_TSTRB,
        img_out_TUSER,
        img_out_TLAST,
        img_out_TID,
        img_out_TDEST
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] p_read;
input  [31:0] p_read1;
input  [7:0] threshold_out_data23_dout;
input  [1:0] threshold_out_data23_num_data_valid;
input  [1:0] threshold_out_data23_fifo_cap;
input   threshold_out_data23_empty_n;
output   threshold_out_data23_read;
output  [7:0] img_out_TDATA;
output   img_out_TVALID;
input   img_out_TREADY;
output  [0:0] img_out_TKEEP;
output  [0:0] img_out_TSTRB;
output  [0:0] img_out_TUSER;
output  [0:0] img_out_TLAST;
output  [0:0] img_out_TID;
output  [0:0] img_out_TDEST;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg threshold_out_data23_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [7:0] empty_fu_109_p1;
reg   [7:0] empty_reg_189;
wire   [6:0] sub_fu_117_p2;
reg   [6:0] sub_reg_194;
wire   [0:0] cmp81_fu_123_p2;
reg   [0:0] cmp81_reg_199;
wire   [7:0] i_2_fu_151_p2;
reg   [7:0] i_2_reg_206;
wire    ap_CS_fsm_state2;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_done;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_idle;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_ready;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_threshold_out_data23_read;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TREADY;
wire   [7:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TDATA;
wire    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID;
wire   [0:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TKEEP;
wire   [0:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TSTRB;
wire   [0:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TUSER;
wire   [0:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TLAST;
wire   [0:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TID;
wire   [0:0] grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TDEST;
reg    grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg;
wire   [0:0] icmp_ln195_fu_146_p2;
wire    ap_CS_fsm_state3;
reg   [7:0] i_fu_66;
reg    ap_block_state3_on_subcall_done;
reg    ap_block_state1;
reg   [0:0] sof_fu_70;
wire   [6:0] empty_22_fu_113_p1;
wire   [31:0] zext_ln195_fu_142_p1;
wire    ap_CS_fsm_state4;
wire    regslice_both_img_out_V_data_V_U_apdone_blk;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
reg    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    img_out_TVALID_int_regslice;
wire    img_out_TREADY_int_regslice;
wire    regslice_both_img_out_V_data_V_U_vld_out;
wire    regslice_both_img_out_V_keep_V_U_apdone_blk;
wire    regslice_both_img_out_V_keep_V_U_ack_in_dummy;
wire    regslice_both_img_out_V_keep_V_U_vld_out;
wire    regslice_both_img_out_V_strb_V_U_apdone_blk;
wire    regslice_both_img_out_V_strb_V_U_ack_in_dummy;
wire    regslice_both_img_out_V_strb_V_U_vld_out;
wire    regslice_both_img_out_V_user_V_U_apdone_blk;
wire    regslice_both_img_out_V_user_V_U_ack_in_dummy;
wire    regslice_both_img_out_V_user_V_U_vld_out;
wire    regslice_both_img_out_V_last_V_U_apdone_blk;
wire    regslice_both_img_out_V_last_V_U_ack_in_dummy;
wire    regslice_both_img_out_V_last_V_U_vld_out;
wire    regslice_both_img_out_V_id_V_U_apdone_blk;
wire    regslice_both_img_out_V_id_V_U_ack_in_dummy;
wire    regslice_both_img_out_V_id_V_U_vld_out;
wire    regslice_both_img_out_V_dest_V_U_apdone_blk;
wire    regslice_both_img_out_V_dest_V_U_ack_in_dummy;
wire    regslice_both_img_out_V_dest_V_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
#0 grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg = 1'b0;
end

threshold_cv_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start),
    .ap_done(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_done),
    .ap_idle(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_idle),
    .ap_ready(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_ready),
    .threshold_out_data23_dout(threshold_out_data23_dout),
    .threshold_out_data23_num_data_valid(2'd0),
    .threshold_out_data23_fifo_cap(2'd0),
    .threshold_out_data23_empty_n(threshold_out_data23_empty_n),
    .threshold_out_data23_read(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_threshold_out_data23_read),
    .img_out_TREADY(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TREADY),
    .sof(sof_fu_70),
    .p_read1(empty_reg_189),
    .sub(sub_reg_194),
    .img_out_TDATA(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TDATA),
    .img_out_TVALID(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .img_out_TKEEP(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TKEEP),
    .img_out_TSTRB(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TSTRB),
    .img_out_TUSER(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TUSER),
    .img_out_TLAST(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TLAST),
    .img_out_TID(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TID),
    .img_out_TDEST(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TDEST)
);

threshold_cv_regslice_both #(
    .DataWidth( 8 ))
regslice_both_img_out_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TDATA),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(img_out_TREADY_int_regslice),
    .data_out(img_out_TDATA),
    .vld_out(regslice_both_img_out_V_data_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_data_V_U_apdone_blk)
);

threshold_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_out_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TKEEP),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(regslice_both_img_out_V_keep_V_U_ack_in_dummy),
    .data_out(img_out_TKEEP),
    .vld_out(regslice_both_img_out_V_keep_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_keep_V_U_apdone_blk)
);

threshold_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_out_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TSTRB),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(regslice_both_img_out_V_strb_V_U_ack_in_dummy),
    .data_out(img_out_TSTRB),
    .vld_out(regslice_both_img_out_V_strb_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_strb_V_U_apdone_blk)
);

threshold_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_out_V_user_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TUSER),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(regslice_both_img_out_V_user_V_U_ack_in_dummy),
    .data_out(img_out_TUSER),
    .vld_out(regslice_both_img_out_V_user_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_user_V_U_apdone_blk)
);

threshold_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_out_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TLAST),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(regslice_both_img_out_V_last_V_U_ack_in_dummy),
    .data_out(img_out_TLAST),
    .vld_out(regslice_both_img_out_V_last_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_last_V_U_apdone_blk)
);

threshold_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_out_V_id_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TID),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(regslice_both_img_out_V_id_V_U_ack_in_dummy),
    .data_out(img_out_TID),
    .vld_out(regslice_both_img_out_V_id_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_id_V_U_apdone_blk)
);

threshold_cv_regslice_both #(
    .DataWidth( 1 ))
regslice_both_img_out_V_dest_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TDEST),
    .vld_in(grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID),
    .ack_in(regslice_both_img_out_V_dest_V_U_ack_in_dummy),
    .data_out(img_out_TDEST),
    .vld_out(regslice_both_img_out_V_dest_V_U_vld_out),
    .ack_out(img_out_TREADY),
    .apdone_blk(regslice_both_img_out_V_dest_V_U_apdone_blk)
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
        end else if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_img_out_V_data_V_U_apdone_blk == 1'b0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg <= 1'b0;
    end else begin
        if (((icmp_ln195_fu_146_p2 == 1'd1) & (cmp81_reg_199 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
            grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg <= 1'b1;
        end else if ((grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_ready == 1'b1)) begin
            grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        i_fu_66 <= 8'd0;
    end else if (((1'b1 == ap_CS_fsm_state3) & (1'b0 == ap_block_state3_on_subcall_done))) begin
        i_fu_66 <= i_2_reg_206;
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        sof_fu_70 <= 1'd1;
    end else if (((cmp81_reg_199 == 1'd1) & (1'b1 == ap_CS_fsm_state3) & (1'b0 == ap_block_state3_on_subcall_done))) begin
        sof_fu_70 <= 1'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        cmp81_reg_199 <= cmp81_fu_123_p2;
        empty_reg_189 <= empty_fu_109_p1;
        sub_reg_194 <= sub_fu_117_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        i_2_reg_206 <= i_2_fu_151_p2;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_block_state3_on_subcall_done)) begin
        ap_ST_fsm_state3_blk = 1'b1;
    end else begin
        ap_ST_fsm_state3_blk = 1'b0;
    end
end

always @ (*) begin
    if ((regslice_both_img_out_V_data_V_U_apdone_blk == 1'b1)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_img_out_V_data_V_U_apdone_blk == 1'b0))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_img_out_V_data_V_U_apdone_blk == 1'b0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((cmp81_reg_199 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        threshold_out_data23_read = grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_threshold_out_data23_read;
    end else begin
        threshold_out_data23_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((icmp_ln195_fu_146_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((1'b1 == ap_CS_fsm_state3) & (1'b0 == ap_block_state3_on_subcall_done))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_img_out_V_data_V_U_apdone_blk == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
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
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state3_on_subcall_done = ((grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_done == 1'b0) & (cmp81_reg_199 == 1'd1));
end

assign cmp81_fu_123_p2 = (($signed(p_read1) > $signed(32'd0)) ? 1'b1 : 1'b0);

assign empty_22_fu_113_p1 = p_read1[6:0];

assign empty_fu_109_p1 = p_read1[7:0];

assign grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start = grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg;

assign grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TREADY = (img_out_TREADY_int_regslice & ap_CS_fsm_state3);

assign i_2_fu_151_p2 = (i_fu_66 + 8'd1);

assign icmp_ln195_fu_146_p2 = (($signed(zext_ln195_fu_142_p1) < $signed(p_read)) ? 1'b1 : 1'b0);

assign img_out_TVALID = regslice_both_img_out_V_data_V_U_vld_out;

assign img_out_TVALID_int_regslice = grp_xfMat2AXIvideo_8_0_128_128_1_Pipeline_loop_col_mat2axi_fu_86_img_out_TVALID;

assign sub_fu_117_p2 = ($signed(empty_22_fu_113_p1) + $signed(7'd127));

assign zext_ln195_fu_142_p1 = i_fu_66;

endmodule //threshold_cv_xfMat2AXIvideo_8_0_128_128_1_s
