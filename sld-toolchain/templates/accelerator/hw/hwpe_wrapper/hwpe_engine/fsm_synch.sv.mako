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
#################################################
## Library of components - FSM synchronization ##
#################################################
%>

<%
# To track the handshakes of the parallel output streams, and-ing them and
# count the latter signals is a way of reducing the overall number of FF
# required to track the engine activity. Moreover, the trackers are 1-bit
# so they scale well with parallelized interfaces.

# Thus, the trackers are connected to the parallel streams, then the counters
# are used for the different categories of acc_wr_stream_out.
%>

<%
#######################################################
## FSM synchronization - Output streams data tracker ##
#######################################################
%>

<%def name="out_track_decl()">\

<%
# A tracker is basically a boolean to sense when an
# handshake of VALID and READY occurs on a certain
# streaming interface.
%>

  // Declaration of trackers

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):

<%
# Declaration of trackers for parallelized (partitioned) streaming interfaces.
%>

      % for k in range (acc_wr_out_parallelism_factor[j]):
  logic track_${acc_wr_stream_out[j]}_${k}_q, track_${acc_wr_stream_out[j]}_${k}_d;
      % endfor
    % else:

<%
# Declaration of trackers for standard streaming interfaces.
%>

  logic track_${acc_wr_stream_out[j]}_q, track_${acc_wr_stream_out[j]}_d;
    % endif
  % endfor

</%def>

<%def name="out_track_impl_DtypeFF()">\

<%
# The implementation of such trackers has been done using a
# delay logic (combinatorial+sequential) since handshake
# occurs before the generation of a 'done' signal in HLS
# accelerators. To count the number of output data, we need
# both the information about the handshake and the 'done' (or
# end-of-computation) of the accelerator to prevent undesired
# behaviors. The tracker becomes also useful to scale the control
# of such streaming interface since operating on a single bit
# (instead of e.g. 16/32 bits as a counter might do) saves area.
# In case of a parallelized interface, these trackers are AND-ed
# and the resulting boolean will command the countin on the ouput
# counter. This solution should not impact performance as the latter
# would be dependent on the most congested port anyway.
%>

  // AND-ed trackers implementation (FF)
  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):

<%
# Implementation of delayed trackers for parallelized (partitioned) streaming interfaces.
%>

      % for k in range (acc_wr_out_parallelism_factor[j]):
  always_comb
  begin: ${acc_wr_stream_out[j]}_${k}_track_q
    if(~rst_ni | ctrl_i.clear) begin
      track_${acc_wr_stream_out[j]}_${k}_d = '0;
    end
    else if(${acc_wr_stream_out[j]}_${k}_o.valid & ${acc_wr_stream_out[j]}_${k}_o.ready) begin
      track_${acc_wr_stream_out[j]}_${k}_d = '1;
    end
    else begin
      track_${acc_wr_stream_out[j]}_${k}_d = '0;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: ${acc_wr_stream_out[j]}_${k}_track_d
    if(~rst_ni) begin
      track_${acc_wr_stream_out[j]}_${k}_q <= '0;
    end
    else if(ctrl_i.clear) begin
      track_${acc_wr_stream_out[j]}_${k}_q <= '0;
    end
    else begin
      track_${acc_wr_stream_out[j]}_${k}_q <= track_${acc_wr_stream_out[j]}_${k}_d;
    end
  end
      % endfor
  assign track_${acc_wr_stream_out[j]}_AND = ${AND_parallel_track_out()}

    % else:

<%
# Implementation of delayed trackers for standard streaming interfaces.
%>

  always_comb
  begin: ${acc_wr_stream_out[j]}_track_q
    if(~rst_ni | ctrl_i.clear) begin
      track_${acc_wr_stream_out[j]}_d = '0;
    end
    else if(${acc_wr_stream_out[j]}_o.valid & ${acc_wr_stream_out[j]}_o.ready) begin
      track_${acc_wr_stream_out[j]}_d = '1;
    end
    else begin
      track_${acc_wr_stream_out[j]}_d = '0;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: ${acc_wr_stream_out[j]}_track_d
    if(~rst_ni) begin
      track_${acc_wr_stream_out[j]}_q <= '0;
    end
    else if(ctrl_i.clear) begin
      track_${acc_wr_stream_out[j]}_q <= '0;
    end
    else begin
      track_${acc_wr_stream_out[j]}_q <= track_${acc_wr_stream_out[j]}_d;
    end
  end

    % endif
  % endfor

