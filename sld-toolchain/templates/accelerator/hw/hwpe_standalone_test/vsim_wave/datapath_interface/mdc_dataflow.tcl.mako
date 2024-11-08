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

    Description:    QuestaSim waves.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
#################################################
## HWPE datapath adapter waves - MDC dataflow  ##
#################################################
%>

<%def name="vsim_waves_hwpe_datapath_adapter_mdc_dataflow()">\

<%
# Global signals
%>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Global} -label {clk_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/clk_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Global} -label {rst_ni} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/rst_ni}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Global} -label {test_mode_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/test_mode_i}

<%
# Data streams
%>

% for i in range (acc_wr_n_sink):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Input data} -group {${acc_wr_stream_in[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_stream_in[i]}_i/valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Input data} -group {${acc_wr_stream_in[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_stream_in[i]}_i/data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Input data} -group {${acc_wr_stream_in[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_stream_in[i]}_i/ready}
% endfor

% for i in range (acc_wr_n_source):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Output data} -group {${acc_wr_stream_out[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_stream_out[i]}_o/valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Output data} -group {${acc_wr_stream_out[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_stream_out[i]}_o/data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Output data} -group {${acc_wr_stream_out[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_stream_out[i]}_o/ready}
% endfor

<%
# Datapath parameters
%>

% for i in range (acc_wr_custom_reg_num):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Custom registers} -label {${acc_wr_custom_reg_name[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/${acc_wr_custom_reg_name[i]}}
% endfor

<%
# Control signals
%>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -label {ctrl_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/ctrl_i}

<%
# Flag signals
%>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -label {flags_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/flags_o}

<%
# Additional components are required to implement the behavior of control and flag signals.
# The accelerator interface that MDC adopts has no [start, done, idle, ready] controls, thus
# these behaviours have to be implemented in the interface body itself.
%>

<%
# Datapath input counters
%>

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Input counters} -label {datapath_cnt_${acc_wr_stream_in[i]}_${k}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_cnt_${acc_wr_stream_in[i]}_${k}}
      % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Input counters} -label {datapath_cnt_${acc_wr_stream_in[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_cnt_${acc_wr_stream_in[i]}}
    % endif
  % endfor

<%
# Datapath output counters
%>

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Output counters} -label {datapath_cnt_${acc_wr_stream_out[j]}_${k}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_cnt_${acc_wr_stream_out[j]}_${k}}
      % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Output counters} -label {datapath_cnt_${acc_wr_stream_out[j]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_cnt_${acc_wr_stream_out[j]}}
    % endif
  % endfor

<%
# Datapath control - start
%>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Control} -label {Start} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_start}

<%
# Datapath flags - input ready, done
%>

% for i in range (acc_wr_n_sink):
  % if (acc_wr_is_parallel_in[i]):
    % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_ready_${acc_wr_stream_in[i]}_${k}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_ready_${acc_wr_stream_in[i]}_${k}}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_done_${acc_wr_stream_in[i]}_${k}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_done_${acc_wr_stream_in[i]}_${k}}
    % endfor
  % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_ready_${acc_wr_stream_in[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_ready_${acc_wr_stream_in[i]}}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_done_${acc_wr_stream_in[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_done_${acc_wr_stream_in[i]}}
  % endif
% endfor

<%
# Datapath flags - output done
%>

% for j in range (acc_wr_n_source):
  % if (acc_wr_is_parallel_out[j]):
    % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_done_${acc_wr_stream_out[j]}_${k}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_done_${acc_wr_stream_out[j]}_${k}}
    % endfor
  % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_done_${acc_wr_stream_out[j]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_done_${acc_wr_stream_out[j]}}
  % endif
% endfor

<%
# Datapath flags - input idle
%>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_adapter} -group {mdc_dataflow} -group {Datapath signals} -group {Flags} -label {datapath_idle} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/datapath_idle}

</%def>
