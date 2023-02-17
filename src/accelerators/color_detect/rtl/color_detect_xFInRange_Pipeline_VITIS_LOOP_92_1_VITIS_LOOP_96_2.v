// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module color_detect_xFInRange_Pipeline_VITIS_LOOP_92_1_VITIS_LOOP_96_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        rgb2hsv_data119_dout,
        rgb2hsv_data119_num_data_valid,
        rgb2hsv_data119_fifo_cap,
        rgb2hsv_data119_empty_n,
        rgb2hsv_data119_read,
        imgHelper1_data120_din,
        imgHelper1_data120_num_data_valid,
        imgHelper1_data120_fifo_cap,
        imgHelper1_data120_full_n,
        imgHelper1_data120_write,
        bound
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [23:0] rgb2hsv_data119_dout;
input  [1:0] rgb2hsv_data119_num_data_valid;
input  [1:0] rgb2hsv_data119_fifo_cap;
input   rgb2hsv_data119_empty_n;
output   rgb2hsv_data119_read;
output  [7:0] imgHelper1_data120_din;
input  [1:0] imgHelper1_data120_num_data_valid;
input  [1:0] imgHelper1_data120_fifo_cap;
input   imgHelper1_data120_full_n;
output   imgHelper1_data120_write;
input  [31:0] bound;

reg ap_idle;
reg rgb2hsv_data119_read;
reg imgHelper1_data120_write;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln92_fu_101_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    rgb2hsv_data119_blk_n;
wire    ap_block_pp0_stage0;
reg    imgHelper1_data120_blk_n;
reg    ap_block_pp0_stage0_11001;
wire   [0:0] rhs_V_fu_150_p2;
reg   [0:0] rhs_V_reg_249;
wire   [0:0] rhs_V_1_fu_166_p2;
reg   [0:0] rhs_V_1_reg_254;
wire   [0:0] or_ln1498_1_fu_214_p2;
reg   [0:0] or_ln1498_1_reg_259;
reg   [31:0] indvar_flatten_fu_70;
wire   [31:0] add_ln92_fu_107_p2;
wire    ap_loop_init;
reg   [31:0] ap_sig_allocacmp_indvar_flatten_load;
reg    ap_block_pp0_stage0_01001;
wire   [7:0] tmp_val1_V_fu_118_p1;
wire   [0:0] icmp_ln56_1_fu_128_p2;
wire   [0:0] icmp_ln56_fu_122_p2;
wire   [7:0] tmp_val1_V_1_fu_140_p4;
wire   [7:0] tmp_val1_V_2_fu_156_p4;
wire   [0:0] icmp_ln56_5_fu_178_p2;
wire   [0:0] icmp_ln56_4_fu_172_p2;
wire   [0:0] icmp_ln56_7_fu_196_p2;
wire   [0:0] icmp_ln56_6_fu_190_p2;
wire   [0:0] lhs_V_fu_134_p2;
wire   [0:0] lhs_V_2_fu_202_p2;
wire   [0:0] or_ln1498_fu_208_p2;
wire   [0:0] lhs_V_1_fu_184_p2;
wire   [0:0] and_ln1498_fu_220_p2;
wire   [0:0] ret_V_fu_224_p2;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_done_reg = 1'b0;
end

color_detect_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
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
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln92_fu_101_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten_fu_70 <= add_ln92_fu_107_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten_fu_70 <= 32'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        or_ln1498_1_reg_259 <= or_ln1498_1_fu_214_p2;
        rhs_V_1_reg_254 <= rhs_V_1_fu_166_p2;
        rhs_V_reg_249 <= rhs_V_fu_150_p2;
    end
end

always @ (*) begin
    if (((icmp_ln92_fu_101_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_indvar_flatten_load = 32'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten_load = indvar_flatten_fu_70;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        imgHelper1_data120_blk_n = imgHelper1_data120_full_n;
    end else begin
        imgHelper1_data120_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        imgHelper1_data120_write = 1'b1;
    end else begin
        imgHelper1_data120_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        rgb2hsv_data119_blk_n = rgb2hsv_data119_empty_n;
    end else begin
        rgb2hsv_data119_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        rgb2hsv_data119_read = 1'b1;
    end else begin
        rgb2hsv_data119_read = 1'b0;
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

assign add_ln92_fu_107_p2 = (ap_sig_allocacmp_indvar_flatten_load + 32'd1);

assign and_ln1498_fu_220_p2 = (rhs_V_1_reg_254 & or_ln1498_1_reg_259);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((imgHelper1_data120_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((rgb2hsv_data119_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((imgHelper1_data120_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((rgb2hsv_data119_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((imgHelper1_data120_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((rgb2hsv_data119_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (rgb2hsv_data119_empty_n == 1'b0);
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (imgHelper1_data120_full_n == 1'b0);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign icmp_ln56_1_fu_128_p2 = ((tmp_val1_V_fu_118_p1 < 8'd39) ? 1'b1 : 1'b0);

assign icmp_ln56_4_fu_172_p2 = ((tmp_val1_V_fu_118_p1 > 8'd37) ? 1'b1 : 1'b0);

assign icmp_ln56_5_fu_178_p2 = ((tmp_val1_V_fu_118_p1 < 8'd76) ? 1'b1 : 1'b0);

assign icmp_ln56_6_fu_190_p2 = ((tmp_val1_V_fu_118_p1 > 8'd159) ? 1'b1 : 1'b0);

assign icmp_ln56_7_fu_196_p2 = ((tmp_val1_V_fu_118_p1 < 8'd180) ? 1'b1 : 1'b0);

assign icmp_ln56_fu_122_p2 = ((tmp_val1_V_fu_118_p1 > 8'd21) ? 1'b1 : 1'b0);

assign icmp_ln92_fu_101_p2 = ((ap_sig_allocacmp_indvar_flatten_load == bound) ? 1'b1 : 1'b0);

assign imgHelper1_data120_din = ((ret_V_fu_224_p2[0:0] == 1'b1) ? 8'd255 : 8'd0);

assign lhs_V_1_fu_184_p2 = (icmp_ln56_5_fu_178_p2 & icmp_ln56_4_fu_172_p2);

assign lhs_V_2_fu_202_p2 = (icmp_ln56_7_fu_196_p2 & icmp_ln56_6_fu_190_p2);

assign lhs_V_fu_134_p2 = (icmp_ln56_fu_122_p2 & icmp_ln56_1_fu_128_p2);

assign or_ln1498_1_fu_214_p2 = (or_ln1498_fu_208_p2 | lhs_V_1_fu_184_p2);

assign or_ln1498_fu_208_p2 = (lhs_V_fu_134_p2 | lhs_V_2_fu_202_p2);

assign ret_V_fu_224_p2 = (rhs_V_reg_249 & and_ln1498_fu_220_p2);

assign rhs_V_1_fu_166_p2 = ((tmp_val1_V_2_fu_156_p4 > 8'd59) ? 1'b1 : 1'b0);

assign rhs_V_fu_150_p2 = ((tmp_val1_V_1_fu_140_p4 > 8'd149) ? 1'b1 : 1'b0);

assign tmp_val1_V_1_fu_140_p4 = {{rgb2hsv_data119_dout[15:8]}};

assign tmp_val1_V_2_fu_156_p4 = {{rgb2hsv_data119_dout[23:16]}};

assign tmp_val1_V_fu_118_p1 = rgb2hsv_data119_dout[7:0];

endmodule //color_detect_xFInRange_Pipeline_VITIS_LOOP_92_1_VITIS_LOOP_96_2
