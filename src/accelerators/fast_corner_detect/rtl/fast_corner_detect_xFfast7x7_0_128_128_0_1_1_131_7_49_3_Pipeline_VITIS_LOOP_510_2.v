// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module fast_corner_detect_xFfast7x7_0_128_128_0_1_1_131_7_49_3_Pipeline_VITIS_LOOP_510_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        imgInput_data1_dout,
        imgInput_data1_num_data_valid,
        imgInput_data1_fifo_cap,
        imgInput_data1_empty_n,
        imgInput_data1_read,
        img_width,
        buf_V_8_address1,
        buf_V_8_ce1,
        buf_V_8_we1,
        buf_V_8_d1,
        buf_V_7_address1,
        buf_V_7_ce1,
        buf_V_7_we1,
        buf_V_7_d1,
        buf_V_6_address1,
        buf_V_6_ce1,
        buf_V_6_we1,
        buf_V_6_d1,
        buf_V_5_address1,
        buf_V_5_ce1,
        buf_V_5_we1,
        buf_V_5_d1,
        buf_V_4_address1,
        buf_V_4_ce1,
        buf_V_4_we1,
        buf_V_4_d1,
        buf_V_3_address1,
        buf_V_3_ce1,
        buf_V_3_we1,
        buf_V_3_d1,
        buf_V_address1,
        buf_V_ce1,
        buf_V_we1,
        buf_V_d1,
        init_buf_cast
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] imgInput_data1_dout;
input  [1:0] imgInput_data1_num_data_valid;
input  [1:0] imgInput_data1_fifo_cap;
input   imgInput_data1_empty_n;
output   imgInput_data1_read;
input  [15:0] img_width;
output  [6:0] buf_V_8_address1;
output   buf_V_8_ce1;
output   buf_V_8_we1;
output  [7:0] buf_V_8_d1;
output  [6:0] buf_V_7_address1;
output   buf_V_7_ce1;
output   buf_V_7_we1;
output  [7:0] buf_V_7_d1;
output  [6:0] buf_V_6_address1;
output   buf_V_6_ce1;
output   buf_V_6_we1;
output  [7:0] buf_V_6_d1;
output  [6:0] buf_V_5_address1;
output   buf_V_5_ce1;
output   buf_V_5_we1;
output  [7:0] buf_V_5_d1;
output  [6:0] buf_V_4_address1;
output   buf_V_4_ce1;
output   buf_V_4_we1;
output  [7:0] buf_V_4_d1;
output  [6:0] buf_V_3_address1;
output   buf_V_3_ce1;
output   buf_V_3_we1;
output  [7:0] buf_V_3_d1;
output  [6:0] buf_V_address1;
output   buf_V_ce1;
output   buf_V_we1;
output  [7:0] buf_V_d1;
input  [2:0] init_buf_cast;

reg ap_idle;
reg imgInput_data1_read;
reg buf_V_8_ce1;
reg buf_V_8_we1;
reg buf_V_7_ce1;
reg buf_V_7_we1;
reg buf_V_6_ce1;
reg buf_V_6_we1;
reg buf_V_5_ce1;
reg buf_V_5_we1;
reg buf_V_4_ce1;
reg buf_V_4_we1;
reg buf_V_3_ce1;
reg buf_V_3_we1;
reg buf_V_ce1;
reg buf_V_we1;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln1027_fu_227_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    imgInput_data1_blk_n;
wire    ap_block_pp0_stage0;
wire   [2:0] init_buf_cast_read_reg_261;
reg    ap_block_pp0_stage0_11001;
reg   [12:0] col_V_8_reg_265;
reg   [12:0] col_V_8_reg_265_pp0_iter1_reg;
reg   [7:0] imgInput_data1_read_reg_274;
wire   [63:0] zext_ln541_fu_244_p1;
reg   [12:0] col_V_fu_74;
wire   [12:0] col_V_9_fu_233_p2;
wire    ap_loop_init;
reg   [12:0] ap_sig_allocacmp_col_V_8;
wire   [15:0] zext_ln1027_fu_223_p1;
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

