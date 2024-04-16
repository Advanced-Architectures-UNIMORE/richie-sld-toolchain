<%
'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    =====================================================================

    Project:        Richie Toolchain

    Title:          Template

    Description:    HeSoC peripherals.

    Date:           13.1.2022

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/*
 * Copyright (c) 2019 ETH Zurich, University of Bologna.
 * All rights reserved.
 *
 * This code is under development and not yet released to the public.
 * Until it is released, the code is under the copyright of ETH Zurich and
 * the University of Bologna, and may contain confidential and/or unpublished
 * work. Any reuse/redistribution is strictly forbidden without written
 * permission from ETH Zurich.
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: hesoc_peripherals.sv
 *
 */

module hesoc_peripherals #(
  parameter int unsigned  AXI_AW      = 0,
  parameter int unsigned  AXI_IW      = 0,
  parameter int unsigned  AXI_UW      = 0,
  parameter int unsigned  N_CORES     = 0,
  parameter int unsigned  N_CLUSTERS  = 0
) (
  input  logic  clk_i,
  input  logic  rst_ni,

  input  logic  test_en_i,

  AXI_BUS.Slave axi
);

  localparam int unsigned APB_AW  = 32;
  localparam int unsigned APB_DW  = 32;
  localparam int unsigned AXI_DW  = 64;

  APB_BUS #(
    .APB_ADDR_WIDTH (APB_AW),
    .APB_DATA_WIDTH (APB_DW)
  ) apb ();

  axi2apb_wrap #(
    .AXI_ADDR_WIDTH   (AXI_AW),
    .AXI_DATA_WIDTH   (AXI_DW),
    .AXI_ID_WIDTH     (AXI_IW),
    .AXI_USER_WIDTH   (AXI_UW),
    .APB_ADDR_WIDTH   (APB_AW),
    .APB_DATA_WIDTH   (APB_DW)
  ) i_axi2apb (
    .clk_i,
    .rst_ni,
    .test_en_i,
    .axi_slave  (axi),
    .apb_master (apb)
  );

  APB_BUS #(
    .APB_ADDR_WIDTH (APB_AW),
    .APB_DATA_WIDTH (APB_DW)
  ) apb_periphs[1:0] ();

  apb_bus_wrap #(
    .ADDR_WIDTH (APB_AW),
    .DATA_WIDTH (APB_DW),
    .N_SLV      (2),
    .ADDR_BEGIN ({32'h1A10_4000, 32'h1A10_3000}),
    .ADDR_END   ({32'h1A10_4FFF, 32'h1A10_3FFF})
  ) i_bus (
    .inp  (apb),
    .oup  (apb_periphs)
  );

  `ifndef TARGET_SYNTHESIS
    apb_stdout #(
      .N_CORES    (N_CORES),
      .N_CLUSTERS (N_CLUSTERS),
      .ADDR_WIDTH (APB_AW),
      .DATA_WIDTH (APB_DW)
    ) i_stdout (
      .clk_i,
      .rst_ni,
      .apb  (apb_periphs[1])
    );
  `else
    assign apb_periphs[1].pready = 1'b1;
    assign apb_periphs[1].pslverr = 1'b1;
    assign apb_periphs[1].prdata = '0;
  `endif

  hesoc_ctrl_regs #(
    .N_CORES    (N_CORES),
    .N_CLUSTERS (N_CLUSTERS),
    .ADDR_WIDTH (APB_AW),
    .DATA_WIDTH (APB_DW)
  ) i_hesoc_ctrl_regs (
    .clk_i,
    .rst_ni,
    .apb    (apb_periphs[0])
  );

endmodule
