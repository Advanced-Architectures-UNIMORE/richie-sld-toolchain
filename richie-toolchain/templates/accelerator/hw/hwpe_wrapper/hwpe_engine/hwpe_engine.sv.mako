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

    Description:    HWPE engine.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/*
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
 * Module: ${acc_wr_target}_engine.sv
 *
 */

import ${acc_wr_target}_package::*;

module ${acc_wr_target}_engine (\

  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,

  ${streaming_engine_intf()}

  // Control channel
  input  ctrl_engine_${acc_wr_target}_t            ctrl_i,
  output flags_engine_${acc_wr_target}_t           flags_o
);

  <%
  # Re-map control and flags in case the datapath interface
  # is built exploting specific design methodologies.
  %>

  % if acc_wr_design_type == 'hls':
  ${map_engine_ctrl_v1_hls()}
  ${map_engine_flags_v1_hls()}
  % endif

  <%
  # Instantiate blocks to count the outputs and feedback
  # the FSM unit about the state of engine operations.
  %>

  /* Count outputs */

  ${out_track_decl()}
  ${cnt_out_decl()}

  ${out_track_impl_DtypeFF()}
  ${cnt_out_FF_impl()}

  ${cnt_out_assign_to_fsm()}

  <%
  # Instantiate datapath adapter. This layer is to
  # flexibly acc_wr_target different type of datapaths that
  # may be designed with HDL, HLS, etc.
  %>

  /* Datapath adapter */

  ${acc_wr_target}_datapath_adapter i_${acc_wr_target}_adapter (

    // Global signals
    .clk_i           ( clk_i            ),
    .rst_ni          ( rst_ni           ),
    .test_mode_i     ( test_mode_i      ),

    <%
    # Data streams
    %>

    ${streaming_datapath_adapter_intf()}

    <%
    ##################################################
    ## Datapath adapater interface -> PULP standard ##
    ##################################################
    %>

    % if acc_wr_design_type == 'hdl':
    ${pulp_std_datapath_adapter_ctrl()}
    ${pulp_std_datapath_adapter_flags()}
    % endif

    <%
    #######################################################################
    ## Datapath adapater interface -> Xilinx ap_ctrl_hs (refer to UG902) ##
    #######################################################################
    %>

    % if acc_wr_design_type == 'hls':
      % if acc_wr_is_ap_ctrl_hs == True:
    ${xil_ap_ctrl_hs_datapath_adapter_custom_regs()}
    ${xil_ap_ctrl_hs_datapath_adapter_ctrl()}
    ${xil_ap_ctrl_hs_datapath_adapter_flags()}
      % endif
    % endif

    <%
    ##################################################
    ## Datapath adapater interface -> MDC dataflow  ##
    ##################################################
    %>

    % if acc_wr_design_type == 'hls':
      % if acc_wr_is_mdc_dataflow == True:
    ${mdc_dataflow_datapath_adapter_custom_regs()}
    ${mdc_dataflow_datapath_adapter_ctrl()}
    ${mdc_dataflow_datapath_adapter_flags()}
      % endif
    % endif

    <%
    #############################################################
    ## Datapath adapter interface -> Xilinx hls::stream object ##
    #############################################################
    %>

    % if acc_wr_design_type == 'hls':
      % if acc_wr_is_hls_stream == True:
    ${xil_hls_stream_datapath_adapter_custom_regs()}
    ${xil_hls_stream_datapath_adapter_ctrl()}
    ${xil_hls_stream_datapath_adapter_flags()}
      % endif
    % endif

  );

  % if acc_wr_is_hls_stream == False:
  // At the moment output strobe is always '1
  // All bytes of output streams are written
  // to TCDM
  always_comb
  begin
    % for j in range (acc_wr_n_source):
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
    ${acc_wr_stream_out[j]}_${k}_o.strb = '1;
        % endfor
      % else:
    ${acc_wr_stream_out[j]}_o.strb = '1;
      % endif
    % endfor
  end
  % endif

endmodule\

