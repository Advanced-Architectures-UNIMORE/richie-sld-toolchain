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
#########################################################
## Library of components - Map local control and flags ##
#########################################################
%>

<%
# This module has template definitions to map ctrl_i
# and flags_o to local logic variables.
#
# Version 0 is is no longer used (kept as backup).
#
# The reason why these have been avoided is to simplify the
# agile instantiation of different type of datapath adapters.
# For example, the control/flag interface of PULP accelerators
# and HLS-compiled datapaths is different. While the former
# is typically driven using the struct, the latter uses
# separated ports for each signal.
%>

<%def name="map_engine_ctrl_v0()">\

  /* Control signals */

  logic engine_start, engine_clear;

  assign engine_start = ctrl_i.start;
  assign engine_clear = ctrl_i.clear;

</%def>

<%def name="map_engine_flags_v0()">\

  /* Flag signals */

  logic engine_done, engine_idle, engine_ready;

  assign flags_o.done = engine_done;
  assign flags_o.idle = engine_idle;

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_ready
    if(~rst_ni)
      flags_o.ready = 1'b0;
    else if(~(engine_ready | engine_idle))
      flags_o.ready = 1'b0;
    else
      flags_o.ready = 1'b1;
  end

</%def>

<%
# Version 1 re-defines the control and flag structs on the
# basis of the datapath interface that is adopted.
#
# The struct ctrl_i and flags_o are directly instantiated
# on the datapath interface to drive control and flags in
# between the latter and the wrapper FSM. The struct are
# defined in the SystemVerilog package of the wrapper:
#
# - ctrl_datapath_adapter_t
# - flags_datapath_adapter_t
#
# The re-definition is needed to flexibly pilot the FSM
# ready signal. For example, in case of an HLS datapath, both
# the 'ready' and 'idle' flags will be used to pilot the FSM
# 'ready' signal. At the same time, another methodology might
# implement a slightly different interface with no 'idle'.
%>

<%def name="map_engine_ctrl_v1_hls()">\

  /* Control signals */

  ctrl_datapath_adapter_${acc_wr_target}_t ctrl_adapter;

  assign ctrl_adapter.start = ctrl_i.start;

  % if acc_wr_is_hls_stream == True:
    % for i in range (acc_wr_n_sink):
  assign ctrl_adapter.packet_size_${acc_wr_stream_in[i]} = ctrl_i.packet_size_${acc_wr_stream_in[i]};
    % endfor
  % endif

</%def>

<%def name="map_engine_flags_v1_hls()">\

  /* Flag signals */

  flags_datapath_adapter_${acc_wr_target}_t flags_adapter;

  assign flags_o.done = flags_adapter.done;

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_ready
    if(~rst_ni)
      flags_o.ready = 1'b0;
    else if(~(flags_adapter.ready | flags_adapter.idle))
      flags_o.ready = 1'b0;
    else
      flags_o.ready = 1'b1;
  end

</%def>
