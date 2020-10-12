// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module computeRay (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        p_distMap_address0,
        p_distMap_ce0,
        p_distMap_q0,
        orig_x,
        orig_y,
        ray,
        x,
        y,
        map_width,
        map_height,
        map_resolution,
        maxRange,
        ap_return
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [17:0] p_distMap_address0;
output   p_distMap_ce0;
input  [31:0] p_distMap_q0;
input  [31:0] orig_x;
input  [31:0] orig_y;
input  [10:0] ray;
input  [31:0] x;
input  [31:0] y;
input  [31:0] map_width;
input  [31:0] map_height;
input  [31:0] map_resolution;
input  [31:0] maxRange;
output  [31:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg p_distMap_ce0;
reg[31:0] ap_return;

(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [0:0] icmp_ln35_fu_174_p2;
reg   [0:0] icmp_ln35_reg_363;
wire   [0:0] icmp_ln46_fu_268_p2;
reg   [0:0] icmp_ln46_reg_372;
wire   [0:0] icmp_ln46_1_fu_274_p2;
reg   [0:0] icmp_ln46_1_reg_377;
reg   [31:0] p_distMap_load_reg_382;
wire    ap_CS_fsm_state2;
wire   [0:0] or_ln46_fu_307_p2;
reg   [0:0] or_ln46_reg_387;
wire   [8:0] k_fu_319_p2;
wire    ap_CS_fsm_state3;
wire   [31:0] acc_fu_325_p2;
wire   [0:0] icmp_ln39_fu_313_p2;
reg   [31:0] out_reg_139;
reg   [8:0] k_0_reg_151;
wire   [31:0] select_ln77_fu_336_p3;
reg   [31:0] ap_phi_mux_p_0_phi_fu_167_p4;
reg   [31:0] p_0_reg_163;
wire    ap_CS_fsm_state4;
wire  signed [63:0] sext_ln49_fu_256_p1;
wire   [31:0] sub_ln43_fu_180_p2;
wire   [11:0] trunc_ln43_fu_186_p1;
wire   [13:0] trunc_ln43_1_fu_198_p1;
wire   [15:0] shl_ln_fu_190_p3;
wire   [15:0] shl_ln43_1_fu_202_p3;
wire   [15:0] c_fu_210_p2;
wire   [15:0] trunc_ln44_1_fu_224_p1;
wire   [15:0] trunc_ln44_fu_220_p1;
wire   [15:0] add_ln44_fu_228_p2;
wire   [15:0] shl_ln44_fu_234_p2;
wire   [15:0] shl_ln44_1_fu_240_p2;
wire   [15:0] r_fu_246_p2;
wire   [18:0] grp_fu_344_p3;
wire   [31:0] zext_ln46_1_fu_264_p1;
wire   [31:0] zext_ln46_fu_260_p1;
wire   [0:0] icmp_ln46_2_fu_290_p2;
wire   [0:0] xor_ln46_fu_280_p2;
wire   [0:0] xor_ln46_2_fu_295_p2;
wire   [0:0] or_ln46_1_fu_301_p2;
wire   [0:0] xor_ln46_1_fu_285_p2;
wire   [0:0] icmp_ln77_fu_330_p2;
wire   [9:0] grp_fu_344_p0;
wire   [15:0] grp_fu_344_p1;
wire   [15:0] grp_fu_344_p2;
reg   [31:0] ap_return_preg;
reg   [3:0] ap_NS_fsm;
wire   [18:0] grp_fu_344_p10;
wire   [18:0] grp_fu_344_p20;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
#0 ap_return_preg = 32'd0;
end

rayMarching_mac_mbkb #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 16 ),
    .din2_WIDTH( 16 ),
    .dout_WIDTH( 19 ))
rayMarching_mac_mbkb_U23(
    .din0(grp_fu_344_p0),
    .din1(grp_fu_344_p1),
    .din2(grp_fu_344_p2),
    .dout(grp_fu_344_p3)
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
        ap_return_preg <= 32'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state4)) begin
            ap_return_preg <= ap_phi_mux_p_0_phi_fu_167_p4;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        k_0_reg_151 <= 9'd0;
    end else if (((icmp_ln39_fu_313_p2 == 1'd0) & (or_ln46_reg_387 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        k_0_reg_151 <= k_fu_319_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        out_reg_139 <= 32'd0;
    end else if (((icmp_ln39_fu_313_p2 == 1'd0) & (or_ln46_reg_387 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        out_reg_139 <= acc_fu_325_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start == 1'b1) & (icmp_ln35_fu_174_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1))) begin
        p_0_reg_163 <= 32'd0;
    end else if (((icmp_ln35_reg_363 == 1'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        p_0_reg_163 <= select_ln77_fu_336_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        icmp_ln35_reg_363 <= icmp_ln35_fu_174_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start == 1'b1) & (icmp_ln35_fu_174_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        icmp_ln46_1_reg_377 <= icmp_ln46_1_fu_274_p2;
        icmp_ln46_reg_372 <= icmp_ln46_fu_268_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        or_ln46_reg_387 <= or_ln46_fu_307_p2;
        p_distMap_load_reg_382 <= p_distMap_q0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
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
    if (((icmp_ln35_reg_363 == 1'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_phi_fu_167_p4 = select_ln77_fu_336_p3;
    end else begin
        ap_phi_mux_p_0_phi_fu_167_p4 = p_0_reg_163;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_return = ap_phi_mux_p_0_phi_fu_167_p4;
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        p_distMap_ce0 = 1'b1;
    end else begin
        p_distMap_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (icmp_ln35_fu_174_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else if (((ap_start == 1'b1) & (icmp_ln35_fu_174_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((icmp_ln39_fu_313_p2 == 1'd0) & (or_ln46_reg_387 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign acc_fu_325_p2 = (p_distMap_load_reg_382 + out_reg_139);

assign add_ln44_fu_228_p2 = (trunc_ln44_1_fu_224_p1 + trunc_ln44_fu_220_p1);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign c_fu_210_p2 = (shl_ln_fu_190_p3 + shl_ln43_1_fu_202_p3);

assign grp_fu_344_p0 = 19'd485;

assign grp_fu_344_p1 = grp_fu_344_p10;

assign grp_fu_344_p10 = r_fu_246_p2;

assign grp_fu_344_p2 = grp_fu_344_p20;

assign grp_fu_344_p20 = c_fu_210_p2;

assign icmp_ln35_fu_174_p2 = ((ray > 11'd1081) ? 1'b1 : 1'b0);

assign icmp_ln39_fu_313_p2 = ((k_0_reg_151 == 9'd300) ? 1'b1 : 1'b0);

assign icmp_ln46_1_fu_274_p2 = (($signed(zext_ln46_fu_260_p1) < $signed(map_height)) ? 1'b1 : 1'b0);

assign icmp_ln46_2_fu_290_p2 = (($signed(map_resolution) < $signed(p_distMap_q0)) ? 1'b1 : 1'b0);

assign icmp_ln46_fu_268_p2 = (($signed(zext_ln46_1_fu_264_p1) < $signed(map_width)) ? 1'b1 : 1'b0);

assign icmp_ln77_fu_330_p2 = ((k_0_reg_151 < 9'd300) ? 1'b1 : 1'b0);

assign k_fu_319_p2 = (k_0_reg_151 + 9'd1);

assign or_ln46_1_fu_301_p2 = (xor_ln46_fu_280_p2 | xor_ln46_2_fu_295_p2);

assign or_ln46_fu_307_p2 = (xor_ln46_1_fu_285_p2 | or_ln46_1_fu_301_p2);

assign p_distMap_address0 = sext_ln49_fu_256_p1;

assign r_fu_246_p2 = (shl_ln44_fu_234_p2 + shl_ln44_1_fu_240_p2);

assign select_ln77_fu_336_p3 = ((icmp_ln77_fu_330_p2[0:0] === 1'b1) ? out_reg_139 : maxRange);

assign sext_ln49_fu_256_p1 = $signed(grp_fu_344_p3);

assign shl_ln43_1_fu_202_p3 = {{trunc_ln43_1_fu_198_p1}, {2'd0}};

assign shl_ln44_1_fu_240_p2 = add_ln44_fu_228_p2 << 16'd2;

assign shl_ln44_fu_234_p2 = add_ln44_fu_228_p2 << 16'd4;

assign shl_ln_fu_190_p3 = {{trunc_ln43_fu_186_p1}, {4'd0}};

assign sub_ln43_fu_180_p2 = (orig_x - x);

assign trunc_ln43_1_fu_198_p1 = sub_ln43_fu_180_p2[13:0];

assign trunc_ln43_fu_186_p1 = sub_ln43_fu_180_p2[11:0];

assign trunc_ln44_1_fu_224_p1 = y[15:0];

assign trunc_ln44_fu_220_p1 = orig_y[15:0];

assign xor_ln46_1_fu_285_p2 = (icmp_ln46_1_reg_377 ^ 1'd1);

assign xor_ln46_2_fu_295_p2 = (icmp_ln46_2_fu_290_p2 ^ 1'd1);

assign xor_ln46_fu_280_p2 = (icmp_ln46_reg_372 ^ 1'd1);

assign zext_ln46_1_fu_264_p1 = c_fu_210_p2;

assign zext_ln46_fu_260_p1 = r_fu_246_p2;

endmodule //computeRay
