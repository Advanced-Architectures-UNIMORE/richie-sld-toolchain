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

<%
#######################################
## Library of components - Streaming ##
#######################################
%>

<%
##################################
## Streaming - Engine interface ##
##################################
%>

<%def name="streaming_engine_intf()">\

  // Sink ports
  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
  hwpe_stream_intf_stream.sink ${acc_wr_stream_in[i]}_${k}_i,
      % endfor
    % else:
  hwpe_stream_intf_stream.sink ${acc_wr_stream_in[i]}_i,
    % endif
  % endfor

  // Source ports
  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
  hwpe_stream_intf_stream.source ${acc_wr_stream_out[j]}_${k}_o,
      % endfor
    % else:
  hwpe_stream_intf_stream.source ${acc_wr_stream_out[j]}_o,
    % endif
  % endfor

</%def>

<%
####################################
## Streaming - Datapath interface ##
####################################
%>

<%def name="streaming_datapath_adapter_intf()">\
\
// Data streams
  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
    .${acc_wr_stream_in[i]}_${k}_i ( ${acc_wr_stream_in[i]}_${k}_i  ),
      % endfor
    % else:
    .${acc_wr_stream_in[i]}_i ( ${acc_wr_stream_in[i]}_i  ),
    % endif
  % endfor
\
  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
    .${acc_wr_stream_out[j]}_${k}_o ( ${acc_wr_stream_out[j]}_${k}_o  ),
      % endfor
    % else:
    .${acc_wr_stream_out[j]}_o ( ${acc_wr_stream_out[j]}_o  ),
    % endif
  % endfor
\
</%def>
