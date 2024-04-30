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
########################################
## Datapath interface - PULP standard ##
########################################
%>

<%
#############################################
## Datapath interface - Datapath interface ##
#############################################
%>

<%def name="pulp_std_datapath_intf()">\

  /* ${acc_wr_target} datapath interface. */

  ${acc_wr_target} i_${acc_wr_target} (
    // Global signals.
    .clk_i        ( clk_i            ),
    .rst_ni       ( rst_ni           ),

    // Sink ports
    % for i in range (acc_wr_n_sink):
      % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
    .${acc_wr_stream_in[i]}_${k}  ( ${acc_wr_stream_in[i]}_${k}_i  ),
        % endfor
      % else:
    .${acc_wr_stream_in[i]}  ( ${acc_wr_stream_in[i]}_i  ),
      % endif
    % endfor

    // Source ports
    % for j in range (acc_wr_n_source):
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
    .${acc_wr_stream_out[j]}_${k}  ( ${acc_wr_stream_out[j]}_${k}_o  ),
        % endfor
      % else:
    .${acc_wr_stream_out[j]}  ( ${acc_wr_stream_out[j]}_o  ),
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
    .ctrl_i       ( flags_o            ),

    // Flag signals.
    .flags_o      ( flags_o            )
  );

</%def>

