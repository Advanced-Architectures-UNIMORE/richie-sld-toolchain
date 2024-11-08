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

    Date:           23.11.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
#####################################
## System-to-Accelerator Interface ##
#####################################
%>

<%def name="vsim_waves_richie_acc_intf()">\

        <%
          port_offset = 0
        %>

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/clk}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/rst_n}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/test_mode}

% for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_opc}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_rdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_valid}
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_opc}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_rdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${i}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_valid}
    % endif
        <%
          port_offset += 1
        %>
% endfor

% for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_opc}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_rdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_valid}
    % else:
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/wdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_opc}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_rdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwpe_xbar_master[${acc_wr_n_sink+j}]} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_xbar_master[${port_offset}]/r_valid}
    % endif
        <%
          port_offset += 1
        %>
% endfor

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/wdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/id}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/r_valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/r_opc}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/r_id}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} -group {hwacc_cfg_slave} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/hwacc_cfg_slave/r_rdata}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/evt_o}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {richie_acc_intf} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/busy_o}

</%def>
