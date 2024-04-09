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

<%
###########################################################
## Kernel interface - Xilinx ap_ctrl_hs (refer to UG902) ##
###########################################################
%>

<%
########################################
## Kernel interface - Kernel controls ##
########################################
%>

<%def name="xil_ap_ctrl_hs_kernel_ctrl()">\

</%def>

<%
#####################################
## Kernel interface - Kernel flags ##
#####################################
%>

<%def name="xil_ap_ctrl_hs_kernel_flags()">\

</%def>

<%
###########################################################
## Kernel interface - Xilinx ap_ctrl_hs kernel interface ##
###########################################################
%>

<%def name="xil_ap_ctrl_hs_kernel_intf()">\

  /* ${target} kernel interface. */

  ${target} i_${target} (
    // Global signals.
    .ap_clk       ( clk_i            ),
    .ap_rst_n     ( rst_ni           ),

    // Sink ports
    % for i in range (n_sink):
      % if (is_parallel_in[i]):
        % for k in range (in_parallelism_factor[i]):
    .${stream_in[i]}_${k}_TDATA  ( ${stream_in[i]}_${k}_i.data  ),
    .${stream_in[i]}_${k}_TVALID ( ${stream_in[i]}_${k}_i.valid ),
    .${stream_in[i]}_${k}_TREADY ( ${stream_in[i]}_${k}_i.ready ),
        % endfor
      % else:
    .${stream_in[i]}_TDATA  ( ${stream_in[i]}_i.data  ),
    .${stream_in[i]}_TVALID ( ${stream_in[i]}_i.valid ),
    .${stream_in[i]}_TREADY ( ${stream_in[i]}_i.ready ),
      % endif
    % endfor  

    // Source ports
    % for j in range (n_source):
      % if (is_parallel_out[j]):
        % for k in range (out_parallelism_factor[j]):
    .${stream_out[j]}_${k}_TDATA  ( ${stream_out[j]}_${k}_o.data  ),
    .${stream_out[j]}_${k}_TVALID ( ${stream_out[j]}_${k}_o.valid ),
    .${stream_out[j]}_${k}_TREADY ( ${stream_out[j]}_${k}_o.ready ),
        % endfor
      % else:
    .${stream_out[j]}_TDATA  ( ${stream_out[j]}_o.data  ),
    .${stream_out[j]}_TVALID ( ${stream_out[j]}_o.valid ),
    .${stream_out[j]}_TREADY ( ${stream_out[j]}_o.ready ),
      % endif
    % endfor

    % if custom_reg_num>0:
    // Kernel parameters
      % for i in range (custom_reg_num):
        % if custom_reg_isport[i]:
    .${custom_reg_name[i]}        ( ${custom_reg_name[i]} ),
        % endif
      % endfor
    % endif 

    // Control signals.
    .ap_start      ( ctrl_i.start             ),
    .ap_done       ( flags_o.done             ),
    .ap_idle       ( flags_o.idle             ),
    .ap_ready      ( flags_o.ready            )
  );

</%def>

<%
################################################
## Kernel interface - Generate stream strobes ##
################################################
%>

<%def name="xil_ap_ctrl_hs_stream_strobes()">\

</%def>

