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
##############
## HWPE top ##
##############
%>

<%def name="vsim_waves_hwpe_top()">\

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/clk_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/rst_ni}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/test_mode_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_r_data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {tcdm} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/tcdm_r_valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_add}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_be}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_gnt}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_wen}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_req}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_id}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_r_data}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_r_valid}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} -group {periph} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/periph_r_id}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_top} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/evt_o}

</%def>
