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
####################################################
## Library of components - Streamer communication ##
####################################################
%>

<%
##################################################
## Streamer communication - Initialize requests ##
##################################################
%>

<%def name="streamer_init()">\
  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.req_start    = '0;
      % endfor
    % else:
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.req_start    = '0;
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.req_start    = '0;
      % endfor
    % else:
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.req_start    = '0;
    % endif
  % endfor

</%def>

<%
##################################################
## Streamer communication - Initialize requests ##
##################################################
%>

<%def name="streamer_issue_req_start()">\

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
          ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.req_start    = '1;
      % endfor
    % else:
          ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.req_start    = '1;
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
          ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.req_start    = '1;
      % endfor
    % else:
          ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.req_start    = '1;
    % endif
  % endfor

</%def>

<%
################################################
## Streamer communication - Check ready flags ##
################################################
%>

<%def name="streamer_check_ready_flags()">\

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
          flags_streamer_i.${acc_wr_stream_in[i]}_${k}_source_flags.ready_start &
      % endfor
    % else:
          flags_streamer_i.${acc_wr_stream_in[i]}_source_flags.ready_start &
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (j is not acc_wr_n_source - 1):
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
          flags_streamer_i.${acc_wr_stream_out[j]}_${k}_sink_flags.ready_start &
        % endfor
      % else:
          flags_streamer_i.${acc_wr_stream_out[j]}_sink_flags.ready_start &
      % endif
    % else:
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]-1):
          flags_streamer_i.${acc_wr_stream_out[j]}_${k}_sink_flags.ready_start &
        % endfor
          flags_streamer_i.${acc_wr_stream_out[j]}_${k}_sink_flags.ready_start \
      % else:
          flags_streamer_i.${acc_wr_stream_out[j]}_sink_flags.ready_start \
      % endif
    % endif
  % endfor

</%def>
