// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2_AR72614
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Loop_VConvH_proc (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        height_dout,
        height_empty_n,
        height_read,
        vconv_xlim_loc_dout,
        vconv_xlim_loc_empty_n,
        vconv_xlim_loc_read,
        hconv_V_dout,
        hconv_V_empty_n,
        hconv_V_read,
        vconv_V_din,
        vconv_V_full_n,
        vconv_V_write,
        height_out_din,
        height_out_full_n,
        height_out_write,
        vconv_xlim_loc_out_din,
        vconv_xlim_loc_out_full_n,
        vconv_xlim_loc_out_write
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state5 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] height_dout;
input   height_empty_n;
output   height_read;
input  [31:0] vconv_xlim_loc_dout;
input   vconv_xlim_loc_empty_n;
output   vconv_xlim_loc_read;
input  [31:0] hconv_V_dout;
input   hconv_V_empty_n;
output   hconv_V_read;
output  [31:0] vconv_V_din;
input   vconv_V_full_n;
output   vconv_V_write;
output  [31:0] height_out_din;
input   height_out_full_n;
output   height_out_write;
output  [31:0] vconv_xlim_loc_out_din;
input   vconv_xlim_loc_out_full_n;
output   vconv_xlim_loc_out_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg height_read;
reg vconv_xlim_loc_read;
reg hconv_V_read;
reg vconv_V_write;
reg height_out_write;
reg vconv_xlim_loc_out_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [10:0] linebuf_0_address0;
reg    linebuf_0_ce0;
reg    linebuf_0_we0;
wire   [31:0] linebuf_0_q0;
wire   [10:0] linebuf_1_address0;
reg    linebuf_1_ce0;
wire   [31:0] linebuf_1_q0;
wire   [10:0] linebuf_1_address1;
reg    linebuf_1_ce1;
reg    linebuf_1_we1;
wire   [10:0] linebuf_2_address0;
reg    linebuf_2_ce0;
wire   [31:0] linebuf_2_q0;
wire   [10:0] linebuf_2_address1;
reg    linebuf_2_ce1;
reg    linebuf_2_we1;
wire   [10:0] linebuf_3_address0;
reg    linebuf_3_ce0;
wire   [31:0] linebuf_3_q0;
wire   [10:0] linebuf_3_address1;
reg    linebuf_3_ce1;
reg    linebuf_3_we1;
wire   [10:0] linebuf_4_address0;
reg    linebuf_4_ce0;
wire   [31:0] linebuf_4_q0;
wire   [10:0] linebuf_4_address1;
reg    linebuf_4_ce1;
reg    linebuf_4_we1;
wire   [10:0] linebuf_5_address0;
reg    linebuf_5_ce0;
wire   [31:0] linebuf_5_q0;
wire   [10:0] linebuf_5_address1;
reg    linebuf_5_ce1;
reg    linebuf_5_we1;
wire   [10:0] linebuf_6_address0;
reg    linebuf_6_ce0;
wire   [31:0] linebuf_6_q0;
wire   [10:0] linebuf_6_address1;
reg    linebuf_6_ce1;
reg    linebuf_6_we1;
wire   [10:0] linebuf_7_address0;
reg    linebuf_7_ce0;
wire   [31:0] linebuf_7_q0;
wire   [10:0] linebuf_7_address1;
reg    linebuf_7_ce1;
reg    linebuf_7_we1;
wire   [10:0] linebuf_8_address0;
reg    linebuf_8_ce0;
wire   [31:0] linebuf_8_q0;
wire   [10:0] linebuf_8_address1;
reg    linebuf_8_ce1;
reg    linebuf_8_we1;
wire   [10:0] linebuf_9_address0;
reg    linebuf_9_ce0;
wire   [31:0] linebuf_9_q0;
wire   [10:0] linebuf_9_address1;
reg    linebuf_9_ce1;
reg    linebuf_9_we1;
reg    height_blk_n;
reg    vconv_xlim_loc_blk_n;
reg    hconv_V_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage0;
reg   [0:0] icmp_ln170_reg_595;
reg    vconv_V_blk_n;
reg    ap_enable_reg_pp0_iter2;
reg   [0:0] select_ln170_1_reg_604;
reg   [0:0] select_ln170_1_reg_604_pp0_iter1_reg;
reg    height_out_blk_n;
reg    vconv_xlim_loc_out_blk_n;
reg   [63:0] indvar_flatten_reg_314;
reg   [10:0] col1_0_i_i_i_reg_325;
reg   [10:0] row2_0_i_i_i_reg_336;
reg   [31:0] vconv_xlim_loc_read_reg_585;
reg    ap_block_state1;
wire   [63:0] bound_fu_355_p2;
reg   [63:0] bound_reg_590;
wire   [0:0] icmp_ln170_fu_370_p2;
wire    ap_block_state2_pp0_stage0_iter0;
reg    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state4_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] icmp_ln170_reg_595_pp0_iter1_reg;
wire   [63:0] add_ln170_fu_375_p2;
reg    ap_enable_reg_pp0_iter0;
wire   [0:0] select_ln170_1_fu_407_p3;
wire   [10:0] select_ln170_2_fu_415_p3;
reg   [10:0] linebuf_0_addr_reg_613;
reg   [10:0] linebuf_1_addr_reg_618;
reg   [10:0] linebuf_2_addr_reg_624;
reg   [10:0] linebuf_3_addr_reg_630;
reg   [10:0] linebuf_4_addr_reg_636;
reg   [10:0] linebuf_5_addr_reg_642;
reg   [10:0] linebuf_6_addr_reg_648;
reg   [10:0] linebuf_7_addr_reg_654;
reg   [10:0] linebuf_8_addr_reg_660;
reg   [10:0] linebuf_9_addr_reg_666;
wire   [10:0] row_fu_437_p2;
reg   [31:0] tmp_1_reg_677;
wire   [31:0] mul_ln179_fu_443_p2;
reg   [31:0] mul_ln179_reg_683;
wire   [31:0] mul_ln179_1_fu_449_p2;
reg   [31:0] mul_ln179_1_reg_688;
wire   [31:0] mul_ln179_2_fu_455_p2;
reg   [31:0] mul_ln179_2_reg_693;
wire   [31:0] mul_ln179_5_fu_473_p2;
reg   [31:0] mul_ln179_5_reg_698;
wire   [31:0] mul_ln179_6_fu_479_p2;
reg   [31:0] mul_ln179_6_reg_703;
wire   [31:0] add_ln179_5_fu_497_p2;
reg   [31:0] add_ln179_5_reg_708;
wire   [31:0] add_ln179_8_fu_503_p2;
reg   [31:0] add_ln179_8_reg_713;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [63:0] zext_ln178_fu_423_p1;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] bound_fu_355_p0;
wire   [31:0] bound_fu_355_p1;
wire   [31:0] zext_ln171_fu_361_p1;
wire   [0:0] icmp_ln171_fu_365_p2;
wire   [10:0] add_ln170_1_fu_389_p2;
wire   [0:0] icmp_ln183_1_fu_401_p2;
wire   [0:0] icmp_ln183_fu_395_p2;
wire   [10:0] select_ln170_fu_381_p3;
wire  signed [31:0] mul_ln179_fu_443_p1;
wire  signed [31:0] mul_ln179_1_fu_449_p1;
wire  signed [31:0] mul_ln179_2_fu_455_p1;
wire  signed [31:0] mul_ln179_3_fu_461_p1;
wire  signed [31:0] mul_ln179_4_fu_467_p1;
wire  signed [31:0] mul_ln179_5_fu_473_p1;
wire  signed [31:0] mul_ln179_6_fu_479_p1;
wire  signed [31:0] mul_ln179_7_fu_485_p1;
wire  signed [31:0] mul_ln179_8_fu_491_p1;
wire   [31:0] mul_ln179_3_fu_461_p2;
wire   [31:0] mul_ln179_4_fu_467_p2;
wire   [31:0] mul_ln179_7_fu_485_p2;
wire   [31:0] mul_ln179_8_fu_491_p2;
wire   [31:0] shl_ln179_2_fu_521_p2;
wire   [31:0] shl_ln179_fu_509_p2;
wire   [31:0] add_ln179_fu_531_p2;
wire   [31:0] shl_ln179_3_fu_526_p2;
wire   [31:0] add_ln179_2_fu_543_p2;
wire   [31:0] shl_ln179_1_fu_515_p2;
wire   [31:0] add_ln179_3_fu_547_p2;
wire   [31:0] add_ln179_1_fu_537_p2;
wire   [31:0] add_ln179_7_fu_563_p2;
wire   [31:0] add_ln179_9_fu_567_p2;
wire   [31:0] add_ln179_6_fu_559_p2;
wire   [31:0] add_ln179_10_fu_572_p2;
wire   [31:0] add_ln179_4_fu_553_p2;
wire    ap_CS_fsm_state5;
reg   [2:0] ap_NS_fsm;
reg    ap_block_pp0;
reg    ap_enable_operation_37;
reg    ap_enable_state2_pp0_iter0_stage0;
reg    ap_enable_operation_58;
reg    ap_enable_state3_pp0_iter1_stage0;
reg    ap_enable_operation_63;
reg    ap_enable_operation_60;
reg    ap_enable_operation_57;
reg    ap_enable_operation_93;
reg    ap_enable_state4_pp0_iter2_stage0;
reg    ap_enable_operation_39;
reg    ap_enable_operation_61;
reg    ap_enable_operation_66;
reg    ap_enable_operation_41;
reg    ap_enable_operation_64;
reg    ap_enable_operation_69;
reg    ap_enable_operation_43;
reg    ap_enable_operation_67;
reg    ap_enable_operation_72;
reg    ap_enable_operation_45;
reg    ap_enable_operation_70;
reg    ap_enable_operation_75;
reg    ap_enable_operation_47;
reg    ap_enable_operation_73;
reg    ap_enable_operation_78;
reg    ap_enable_operation_49;
reg    ap_enable_operation_76;
reg    ap_enable_operation_81;
reg    ap_enable_operation_51;
reg    ap_enable_operation_79;
reg    ap_enable_operation_84;
reg    ap_enable_operation_53;
reg    ap_enable_operation_82;
reg    ap_enable_operation_87;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [63:0] bound_fu_355_p00;
wire   [63:0] bound_fu_355_p10;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
end

