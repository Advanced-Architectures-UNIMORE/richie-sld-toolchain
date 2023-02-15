// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2.1 (64-bit)
// Version: 2022.2.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module color_detect_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2_void_bgr2hsv_Mcud (
    address0, ce0, q0, 
    reset, clk);

parameter DataWidth = 32;
parameter AddressWidth = 8;
parameter AddressRange = 256;
 
input[AddressWidth-1:0] address0;
input ce0;
output reg[DataWidth-1:0] q0;

input reset;
input clk;

 
reg [DataWidth-1:0] rom0[0:AddressRange-1];


initial begin
     
    $readmemh("./color_detect_bgr2hsv_9_128_128_1_Pipeline_VITIS_LOOP_128_1_VITIS_LOOP_132_2_void_bgr2hsv_Mcud.dat", rom0);
end

  
always @(posedge clk) 
begin 
    if (ce0) 
    begin
        q0 <= rom0[address0];
    end
end


endmodule

