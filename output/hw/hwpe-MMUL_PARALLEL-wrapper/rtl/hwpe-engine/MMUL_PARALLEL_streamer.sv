
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
 * Authors:     Francesco Conti <fconti@iis.ee.ethz.ch>
 * Contribute:  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: MMUL_PARALLEL_streamer.sv
 *
 */
import MMUL_PARALLEL_package::*;
import hwpe_stream_package::*;
module MMUL_PARALLEL_streamer
#(
  parameter int unsigned MP  = 3, // number of master ports
  parameter int unsigned FD  = 2 // FIFO depth
)
(
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,
  // Local enable & clear
  input  logic          enable_i,
  input  logic          clear_i,
  // Streaming interfaces
  hwpe_stream_intf_stream.source in1,
  hwpe_stream_intf_stream.source in2,
  hwpe_stream_intf_stream.sink out_r,
  // TCDM ports
  hwpe_stream_intf_tcdm.master tcdm [MP-1:0],
  // control channel
  input  ctrl_streamer_t  ctrl_i,
  output flags_streamer_t flags_o
);
  // FIFO ready signals
  logic  in1_tcdm_fifo_ready,   in2_tcdm_fifo_ready;
  // Pre-FIFO streamer interfaces (TCDM-side)
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_prefifo ( .clk (clk_i) );
  // Post-FIFO streamer interfaces (TCDM-side)
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) out_r_postfifo ( .clk (clk_i) );
  // FIFO interfaces
  hwpe_stream_intf_tcdm tcdm_fifo [MP-1:0] ( .clk ( clk_i ) );
  hwpe_stream_intf_tcdm tcdm_fifo_0 [0:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_1 [0:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_2 [0:0] ( .clk (clk_i) );
  // Source modules (TCDM -> HWPE)
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
    // .NB_TCDM_PORTS (    )
  ) i_in1_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
    // .NB_TCDM_PORTS (    )
  ) i_in2_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  // Sink modules (TCDM <- HWPE)
  hwpe_stream_sink #(
    .DATA_WIDTH ( 32 )
    // .NB_TCDM_PORTS (    )
  ) i_out_r_sink (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_2            ),
    .stream             ( out_r_postfifo.sink       ),
    .ctrl_i             ( ctrl_i.out_r_sink_ctrl   ),
    .flags_o            ( flags_o.out_r_sink_flags )
  );
  // TCDM-side FIFOs (TCDM -> HWPE)
  hwpe_stream_tcdm_fifo_load #(
    .FIFO_DEPTH ( 4 )
  ) i_in1_tcdm_fifo_load (
    .clk_i       ( clk_i             ),
    .rst_ni      ( rst_ni            ),
    .clear_i     ( clear_i           ),
    .flags_o     (                   ),
    .ready_i     ( in1_tcdm_fifo_ready ),
    .tcdm_slave  ( tcdm_fifo_0[0]    ),
    .tcdm_master ( tcdm      [0]     )
  );
  hwpe_stream_tcdm_fifo_load #(
    .FIFO_DEPTH ( 4 )
  ) i_in2_tcdm_fifo_load (
    .clk_i       ( clk_i             ),
    .rst_ni      ( rst_ni            ),
    .clear_i     ( clear_i           ),
    .flags_o     (                   ),
    .ready_i     ( in2_tcdm_fifo_ready ),
    .tcdm_slave  ( tcdm_fifo_1[0]    ),
    .tcdm_master ( tcdm      [1]     )
  );
  // TCDM-side FIFOs (TCDM <- HWPE)
  hwpe_stream_tcdm_fifo_store #(
    .FIFO_DEPTH ( 4 )
  ) i_out_r_tcdm_fifo_store (
    .clk_i       ( clk_i          ),
    .rst_ni      ( rst_ni         ),
    .clear_i     ( clear_i        ),
    .flags_o     (                ),
    .tcdm_slave  ( tcdm_fifo_2[0] ),
    .tcdm_master ( tcdm       [2] )
  );
  // Datapath-side FIFOs (TCDM -> HWPE)
  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_in1_fifo (
    .clk_i   ( clk_i          ),
    .rst_ni  ( rst_ni         ),
    .clear_i ( clear_i        ),
    .push_i  ( in1_prefifo.sink ),
    .pop_o   ( in1_o            ),
    .flags_o (                )
  );
  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_in2_fifo (
    .clk_i   ( clk_i          ),
    .rst_ni  ( rst_ni         ),
    .clear_i ( clear_i        ),
    .push_i  ( in2_prefifo.sink ),
    .pop_o   ( in2_o            ),
    .flags_o (                )
  );
  // Datapath-side FIFOs (TCDM <- HWPE)
  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_out_r_fifo (
    .clk_i   ( clk_i             ),
    .rst_ni  ( rst_ni            ),
    .clear_i ( clear_i           ),
    .push_i  ( out_r_i               ),
    .pop_o   ( out_r_postfifo.source ),
    .flags_o (                   )
  );
endmodule