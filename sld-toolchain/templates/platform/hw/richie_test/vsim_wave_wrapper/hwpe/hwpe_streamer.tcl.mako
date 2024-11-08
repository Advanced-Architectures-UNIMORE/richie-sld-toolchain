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

    Description:    Questasim waves.

    Date:           16.7.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_hwpe_streamer
# Type:         Template API
# Description:  HWPE streamer
# =====================================================================
%>

<%def name="vsim_waves_hwpe_streamer()">\

<%
# HWPE streamer - Top
%>

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {top} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/*}

</%def>

<%
# =====================================================================
# Title:        vsim_waves_hwpe_streamer_source
# Type:         Template API
# Description:  HWPE streamer source modules
# =====================================================================
%>

<%def name="vsim_waves_hwpe_streamer_source()">\

<%
# HWPE streamer - Source modules
%>

% for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_in[i]}_${k}} -group {source} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_${k}_source/*}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_in[i]}_${k}} -group {split_streams[0]} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_${k}_source/split_streams[0]/*}
        % endfor
    % else:
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_in[i]}} -group {source} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_source/*}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_in[i]}} -group {split_streams[0]} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_source/split_streams[0]/*}
    % endif
% endfor

</%def>


<%
# =====================================================================
# Title:        vsim_waves_hwpe_streamer_sink
# Type:         Template API
# Description:  HWPE streamer sink modules
# =====================================================================
%>

<%def name="vsim_waves_hwpe_streamer_sink()">\

<%
# HWPE streamer - Sink modules
%>

% for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_out[j]}_${k}} -group {sink} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_${k}_sink/*}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_out[j]}_${k}} -group {split_streams[0]} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_${k}_sink/split_streams[0]/*}
        % endfor
    % else:
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_out[j]}} -group {sink} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_sink/*}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_out[j]}} -group {split_streams[0]} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_sink/split_streams[0]/*}
    % endif
% endfor

</%def>

<%
# =====================================================================
# Title:        vsim_waves_hwpe_streamer_addressgen
# Type:         Template API
# Description:  HWPE streamer address generator
# =====================================================================
%>

<%def name="vsim_waves_hwpe_streamer_addressgen()">\

<%
# HWPE streamer - Address generators (source modules)
%>

% for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_in[i]}_${k}} -group {addressgen} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_${k}_source/i_addressgen/*}
        % endfor
    % else:
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_in[i]}} -group {addressgen} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_in[i]}_source/i_addressgen/*}
    % endif
% endfor

<%
# HWPE streamer - Address generators (sink modules)
%>

% for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_out[j]}_${k}} -group {addressgen} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_${k}_sink/i_addressgen/*}
        % endfor
    % else:
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {streamer} -group {${acc_wr_stream_out[j]}} -group {addressgen} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_streamer/i_${acc_wr_stream_out[j]}_sink/i_addressgen/*}
    % endif
% endfor

</%def>
