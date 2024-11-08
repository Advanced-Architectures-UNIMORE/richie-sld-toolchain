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
###################
## HWPE streamer ##
###################
%>

<%def name="vsim_waves_hwpe_streamer()">\

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {global} -label {clk_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/clk_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {global} -label {rst_ni} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/rst_ni}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {global} -label {test_mode_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/test_mode_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {global} -label {enable_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/enable_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {global} -label {clear_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/clear_i}

<%
# HWPE streamer - Top
%>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {top} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/*}

</%def>


<%
################################
## HWPE stream source modules ##
################################
%>

<%def name="vsim_waves_hwpe_streamer_source()">\

<%
# HWPE streamer - Source modules
%>

% for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_in[i]}_${k}_source} -group {source} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_${k}_source/*}
        % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_in[i]}_source} -group {source} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_source/*}
    % endif
% endfor
</%def>


<%
##############################
## HWPE stream sink modules ##
##############################
%>

<%def name="vsim_waves_hwpe_streamer_sink()">\

<%
# HWPE streamer - Sink modules
%>

% for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_out[j]}_${k}_sink} -group {sink} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_${k}_sink/*}
        % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_out[j]}_sink} -group {sink} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_sink/*}
    % endif
% endfor

</%def>



<%
####################################
## HWPE stream address generators ##
####################################
%>

<%def name="vsim_waves_hwpe_streamer_addressgen()">\

<%
# HWPE streamer - Address generators (source modules)
%>

% for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_in[i]}_${k}_source} -group {addressgen} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_${k}_source/i_addressgen/*}
        % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_in[i]}_source} -group {addressgen} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_source/i_addressgen/*}
    % endif
% endfor

<%
# HWPE streamer - Address generators (sink modules)
%>

% for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_out[j]}_${k}_sink} -group {addressgen} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_${k}_sink/i_addressgen/*}
        % endfor
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_streamer} -group {${acc_wr_stream_out[j]}_sink} -group {addressgen} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_sink/i_addressgen/*}
    % endif
% endfor

</%def>
