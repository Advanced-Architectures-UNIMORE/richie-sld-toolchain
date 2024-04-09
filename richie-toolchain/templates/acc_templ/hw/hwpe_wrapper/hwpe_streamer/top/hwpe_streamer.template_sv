<%
'''
    =====================================================================

    Copyright (C) 2021 University of Modena and Reggio Emilia

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

    Description:    HWPE streamer.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

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
 * Author: Francesco Conti <fconti@iis.ee.ethz.ch>
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: ${target}_streamer.sv
 * 
 */

import ${target}_package::*;
import hwpe_stream_package::*;

module ${target}_streamer
#(
  parameter int unsigned MP  = ${n_tcdm_ports}, // number of master ports
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

  <%
  ####################
  ## TCDM interface ##
  ####################
  %>

  ${ tcdm_intf() }

  <%
  #########################
  ## Streaming interface ##
  #########################
  %>

  ${ streaming_intf() }

  // control channel
  input  ctrl_streamer_${target}_t  ctrl_i,
  output flags_streamer_${target}_t flags_o
);

  <%
  ############################
  ## Interfaces and signals ##
  ############################
  %>

  ${ fifo_tcdm_ready_signs() }
  ${ fifo_tcdm_intf_post_fifo() }
  ${ fifo_stream_intf_pre_fifo() }
  
  <%
  ##########
  ## FIFO ##
  ##########
  %>

  ${ fifo_tcdm_side() }
  ${ fifo_engine_side() }

  <%
  #######################
  ## Streaming modules ##
  #######################
  %>

  ${ streaming_source_sink()}

endmodule\