fast_corner_detect_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
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
        if (((icmp_ln1027_fu_227_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            col_V_fu_74 <= col_V_9_fu_233_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            col_V_fu_74 <= 13'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        col_V_8_reg_265 <= ap_sig_allocacmp_col_V_8;
        col_V_8_reg_265_pp0_iter1_reg <= col_V_8_reg_265;
        imgInput_data1_read_reg_274 <= imgInput_data1_dout;
    end
end

always @ (*) begin
    if (((icmp_ln1027_fu_227_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_col_V_8 = 13'd0;
    end else begin
        ap_sig_allocacmp_col_V_8 = col_V_fu_74;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_3_ce1 = 1'b1;
    end else begin
        buf_V_3_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (init_buf_cast_read_reg_261 == 3'd1))) begin
        buf_V_3_we1 = 1'b1;
    end else begin
        buf_V_3_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_4_ce1 = 1'b1;
    end else begin
        buf_V_4_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (init_buf_cast_read_reg_261 == 3'd2))) begin
        buf_V_4_we1 = 1'b1;
    end else begin
        buf_V_4_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_5_ce1 = 1'b1;
    end else begin
        buf_V_5_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (init_buf_cast_read_reg_261 == 3'd3))) begin
        buf_V_5_we1 = 1'b1;
    end else begin
        buf_V_5_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_6_ce1 = 1'b1;
    end else begin
        buf_V_6_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (init_buf_cast_read_reg_261 == 3'd4))) begin
        buf_V_6_we1 = 1'b1;
    end else begin
        buf_V_6_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_7_ce1 = 1'b1;
    end else begin
        buf_V_7_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (init_buf_cast_read_reg_261 == 3'd5))) begin
        buf_V_7_we1 = 1'b1;
    end else begin
        buf_V_7_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_8_ce1 = 1'b1;
    end else begin
        buf_V_8_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & ((init_buf_cast_read_reg_261 == 3'd6) | (init_buf_cast_read_reg_261 == 3'd7)))) begin
        buf_V_8_we1 = 1'b1;
    end else begin
        buf_V_8_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_ce1 = 1'b1;
    end else begin
        buf_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (init_buf_cast_read_reg_261 == 3'd0))) begin
        buf_V_we1 = 1'b1;
    end else begin
        buf_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        imgInput_data1_blk_n = imgInput_data1_empty_n;
    end else begin
        imgInput_data1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        imgInput_data1_read = 1'b1;
    end else begin
        imgInput_data1_read = 1'b0;
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

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((imgInput_data1_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((imgInput_data1_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (imgInput_data1_empty_n == 1'b0);
end

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign buf_V_3_address1 = zext_ln541_fu_244_p1;

assign buf_V_3_d1 = imgInput_data1_read_reg_274;

assign buf_V_4_address1 = zext_ln541_fu_244_p1;

assign buf_V_4_d1 = imgInput_data1_read_reg_274;

assign buf_V_5_address1 = zext_ln541_fu_244_p1;

assign buf_V_5_d1 = imgInput_data1_read_reg_274;

assign buf_V_6_address1 = zext_ln541_fu_244_p1;

assign buf_V_6_d1 = imgInput_data1_read_reg_274;

assign buf_V_7_address1 = zext_ln541_fu_244_p1;

assign buf_V_7_d1 = imgInput_data1_read_reg_274;

assign buf_V_8_address1 = zext_ln541_fu_244_p1;

assign buf_V_8_d1 = imgInput_data1_read_reg_274;

assign buf_V_address1 = zext_ln541_fu_244_p1;

assign buf_V_d1 = imgInput_data1_read_reg_274;

assign col_V_9_fu_233_p2 = (ap_sig_allocacmp_col_V_8 + 13'd1);

assign icmp_ln1027_fu_227_p2 = ((zext_ln1027_fu_223_p1 < img_width) ? 1'b1 : 1'b0);

assign init_buf_cast_read_reg_261 = init_buf_cast;

assign zext_ln1027_fu_223_p1 = ap_sig_allocacmp_col_V_8;

assign zext_ln541_fu_244_p1 = col_V_8_reg_265_pp0_iter1_reg;

endmodule //fast_corner_detect_xFfast7x7_0_128_128_0_1_1_131_7_49_3_Pipeline_VITIS_LOOP_510_2
