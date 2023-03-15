// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rgb2hsv_cv_xfMat2AXIvideo_patch_32_9_128_128_1_0_Pipeline_loop_col_mat2axi (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        rgb2hsv_out_data19_dout,
        rgb2hsv_out_data19_num_data_valid,
        rgb2hsv_out_data19_fifo_cap,
        rgb2hsv_out_data19_empty_n,
        rgb2hsv_out_data19_read,
        img_out_TREADY,
        cols,
        sub,
        img_out_TDATA,
        img_out_TVALID,
        img_out_TKEEP,
        img_out_TSTRB,
        img_out_TUSER,
        img_out_TLAST,
        img_out_TID,
        img_out_TDEST
);

parameter    ap_ST_iter0_fsm_state1 = 1'd1;
parameter    ap_ST_iter1_fsm_state2 = 2'd2;
parameter    ap_ST_iter1_fsm_state0 = 2'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [23:0] rgb2hsv_out_data19_dout;
input  [1:0] rgb2hsv_out_data19_num_data_valid;
input  [1:0] rgb2hsv_out_data19_fifo_cap;
input   rgb2hsv_out_data19_empty_n;
output   rgb2hsv_out_data19_read;
input   img_out_TREADY;
input  [31:0] cols;
input  [31:0] sub;
output  [31:0] img_out_TDATA;
output   img_out_TVALID;
output  [3:0] img_out_TKEEP;
output  [3:0] img_out_TSTRB;
output  [0:0] img_out_TUSER;
output  [0:0] img_out_TLAST;
output  [0:0] img_out_TID;
output  [0:0] img_out_TDEST;

reg ap_idle;
reg rgb2hsv_out_data19_read;
reg img_out_TVALID;

reg   [0:0] ap_CS_iter0_fsm;
wire    ap_CS_iter0_fsm_state1;
reg   [1:0] ap_CS_iter1_fsm;
wire    ap_CS_iter1_fsm_state0;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] icmp_ln141_reg_169;
wire   [0:0] icmp_ln141_reg_169_pp0_iter0_reg;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state2_io;
wire    ap_CS_iter1_fsm_state2;
wire   [0:0] icmp_ln141_fu_134_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    rgb2hsv_out_data19_blk_n;
reg    img_out_TDATA_blk_n;
wire   [0:0] axi_last_V_fu_146_p2;
reg   [0:0] axi_last_V_reg_173;
reg   [7:0] j_fu_70;
wire   [7:0] j_2_fu_140_p2;
wire    ap_loop_init;
reg   [7:0] ap_sig_allocacmp_j_1;
wire   [31:0] zext_ln141_fu_130_p1;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [0:0] ap_NS_iter0_fsm;
reg   [1:0] ap_NS_iter1_fsm;
reg    ap_ST_iter0_fsm_state1_blk;
reg    ap_ST_iter1_fsm_state2_blk;
wire    ap_start_int;
reg    ap_condition_163;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_iter0_fsm = 1'd1;
#0 ap_CS_iter1_fsm = 2'd1;
#0 ap_done_reg = 1'b0;
end

