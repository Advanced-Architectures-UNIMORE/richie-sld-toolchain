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

    Description:    HWPE datapath adapter.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
#############################################################
## Datapath interface - Xilinx ap_ctrl_hs (refer to UG902) ##
#############################################################
%>

<%
############################################
## Datapath interface - Datapath controls ##
############################################
%>

<%def name="xil_ap_ctrl_hs_datapath_ctrl()">\

</%def>

<%
#########################################
## Datapath interface - Datapath flags ##
#########################################
%>

<%def name="xil_ap_ctrl_hs_datapath_flags()">\

</%def>

<%
###############################################################
## Datapath interface - Xilinx ap_ctrl_hs datapath interface ##
###############################################################
%>

<%def name="xil_ap_ctrl_hs_datapath_intf()">\

  /* ${acc_wr_target} datapath interface. */

  ${acc_wr_target} i_${acc_wr_target} (
    // Global signals.
    .ap_clk       ( clk_i            ),
    .ap_rst_n     ( rst_ni           ),

    // Sink ports
    % for i in range (acc_wr_n_sink):
      % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
    .${acc_wr_stream_in[i]}_${k}_TDATA  ( ${acc_wr_stream_in[i]}_${k}_i.data  ),
    .${acc_wr_stream_in[i]}_${k}_TVALID ( ${acc_wr_stream_in[i]}_${k}_i.valid ),
    .${acc_wr_stream_in[i]}_${k}_TREADY ( ${acc_wr_stream_in[i]}_${k}_i.ready ),
        % endfor
      % else:
    .${acc_wr_stream_in[i]}_TDATA  ( ${acc_wr_stream_in[i]}_i.data  ),
    .${acc_wr_stream_in[i]}_TVALID ( ${acc_wr_stream_in[i]}_i.valid ),
    .${acc_wr_stream_in[i]}_TREADY ( ${acc_wr_stream_in[i]}_i.ready ),
      % endif
    % endfor

    // Source ports
    % for j in range (acc_wr_n_source):
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
    .${acc_wr_stream_out[j]}_${k}_TDATA  ( ${acc_wr_stream_out[j]}_${k}_o.data  ),
    .${acc_wr_stream_out[j]}_${k}_TVALID ( ${acc_wr_stream_out[j]}_${k}_o.valid ),
    .${acc_wr_stream_out[j]}_${k}_TREADY ( ${acc_wr_stream_out[j]}_${k}_o.ready ),
        % endfor
      % else:
    .${acc_wr_stream_out[j]}_TDATA  ( ${acc_wr_stream_out[j]}_o.data  ),
    .${acc_wr_stream_out[j]}_TVALID ( ${acc_wr_stream_out[j]}_o.valid ),
    .${acc_wr_stream_out[j]}_TREADY ( ${acc_wr_stream_out[j]}_o.ready ),
      % endif
    % endfor

    % if acc_wr_custom_reg_num>0:
    // Datapath parameters
      % for i in range (acc_wr_custom_reg_num):
        % if acc_wr_custom_reg_isport[i]:
    .${acc_wr_custom_reg_name[i]}        ( ${acc_wr_custom_reg_name[i]} ),
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
##################################################
## Datapath interface - Generate stream strobes ##
##################################################
%>

<%def name="xil_ap_ctrl_hs_stream_strobes()">\

</%def>

