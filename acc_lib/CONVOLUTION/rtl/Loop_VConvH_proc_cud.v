// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2_AR72614 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module Loop_VConvH_proc_cud_ram (addr0, ce0, q0, addr1, ce1, d1, we1,  clk);

parameter DWIDTH = 32;
parameter AWIDTH = 11;
parameter MEM_SIZE = 1920;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input[AWIDTH-1:0] addr1;
input ce1;
input[DWIDTH-1:0] d1;
input we1;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("./Loop_VConvH_proc_cud_ram.dat", ram);
end



always @(posedge clk)  
begin 
    if (ce0) begin
        q0 <= ram[addr0];
    end
end


always @(posedge clk)  
begin 
    if (ce1) begin
        if (we1) 
            ram[addr1] <= d1; 
    end
end


endmodule

`timescale 1 ns / 1 ps
module Loop_VConvH_proc_cud(
    reset,
    clk,
    address0,
    ce0,
    q0,
    address1,
    ce1,
    we1,
    d1);

parameter DataWidth = 32'd32;
parameter AddressRange = 32'd1920;
parameter AddressWidth = 32'd11;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;
input[AddressWidth - 1:0] address1;
input ce1;
input we1;
input[DataWidth - 1:0] d1;



Loop_VConvH_proc_cud_ram Loop_VConvH_proc_cud_ram_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ),
    .addr1( address1 ),
    .ce1( ce1 ),
    .we1( we1 ),
    .d1( d1 ));

endmodule

