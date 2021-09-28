
//
/*
 *
 * Copyright (C) 2018 ETH Zurich, University of Bologna
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * HWPE author: Francesco Conti <fconti@iis.ee.ethz.ch>
 * HWPE specialization tool: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: pulp_hwpe_wrap.sv
 *
 */
module pulp_hwpe_wrap
#(
  parameter N_CORES = 2,
  parameter N_HWPE = 2,
  parameter N_DMA = 4,
  parameter N_EXT = 4,
  parameter N_MEM = 16,
  parameter N_MASTER_PORT = 4,
  parameter ID_WIDTH = 8,
  parameter DEFAULT_DW = 32,
  parameter DEFAULT_AW = 32,
  parameter DEFAULT_BW = 8,
  parameter DEFAULT_WW = 10,
  parameter AWH = DEFAULT_AW
)
(
  input  logic                        clk,
  input  logic                        rst_n,
  input  logic                        test_mode,
  XBAR_TCDM_BUS.Master                hwacc_xbar_master[N_MASTER_PORT-1:0],
  XBAR_PERIPH_BUS.Slave               hwacc_cfg_slave,
  output logic [N_CORES-1:0][1:0]     evt_o,
  output logic                        busy_o
);
  logic [N_MASTER_PORT-1:0]           tcdm_req;
  logic [N_MASTER_PORT-1:0]           tcdm_gnt;
  logic [N_MASTER_PORT-1:0] [32-1:0]  tcdm_add;
  logic [N_MASTER_PORT-1:0]           tcdm_type;
  logic [N_MASTER_PORT-1:0] [4 -1:0]  tcdm_be;
  logic [N_MASTER_PORT-1:0] [32-1:0]  tcdm_wdata;
  logic [N_MASTER_PORT-1:0] [32-1:0]  tcdm_r_rdata;
  logic [N_MASTER_PORT-1:0]           tcdm_r_valid;
  mmul_parallel_top_wrap #(
    .N_CORES          ( N_CORES ),
    .MP               ( N_MASTER_PORT ),
    .ID               ( ID_WIDTH )
  ) i_hwpe_top_wrap (
    .clk_i          ( clk                       ),
    .rst_ni         ( rst_n                     ),
    .test_mode_i    ( test_mode                 ),
    .tcdm_add       ( tcdm_add                  ), // address
    .tcdm_be        ( tcdm_be                   ), // byte enable
    .tcdm_data      ( tcdm_wdata                ), // write data
    .tcdm_gnt       ( tcdm_gnt                  ), // grant
    .tcdm_wen       ( tcdm_type                 ), // write enable
    .tcdm_req       ( tcdm_req                  ), // request
    .tcdm_r_data    ( tcdm_r_rdata              ), // read data
    .tcdm_r_valid   ( tcdm_r_valid              ), // read valid
    .periph_add     ( hwacc_cfg_slave.add       ),  // address
    .periph_be      ( hwacc_cfg_slave.be        ),  // byte enable
    .periph_data    ( hwacc_cfg_slave.wdata     ),  // write data
    .periph_gnt     ( hwacc_cfg_slave.gnt       ),  // grant
    .periph_wen     ( hwacc_cfg_slave.wen       ),  // write enable
    .periph_req     ( hwacc_cfg_slave.req       ),  // request
    .periph_id      ( hwacc_cfg_slave.id        ),  // write id
    .periph_r_data  ( hwacc_cfg_slave.r_rdata   ),  // read data
    .periph_r_valid ( hwacc_cfg_slave.r_valid   ),  // read valid
    .periph_r_id    ( hwacc_cfg_slave.r_id      ),  // read id
    .evt_o          ( evt_o                     )   // event
  );
  assign busy_o = 1'b1;
  genvar i;
  generate
    for (i=0;i<N_MASTER_PORT;i++) begin : hwacc_binding
      assign hwacc_xbar_master[i].req   = tcdm_req   [i];
      assign hwacc_xbar_master[i].add   = tcdm_add   [i];
      assign hwacc_xbar_master[i].wen   = tcdm_type  [i];
      assign hwacc_xbar_master[i].wdata = tcdm_wdata [i];
      assign hwacc_xbar_master[i].be    = tcdm_be    [i];
      // response channel
      assign tcdm_gnt     [i] = hwacc_xbar_master[i].gnt;
      assign tcdm_r_rdata [i] = hwacc_xbar_master[i].r_rdata;
      assign tcdm_r_valid [i] = hwacc_xbar_master[i].r_valid;
    end
  endgenerate
endmodule