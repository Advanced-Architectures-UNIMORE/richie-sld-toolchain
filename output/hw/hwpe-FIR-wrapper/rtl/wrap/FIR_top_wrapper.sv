
/*
 * HWPE: Francesco Conti <fconti@iis.ee.ethz.ch>
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
 * Authors:     Francesco Conti <fconti@iis.ee.ethz.ch>
 * Contribute:  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: FIR_top_wrapper.sv
 *
 */
import FIR_package::*;
import hwpe_ctrl_package::*;
module FIR_top_wrap
#(
  parameter int unsigned N_CORES = 2,
  parameter int unsigned MP  = 2,
  parameter int unsigned ID  = 10
)
(
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  (* dont_touch = "yes" *) input  logic          test_mode_i,
  // Events
  (* dont_touch = "yes" *) output logic [N_CORES-1:0][REGFILE_N_EVT-1:0] evt_o,
  // TCDM master ports
  (* dont_touch = "yes" *) output logic [MP-1:0]                         tcdm_req,
  (* dont_touch = "yes" *) input  logic [MP-1:0]                         tcdm_gnt,
  (* dont_touch = "yes" *) output logic [MP-1:0][31:0]                   tcdm_add,
  (* dont_touch = "yes" *) output logic [MP-1:0]                         tcdm_wen,
  (* dont_touch = "yes" *) output logic [MP-1:0][3:0]                    tcdm_be,
  (* dont_touch = "yes" *) output logic [MP-1:0][31:0]                   tcdm_data,
  (* dont_touch = "yes" *) input  logic [MP-1:0][31:0]                   tcdm_r_data,
  (* dont_touch = "yes" *) input  logic [MP-1:0]                         tcdm_r_valid,
  // Peripheral slave port
  (* dont_touch = "yes" *) input  logic                                  periph_req,
  (* dont_touch = "yes" *) output logic                                  periph_gnt,
  (* dont_touch = "yes" *) input  logic         [31:0]                   periph_add,
  (* dont_touch = "yes" *) input  logic                                  periph_wen,
  (* dont_touch = "yes" *) input  logic         [3:0]                    periph_be,
  (* dont_touch = "yes" *) input  logic         [31:0]                   periph_data,
  (* dont_touch = "yes" *) input  logic       [ID-1:0]                   periph_id,
  (* dont_touch = "yes" *) output logic         [31:0]                   periph_r_data,
  (* dont_touch = "yes" *) output logic                                  periph_r_valid,
  (* dont_touch = "yes" *) output logic       [ID-1:0]                   periph_r_id
);
  hwpe_stream_intf_tcdm tcdm[MP-1:0] (
    .clk ( clk_i )
  );
  hwpe_ctrl_intf_periph #(
    .ID_WIDTH ( ID )
  ) periph (
    .clk ( clk_i )
  );
  // bindings
  generate
    for(genvar ii=0; ii<MP; ii++) begin: tcdm_binding
      assign tcdm_req  [ii] = tcdm[ii].req;
      assign tcdm_add  [ii] = tcdm[ii].add;
      assign tcdm_wen  [ii] = tcdm[ii].wen;
      assign tcdm_be   [ii] = tcdm[ii].be;
      assign tcdm_data [ii] = tcdm[ii].data;
      assign tcdm[ii].gnt     = tcdm_gnt     [ii];
      assign tcdm[ii].r_data  = tcdm_r_data  [ii];
      assign tcdm[ii].r_valid = tcdm_r_valid [ii];
    end
  endgenerate
  always_comb
  begin
    periph.req  = periph_req;
    periph.add  = periph_add;
    periph.wen  = periph_wen;
    periph.be   = periph_be;
    periph.data = periph_data;
    periph.id   = periph_id;
    periph_gnt     = periph.gnt;
    periph_r_data  = periph.r_data;
    periph_r_valid = periph.r_valid;
    periph_r_id    = periph.r_id;
  end
  FIR_top #(
    .N_CORES ( N_CORES ),
    .MP      ( MP      ),
    .ID      ( ID      )
  ) i_FIR_top (
    .clk_i       ( clk_i       ),
    .rst_ni      ( rst_ni      ),
    .test_mode_i ( test_mode_i ),
    .evt_o       ( evt_o       ),
    .tcdm        ( tcdm        ),
    .periph      ( periph      )
  );
  endmodule