Loop_VConvH_proc_bkb #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_0_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_0_address0),
    .ce0(linebuf_0_ce0),
    .we0(linebuf_0_we0),
    .d0(linebuf_1_q0),
    .q0(linebuf_0_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_1_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_1_address0),
    .ce0(linebuf_1_ce0),
    .q0(linebuf_1_q0),
    .address1(linebuf_1_address1),
    .ce1(linebuf_1_ce1),
    .we1(linebuf_1_we1),
    .d1(linebuf_2_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_2_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_2_address0),
    .ce0(linebuf_2_ce0),
    .q0(linebuf_2_q0),
    .address1(linebuf_2_address1),
    .ce1(linebuf_2_ce1),
    .we1(linebuf_2_we1),
    .d1(linebuf_3_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_3_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_3_address0),
    .ce0(linebuf_3_ce0),
    .q0(linebuf_3_q0),
    .address1(linebuf_3_address1),
    .ce1(linebuf_3_ce1),
    .we1(linebuf_3_we1),
    .d1(linebuf_4_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_4_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_4_address0),
    .ce0(linebuf_4_ce0),
    .q0(linebuf_4_q0),
    .address1(linebuf_4_address1),
    .ce1(linebuf_4_ce1),
    .we1(linebuf_4_we1),
    .d1(linebuf_5_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_5_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_5_address0),
    .ce0(linebuf_5_ce0),
    .q0(linebuf_5_q0),
    .address1(linebuf_5_address1),
    .ce1(linebuf_5_ce1),
    .we1(linebuf_5_we1),
    .d1(linebuf_6_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_6_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_6_address0),
    .ce0(linebuf_6_ce0),
    .q0(linebuf_6_q0),
    .address1(linebuf_6_address1),
    .ce1(linebuf_6_ce1),
    .we1(linebuf_6_we1),
    .d1(linebuf_7_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_7_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_7_address0),
    .ce0(linebuf_7_ce0),
    .q0(linebuf_7_q0),
    .address1(linebuf_7_address1),
    .ce1(linebuf_7_ce1),
    .we1(linebuf_7_we1),
    .d1(linebuf_8_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_8_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_8_address0),
    .ce0(linebuf_8_ce0),
    .q0(linebuf_8_q0),
    .address1(linebuf_8_address1),
    .ce1(linebuf_8_ce1),
    .we1(linebuf_8_we1),
    .d1(linebuf_9_q0)
);

