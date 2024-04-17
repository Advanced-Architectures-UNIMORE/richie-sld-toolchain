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

    Description:    HWPE FSM.

    Date:           11.6.2021

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
##################################################
## Library of components - Engine communication ##
##################################################
%>

<%
##################################################
## Engine communication - Initialize requests ##
##################################################
%>

<%def name="engine_init_packet_size()">\
\
  % for i in range (acc_wr_n_sink):
    ctrl_engine_o.packet_size_${acc_wr_stream_in[i]}  = ctrl_i.packet_size_${acc_wr_stream_in[i]};
  % endfor
\
</%def>

<%def name="engine_init_cnt_limit()">\
\
  % for j in range (acc_wr_n_source):
    ctrl_engine_o.cnt_limit_${acc_wr_stream_out[j]}  = ctrl_i.cnt_limit_${acc_wr_stream_out[j]};
  % endfor
\
</%def>

<%
############################################
## Engine communication - Check cnt flags ##
############################################
%>

<%def name="engine_check_cnt_flags_v0()">\

<%
  # The following version takes advantage of the programmable
  # 'cnt_limit' parameter to decide how many engine runs will
  # wil trigger a state transition to terminate the accelerator
  # operation. An engine run completes when a 'done' transient
  # is generated by the engine itself. 'cnt_limit' is compared
  # to an output count flag (from the engine).
%>

  % for j in range (acc_wr_n_source):
    % if (j is not acc_wr_n_source - 1):
          flags_engine_i.cnt_${acc_wr_stream_out[j]} == ctrl_i.cnt_limit_${acc_wr_stream_out[j]} &
    % else:
          flags_engine_i.cnt_${acc_wr_stream_out[j]} == ctrl_i.cnt_limit_${acc_wr_stream_out[j]} \
    % endif
  % endfor

</%def>

<%def name="engine_check_cnt_flags_v1()">\

<%
  # This simpler version assumes that the completion
  # of an engine run should trigger a state transition
  # to terminate the accelerator operation.
%>

          flags_engine_i.done == '1

</%def>
