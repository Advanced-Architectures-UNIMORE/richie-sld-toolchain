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
#################
## HWPE engine ##
#################
%>

<%def name="vsim_waves_hwpe_engine()">\

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {global} -label {clk_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/clk_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {global} -label {rst_ni} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/rst_ni}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {global} -label {test_mode_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/test_mode_i}

% for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Input data} -group {${acc_wr_stream_in[i]}_${k}} -label {Valid} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_in[i]}_${k}_i/valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Input data} -group {${acc_wr_stream_in[i]}_${k}} -label {Data} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_in[i]}_${k}_i/data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Input data} -group {${acc_wr_stream_in[i]}_${k}} -label {Ready} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_in[i]}_${k}_i/ready}
        % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Input data} -group {${acc_wr_stream_in[i]}} -label {Valid} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_in[i]}_i/valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Input data} -group {${acc_wr_stream_in[i]}} -label {Data} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_in[i]}_i/data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Input data} -group {${acc_wr_stream_in[i]}} -label {Ready} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_in[i]}_i/ready}
    % endif
% endfor

% for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Output data} -group {${acc_wr_stream_out[j]}_${k}} -label {Valid} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_out[j]}_${k}_o/valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Output data} -group {${acc_wr_stream_out[j]}_${k}} -label {Data} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_out[j]}_${k}_o/data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Output data} -group {${acc_wr_stream_out[j]}_${k}} -label {Ready} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_out[j]}_${k}_o/ready}
      % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Output data} -group {${acc_wr_stream_out[j]}} -label {Valid} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_out[j]}_o/valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Output data} -group {${acc_wr_stream_out[j]}} -label {Data} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_out[j]}_o/data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Output data} -group {${acc_wr_stream_out[j]}} -label {Ready} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/${acc_wr_stream_out[j]}_o/ready}
    % endif
% endfor

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {FSM - control} -label {ctrl_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/ctrl_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {FSM - flags} -label {flags_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/flags_o}

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_engine} -group {Local} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/*}

</%def>