Loop_VConvH_proc_cud #(
    .DataWidth( 32 ),
    .AddressRange( 1920 ),
    .AddressWidth( 11 ))
linebuf_9_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(linebuf_9_address0),
    .ce0(linebuf_9_ce0),
    .q0(linebuf_9_q0),
    .address1(linebuf_9_address1),
    .ce1(linebuf_9_ce1),
    .we1(linebuf_9_we1),
    .d1(hconv_V_dout)
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
        end else if ((1'b1 == ap_CS_fsm_state5)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            if ((1'b1 == ap_condition_pp0_exit_iter0_state2)) begin
                ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
            end else if ((1'b1 == 1'b1)) begin
                ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_fu_370_p2 == 1'd0))) begin
        col1_0_i_i_i_reg_325 <= select_ln170_2_fu_415_p3;
    end else if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        col1_0_i_i_i_reg_325 <= 11'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_fu_370_p2 == 1'd0))) begin
        indvar_flatten_reg_314 <= add_ln170_fu_375_p2;
    end else if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        indvar_flatten_reg_314 <= 64'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_fu_370_p2 == 1'd0))) begin
        row2_0_i_i_i_reg_336 <= row_fu_437_p2;
    end else if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        row2_0_i_i_i_reg_336 <= 11'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        add_ln179_5_reg_708 <= add_ln179_5_fu_497_p2;
        add_ln179_8_reg_713 <= add_ln179_8_fu_503_p2;
        mul_ln179_1_reg_688 <= mul_ln179_1_fu_449_p2;
        mul_ln179_2_reg_693 <= mul_ln179_2_fu_455_p2;
        mul_ln179_5_reg_698 <= mul_ln179_5_fu_473_p2;
        mul_ln179_6_reg_703 <= mul_ln179_6_fu_479_p2;
        mul_ln179_reg_683 <= mul_ln179_fu_443_p2;
        tmp_1_reg_677 <= hconv_V_dout;
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        bound_reg_590 <= bound_fu_355_p2;
        vconv_xlim_loc_read_reg_585 <= vconv_xlim_loc_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln170_reg_595 <= icmp_ln170_fu_370_p2;
        icmp_ln170_reg_595_pp0_iter1_reg <= icmp_ln170_reg_595;
        select_ln170_1_reg_604_pp0_iter1_reg <= select_ln170_1_reg_604;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_fu_370_p2 == 1'd0))) begin
        linebuf_0_addr_reg_613 <= zext_ln178_fu_423_p1;
        linebuf_1_addr_reg_618 <= zext_ln178_fu_423_p1;
        linebuf_2_addr_reg_624 <= zext_ln178_fu_423_p1;
        linebuf_3_addr_reg_630 <= zext_ln178_fu_423_p1;
        linebuf_4_addr_reg_636 <= zext_ln178_fu_423_p1;
        linebuf_5_addr_reg_642 <= zext_ln178_fu_423_p1;
        linebuf_6_addr_reg_648 <= zext_ln178_fu_423_p1;
        linebuf_7_addr_reg_654 <= zext_ln178_fu_423_p1;
        linebuf_8_addr_reg_660 <= zext_ln178_fu_423_p1;
        linebuf_9_addr_reg_666 <= zext_ln178_fu_423_p1;
        select_ln170_1_reg_604 <= select_ln170_1_fu_407_p3;
    end