</%def>

<%
###########################################
## FSM synchronization - Output counters ##
###########################################
%>

<%def name="cnt_out_decl()">\

  // Declaration of counters

  % for j in range (acc_wr_n_source):
  logic unsigned [($clog2(${TARGET}_CNT_LEN)+1):0] cnt_${acc_wr_stream_out[j]};
  % endfor

</%def>

<%def name="cnt_out_FF_impl()">\

  // Counter implementation (FF)
  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):

<%
# Implementation of output counters for parallelized (partitioned) streaming interfaces.
# Having trackers the design needs just one counter per parallel stream.
%>

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: ${acc_wr_stream_out[j]}_cnt
    if((~rst_ni) | ctrl_i.clear)
      cnt_${acc_wr_stream_out[j]} = 32'b0;
  % if acc_wr_design_type == 'hls':
    % if acc_wr_is_hls_stream == True:
  else if( flags_adapter.last[${j}] & flags_adapter.done ) // TO-DO: Test with multiple outputs! Might break...
    % else:
  else if( track_${acc_wr_stream_out[j]}_AND & flags_adapter.done )
    % endif
  % else:
  else if( track_${acc_wr_stream_out[j]}_AND & flags_adapter.done )
  % endif
      cnt_${acc_wr_stream_out[j]} = cnt_${acc_wr_stream_out[j]} + 1;
    else
      cnt_${acc_wr_stream_out[j]} = cnt_${acc_wr_stream_out[j]};
  end


    % else:

<%
# Implementation of output counters for standard streaming interfaces.
%>

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: ${acc_wr_stream_out[j]}_cnt
    if((~rst_ni) | ctrl_i.clear)
      cnt_${acc_wr_stream_out[j]} = 32'b0;
  % if acc_wr_design_type == 'hls':
    % if acc_wr_is_hls_stream == True:
    else if( flags_adapter.last[${j}] & flags_adapter.done ) // TO-DO: Test with multiple outputs! Might break...
    % else:
    else if( track_${acc_wr_stream_out[j]}_q & flags_adapter.done )
    % endif
  % else:
    else if( track_${acc_wr_stream_out[j]}_q & flags_adapter.done )
  % endif
      cnt_${acc_wr_stream_out[j]} = cnt_${acc_wr_stream_out[j]} + 1;
    else
      cnt_${acc_wr_stream_out[j]} = cnt_${acc_wr_stream_out[j]};
  end
    % endif
  % endfor

</%def>

<%
#######################################################
## FSM synchronization - Connection to flag (to FSM) ##
#######################################################
%>

<%def name="cnt_out_assign_to_fsm()">\

  // Assign to fsm flags
  % for j in range (acc_wr_n_source):
  assign flags_o.cnt_${acc_wr_stream_out[j]} = cnt_${acc_wr_stream_out[j]};
  % endfor

</%def>

<%
####################################################
## FSM synchronization - AND-ing tracking signals ##
####################################################
%>

<%def name="AND_parallel_track_out()">\
\
  % for j in range (acc_wr_n_source-1):
      % if (acc_wr_is_parallel_out[j]):
          % for k in range (acc_wr_out_parallelism_factor[j]):
track_${acc_wr_stream_out[j]}_${k} & \
          % endfor
      % endif
  % endfor
\
  % if (acc_wr_is_parallel_out[acc_wr_n_source-1]):
      % for k in range (acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1):
track_${acc_wr_stream_out[acc_wr_n_source-1]}_${k} & \
      % endfor
track_${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}; \
  % endif
\
</%def>