rgb2hsv_cv_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_iter0_fsm <= ap_ST_iter0_fsm_state1;
    end else begin
        ap_CS_iter0_fsm <= ap_NS_iter0_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_iter1_fsm <= ap_ST_iter1_fsm_state0;
    end else begin
        ap_CS_iter1_fsm <= ap_NS_iter1_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (1'b1 == ap_CS_iter1_fsm_state2) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (ap_loop_exit_ready == 1'b0) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= 1'b0;
    end else if ((~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_163)) begin
        if ((icmp_ln141_fu_134_p2 == 1'd1)) begin
            j_fu_70 <= j_2_fu_140_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            j_fu_70 <= 8'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (icmp_ln141_fu_134_p2 == 1'd1) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        axi_last_V_reg_173 <= axi_last_V_fu_146_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        icmp_ln141_reg_169 <= icmp_ln141_fu_134_p2;
    end
end

always @ (*) begin
    if ((ap_start_int == 1'b0)) begin
        ap_ST_iter0_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_iter0_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0)))) begin
        ap_ST_iter1_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_iter1_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (icmp_ln141_fu_134_p2 == 1'd0) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (1'b1 == ap_CS_iter1_fsm_state2) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_iter1_fsm_state0) & (1'b1 == ap_CS_iter0_fsm_state1) & (ap_start_int == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
        ap_sig_allocacmp_j_1 = 8'd0;
    end else begin
        ap_sig_allocacmp_j_1 = j_fu_70;
    end
end

always @ (*) begin
    if (((icmp_ln141_reg_169 == 1'd1) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
        img_out_TDATA_blk_n = img_out_TREADY;
    end else begin
        img_out_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (icmp_ln141_reg_169 == 1'd1) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
        img_out_TVALID = 1'b1;
    end else begin
        img_out_TVALID = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln141_reg_169 == 1'd1) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
        rgb2hsv_out_data19_blk_n = rgb2hsv_out_data19_empty_n;
    end else begin
        rgb2hsv_out_data19_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (icmp_ln141_reg_169 == 1'd1) & (1'b1 == ap_CS_iter1_fsm_state2))) begin
        rgb2hsv_out_data19_read = 1'b1;
    end else begin
        rgb2hsv_out_data19_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_iter0_fsm)
        ap_ST_iter0_fsm_state1 : begin
            ap_NS_iter0_fsm = ap_ST_iter0_fsm_state1;
        end
        default : begin
            ap_NS_iter0_fsm = 'bx;
        end
    endcase
end

always @ (*) begin
    case (ap_CS_iter1_fsm)
        ap_ST_iter1_fsm_state2 : begin
            if ((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & ((1'b0 == ap_CS_iter0_fsm_state1) | ((1'b1 == ap_CS_iter0_fsm_state1) & (ap_start_int == 1'b0))))) begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state0;
            end else if (((~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (1'b1 == ap_CS_iter0_fsm_state1) & (ap_start_int == 1'b1)) | (~((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))) & (icmp_ln141_reg_169_pp0_iter0_reg == 1'd0) & (1'b1 == ap_CS_iter1_fsm_state2)))) begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state2;
            end else begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state2;
            end
        end
        ap_ST_iter1_fsm_state0 : begin
            if ((~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (1'b1 == ap_CS_iter0_fsm_state1))) begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state2;
            end else begin
                ap_NS_iter1_fsm = ap_ST_iter1_fsm_state0;
            end
        end
        default : begin
            ap_NS_iter1_fsm = 'bx;
        end
    endcase
end

assign ap_CS_iter0_fsm_state1 = ap_CS_iter0_fsm[32'd0];

assign ap_CS_iter1_fsm_state0 = ap_CS_iter1_fsm[32'd0];

assign ap_CS_iter1_fsm_state2 = ap_CS_iter1_fsm[32'd1];

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_start_int == 1'b0);
end

always @ (*) begin
    ap_block_state2_io = ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0)));
end

always @ (*) begin
    ap_condition_163 = (~((ap_start_int == 1'b0) | ((1'b1 == ap_CS_iter1_fsm_state2) & ((1'b1 == ap_block_state2_io) | ((img_out_TREADY == 1'b0) & (icmp_ln141_reg_169 == 1'd1)) | ((icmp_ln141_reg_169 == 1'd1) & (rgb2hsv_out_data19_empty_n == 1'b0))))) & (1'b1 == ap_CS_iter0_fsm_state1));
end

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign axi_last_V_fu_146_p2 = ((zext_ln141_fu_130_p1 == sub) ? 1'b1 : 1'b0);

assign icmp_ln141_fu_134_p2 = (($signed(zext_ln141_fu_130_p1) < $signed(cols)) ? 1'b1 : 1'b0);

assign icmp_ln141_reg_169_pp0_iter0_reg = icmp_ln141_reg_169;

assign img_out_TDATA = rgb2hsv_out_data19_dout;

assign img_out_TDEST = 1'd0;

assign img_out_TID = 1'd0;

assign img_out_TKEEP = 4'd15;

assign img_out_TLAST = axi_last_V_reg_173;

assign img_out_TSTRB = 4'd0;

assign img_out_TUSER = 1'd0;

assign j_2_fu_140_p2 = (ap_sig_allocacmp_j_1 + 8'd1);

assign zext_ln141_fu_130_p1 = ap_sig_allocacmp_j_1;

endmodule //rgb2hsv_cv_xfMat2AXIvideo_patch_32_9_128_128_1_0_Pipeline_loop_col_mat2axi