end

always @ (*) begin
    if ((icmp_ln170_fu_370_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
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
    if (((ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0) & (1'b0 == ap_block_pp0_stage0))) begin
        hconv_V_blk_n = hconv_V_empty_n;
    end else begin
        hconv_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        hconv_V_read = 1'b1;
    end else begin
        hconv_V_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        height_blk_n = height_empty_n;
    end else begin
        height_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        height_out_blk_n = height_out_full_n;
    end else begin
        height_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        height_out_write = 1'b1;
    end else begin
        height_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        height_read = 1'b1;
    end else begin
        height_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_0_ce0 = 1'b1;
    end else begin
        linebuf_0_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_0_we0 = 1'b1;
    end else begin
        linebuf_0_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_1_ce0 = 1'b1;
    end else begin
        linebuf_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_1_ce1 = 1'b1;
    end else begin
        linebuf_1_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_1_we1 = 1'b1;
    end else begin
        linebuf_1_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_2_ce0 = 1'b1;
    end else begin
        linebuf_2_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_2_ce1 = 1'b1;
    end else begin
        linebuf_2_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_2_we1 = 1'b1;
    end else begin
        linebuf_2_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_3_ce0 = 1'b1;
    end else begin
        linebuf_3_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_3_ce1 = 1'b1;
    end else begin
        linebuf_3_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_3_we1 = 1'b1;
    end else begin
        linebuf_3_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_4_ce0 = 1'b1;
    end else begin
        linebuf_4_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_4_ce1 = 1'b1;
    end else begin
        linebuf_4_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_4_we1 = 1'b1;
    end else begin
        linebuf_4_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_5_ce0 = 1'b1;
    end else begin
        linebuf_5_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_5_ce1 = 1'b1;
    end else begin
        linebuf_5_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_5_we1 = 1'b1;
    end else begin
        linebuf_5_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_6_ce0 = 1'b1;
    end else begin
        linebuf_6_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_6_ce1 = 1'b1;
    end else begin
        linebuf_6_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_6_we1 = 1'b1;
    end else begin
        linebuf_6_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_7_ce0 = 1'b1;
    end else begin
        linebuf_7_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_7_ce1 = 1'b1;
    end else begin
        linebuf_7_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_7_we1 = 1'b1;
    end else begin
        linebuf_7_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_8_ce0 = 1'b1;
    end else begin
        linebuf_8_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_8_ce1 = 1'b1;
    end else begin
        linebuf_8_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_8_we1 = 1'b1;
    end else begin
        linebuf_8_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_9_ce0 = 1'b1;
    end else begin
        linebuf_9_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        linebuf_9_ce1 = 1'b1;
    end else begin
        linebuf_9_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln170_reg_595 == 1'd0))) begin
        linebuf_9_we1 = 1'b1;
    end else begin
        linebuf_9_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (select_ln170_1_reg_604_pp0_iter1_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0))) begin
        vconv_V_blk_n = vconv_V_full_n;
    end else begin
        vconv_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (select_ln170_1_reg_604_pp0_iter1_reg == 1'd1))) begin
        vconv_V_write = 1'b1;
    end else begin
        vconv_V_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        vconv_xlim_loc_blk_n = vconv_xlim_loc_empty_n;
    end else begin
        vconv_xlim_loc_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        vconv_xlim_loc_out_blk_n = vconv_xlim_loc_out_full_n;
    end else begin
        vconv_xlim_loc_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        vconv_xlim_loc_out_write = 1'b1;
    end else begin
        vconv_xlim_loc_out_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        vconv_xlim_loc_read = 1'b1;
    end else begin
        vconv_xlim_loc_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln170_fu_370_p2 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b0)) & ~((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b0)))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln170_fu_370_p2 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b0)) | ((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b0)))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln170_1_fu_389_p2 = (11'd1 + col1_0_i_i_i_reg_325);

assign add_ln170_fu_375_p2 = (indvar_flatten_reg_314 + 64'd1);

assign add_ln179_10_fu_572_p2 = (add_ln179_9_fu_567_p2 + add_ln179_6_fu_559_p2);

assign add_ln179_1_fu_537_p2 = (add_ln179_fu_531_p2 + shl_ln179_3_fu_526_p2);

assign add_ln179_2_fu_543_p2 = (mul_ln179_reg_683 + mul_ln179_1_reg_688);

assign add_ln179_3_fu_547_p2 = (add_ln179_2_fu_543_p2 + shl_ln179_1_fu_515_p2);

assign add_ln179_4_fu_553_p2 = (add_ln179_3_fu_547_p2 + add_ln179_1_fu_537_p2);

assign add_ln179_5_fu_497_p2 = (mul_ln179_3_fu_461_p2 + mul_ln179_4_fu_467_p2);

assign add_ln179_6_fu_559_p2 = (add_ln179_5_reg_708 + mul_ln179_2_reg_693);

assign add_ln179_7_fu_563_p2 = (mul_ln179_5_reg_698 + mul_ln179_6_reg_703);

assign add_ln179_8_fu_503_p2 = (mul_ln179_7_fu_485_p2 + mul_ln179_8_fu_491_p2);

assign add_ln179_9_fu_567_p2 = (add_ln179_8_reg_713 + add_ln179_7_fu_563_p2);

assign add_ln179_fu_531_p2 = (shl_ln179_2_fu_521_p2 + shl_ln179_fu_509_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_pp0 = ((ap_ST_fsm_pp0_stage0 == ap_CS_fsm) & (1'b1 == ap_block_pp0_stage0_subdone));
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((vconv_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (select_ln170_1_reg_604_pp0_iter1_reg == 1'd1)) | ((hconv_V_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln170_reg_595 == 1'd0)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((vconv_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (select_ln170_1_reg_604_pp0_iter1_reg == 1'd1)) | ((hconv_V_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln170_reg_595 == 1'd0)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((vconv_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (select_ln170_1_reg_604_pp0_iter1_reg == 1'd1)) | ((hconv_V_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln170_reg_595 == 1'd0)));
end

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (vconv_xlim_loc_out_full_n == 1'b0) | (height_out_full_n == 1'b0) | (vconv_xlim_loc_empty_n == 1'b0) | (height_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign ap_block_state2_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_pp0_stage0_iter1 = ((hconv_V_empty_n == 1'b0) & (icmp_ln170_reg_595 == 1'd0));
end

always @ (*) begin
    ap_block_state4_pp0_stage0_iter2 = ((vconv_V_full_n == 1'b0) & (select_ln170_1_reg_604_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_enable_operation_37 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_39 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_41 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_43 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_45 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_47 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_49 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_51 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_53 = (icmp_ln170_fu_370_p2 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_57 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_58 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_60 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_61 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_63 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_64 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_66 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_67 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_69 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_70 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_72 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_73 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_75 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_76 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_78 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_79 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_81 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_82 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_84 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_87 = (icmp_ln170_reg_595 == 1'd0);
end

always @ (*) begin
    ap_enable_operation_93 = (icmp_ln170_reg_595_pp0_iter1_reg == 1'd0);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_enable_state2_pp0_iter0_stage0 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state3_pp0_iter1_stage0 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state4_pp0_iter2_stage0 = ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign bound_fu_355_p0 = bound_fu_355_p00;

assign bound_fu_355_p00 = vconv_xlim_loc_dout;

assign bound_fu_355_p1 = bound_fu_355_p10;

assign bound_fu_355_p10 = height_dout;

assign bound_fu_355_p2 = (bound_fu_355_p0 * bound_fu_355_p1);

assign height_out_din = height_dout;

assign icmp_ln170_fu_370_p2 = ((indvar_flatten_reg_314 == bound_reg_590) ? 1'b1 : 1'b0);

assign icmp_ln171_fu_365_p2 = (($signed(zext_ln171_fu_361_p1) < $signed(vconv_xlim_loc_read_reg_585)) ? 1'b1 : 1'b0);

assign icmp_ln183_1_fu_401_p2 = ((col1_0_i_i_i_reg_325 > 11'd9) ? 1'b1 : 1'b0);

assign icmp_ln183_fu_395_p2 = ((add_ln170_1_fu_389_p2 > 11'd9) ? 1'b1 : 1'b0);

assign linebuf_0_address0 = linebuf_0_addr_reg_613;

assign linebuf_1_address0 = zext_ln178_fu_423_p1;

assign linebuf_1_address1 = linebuf_1_addr_reg_618;

assign linebuf_2_address0 = zext_ln178_fu_423_p1;

assign linebuf_2_address1 = linebuf_2_addr_reg_624;

assign linebuf_3_address0 = zext_ln178_fu_423_p1;

assign linebuf_3_address1 = linebuf_3_addr_reg_630;

assign linebuf_4_address0 = zext_ln178_fu_423_p1;

assign linebuf_4_address1 = linebuf_4_addr_reg_636;

assign linebuf_5_address0 = zext_ln178_fu_423_p1;

assign linebuf_5_address1 = linebuf_5_addr_reg_642;

assign linebuf_6_address0 = zext_ln178_fu_423_p1;

assign linebuf_6_address1 = linebuf_6_addr_reg_648;

assign linebuf_7_address0 = zext_ln178_fu_423_p1;

assign linebuf_7_address1 = linebuf_7_addr_reg_654;

assign linebuf_8_address0 = zext_ln178_fu_423_p1;

assign linebuf_8_address1 = linebuf_8_addr_reg_660;

assign linebuf_9_address0 = zext_ln178_fu_423_p1;

assign linebuf_9_address1 = linebuf_9_addr_reg_666;

assign mul_ln179_1_fu_449_p1 = linebuf_2_q0;

assign mul_ln179_1_fu_449_p2 = ($signed({{1'b0}, {32'd266}}) * $signed(mul_ln179_1_fu_449_p1));

assign mul_ln179_2_fu_455_p1 = linebuf_3_q0;

assign mul_ln179_2_fu_455_p2 = ($signed({{1'b0}, {32'd498}}) * $signed(mul_ln179_2_fu_455_p1));

assign mul_ln179_3_fu_461_p1 = linebuf_4_q0;

assign mul_ln179_3_fu_461_p2 = ($signed({{1'b0}, {32'd724}}) * $signed(mul_ln179_3_fu_461_p1));

assign mul_ln179_4_fu_467_p1 = linebuf_5_q0;

assign mul_ln179_4_fu_467_p2 = ($signed({{1'b0}, {32'd821}}) * $signed(mul_ln179_4_fu_467_p1));

assign mul_ln179_5_fu_473_p1 = linebuf_6_q0;

assign mul_ln179_5_fu_473_p2 = ($signed({{1'b0}, {32'd724}}) * $signed(mul_ln179_5_fu_473_p1));

assign mul_ln179_6_fu_479_p1 = linebuf_7_q0;

assign mul_ln179_6_fu_479_p2 = ($signed({{1'b0}, {32'd498}}) * $signed(mul_ln179_6_fu_479_p1));

assign mul_ln179_7_fu_485_p1 = linebuf_8_q0;

assign mul_ln179_7_fu_485_p2 = ($signed({{1'b0}, {32'd266}}) * $signed(mul_ln179_7_fu_485_p1));

assign mul_ln179_8_fu_491_p1 = linebuf_9_q0;

assign mul_ln179_8_fu_491_p2 = ($signed({{1'b0}, {32'd111}}) * $signed(mul_ln179_8_fu_491_p1));

assign mul_ln179_fu_443_p1 = linebuf_1_q0;

assign mul_ln179_fu_443_p2 = ($signed({{1'b0}, {32'd111}}) * $signed(mul_ln179_fu_443_p1));

assign row_fu_437_p2 = (select_ln170_fu_381_p3 + 11'd1);

assign select_ln170_1_fu_407_p3 = ((icmp_ln171_fu_365_p2[0:0] === 1'b1) ? icmp_ln183_1_fu_401_p2 : icmp_ln183_fu_395_p2);

assign select_ln170_2_fu_415_p3 = ((icmp_ln171_fu_365_p2[0:0] === 1'b1) ? col1_0_i_i_i_reg_325 : add_ln170_1_fu_389_p2);

assign select_ln170_fu_381_p3 = ((icmp_ln171_fu_365_p2[0:0] === 1'b1) ? row2_0_i_i_i_reg_336 : 11'd0);

assign shl_ln179_1_fu_515_p2 = linebuf_0_q0 << 32'd2;

assign shl_ln179_2_fu_521_p2 = tmp_1_reg_677 << 32'd5;

assign shl_ln179_3_fu_526_p2 = tmp_1_reg_677 << 32'd2;

assign shl_ln179_fu_509_p2 = linebuf_0_q0 << 32'd5;

assign vconv_V_din = (add_ln179_10_fu_572_p2 + add_ln179_4_fu_553_p2);

assign vconv_xlim_loc_out_din = vconv_xlim_loc_dout;

assign zext_ln171_fu_361_p1 = row2_0_i_i_i_reg_336;

assign zext_ln178_fu_423_p1 = select_ln170_fu_381_p3;

endmodule //Loop_VConvH_proc
