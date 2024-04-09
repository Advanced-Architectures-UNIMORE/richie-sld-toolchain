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

    Description:    HWPE kernel adapter.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

/* =====================================================================
 *
 * Copyright (C) 2021 University of Modena and Reggio Emilia
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * =====================================================================
 *
 * Project:         Richie
 *
 * Title:           ${target}_kernel_adapter.sv
 *
 * Description:     Interface to the accelerator datapath. It can be tailored
 *                  a variety of accelerator standards and protocols, e.g. PULP, 
 *                  HLS, CAPH, etc.
 *
 * Date:            11.6.2021
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

import ${target}_package::*;

module ${target}_kernel_adapter (\

  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,

  ${streaming_kernel_adapter_intf()}

  % if custom_reg_num > 0:
  // Kernel parameters
    % for i in range (custom_reg_num):
  input logic [${custom_reg_dim[i]-1}:0] ${custom_reg_name[i]},
    % endfor
  % endif

  <%
  ###############################################
  ## Kernel adapter interface -> PULP standard ##
  ###############################################
  %>

  % if design_type == 'hdl':
  ${pulp_std_engine_ctrl()}
  ${pulp_std_engine_flags()}
  % endif

  <%
  ####################################################################
  ## Kernel adapter interface -> Xilinx ap_ctrl_hs (refer to UG902) ##
  ####################################################################
  %>

  % if design_type == 'hls':
    % if is_ap_ctrl_hs == True:
  ${xil_ap_ctrl_hs_engine_ctrl()}
  ${xil_ap_ctrl_hs_engine_flags()}
    % endif
  % endif

  <%
  ###############################################
  ## Kernel adapter interface -> MDC dataflow  ##
  ###############################################
  %>

  % if design_type == 'hls':
    % if is_mdc_dataflow == True:
  ${mdc_dataflow_engine_ctrl()}
  ${mdc_dataflow_engine_flags()}
    % endif
  % endif

  <%
  ###########################################################
  ## Kernel adapter interface -> Xilinx hls::stream object ##
  ###########################################################
  %>

  % if design_type == 'hls':
    % if is_hls_stream == True:
  ${xil_hls_stream_engine_ctrl()}
  ${xil_hls_stream_engine_flags()}
    % endif
  % endif

);

  <%
  #######################################
  ## Kernel interface -> PULP standard ##
  #######################################
  %>

  % if design_type == 'hdl':
  ${pulp_std_kernel_intf()}
  % endif

  <%
  ############################################################
  ## Kernel interface -> Xilinx ap_ctrl_hs (refer to UG902) ##
  ############################################################
  %>

  % if design_type == 'hls':
    % if is_ap_ctrl_hs == True:
  ${xil_ap_ctrl_hs_kernel_ctrl()}
  ${xil_ap_ctrl_hs_kernel_flags()}
  ${xil_ap_ctrl_hs_kernel_intf()}
  ${xil_ap_ctrl_hs_stream_strobes()}
    % endif
  % endif

  <%
  #######################################
  ## Kernel interface -> MDC dataflow  ##
  #######################################
  %>

  % if design_type == 'hls':
    % if is_mdc_dataflow == True:
  ${mdc_dataflow_kernel_ctrl()}
  ${mdc_dataflow_kernel_flags()}
  ${mdc_dataflow_counter_in()}
  ${mdc_dataflow_counter_out()}
  ${mdc_dataflow_kernel_intf()}
  ${mdc_dataflow_stream_strobes()}
    % endif
  % endif

  <%
  ###################################################
  ## Kernel interface -> Xilinx hls::stream object ##
  ###################################################
  %>

  % if design_type == 'hls':
    % if is_hls_stream == True:
  ${xil_hls_stream_stream_dwidth_match_def()}
  ${xil_hls_stream_kernel_ctrl_def()}
  ${xil_hls_stream_kernel_flags_def()}
  ${xil_hls_stream_stream_strobes_def()}

  ${xil_hls_stream_stream_dwidth_match()}
  ${xil_hls_stream_kernel_ctrl()}
  ${xil_hls_stream_kernel_flags()}
  ${xil_hls_stream_stream_strobes()}

  ${xil_hls_stream_kernel_intf()}
    % endif
  % endif

endmodule\

