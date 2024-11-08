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
# Title:        vsim_waves_hwpe_ctrl_fsm
# Type:         Template API
# Description:  HWPE FSM
# =====================================================================
%>

<%def name="vsim_waves_hwpe_ctrl_fsm()">\

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {top} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/*}

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -label {current_state} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/curr_state}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -label {next_state} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/next_state}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -label {ctrl_fsm_i} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_i}

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {in_flags} -label {flags_streamer_i} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_streamer_i}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {in_flags} -label {flags_engine_i} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_engine_i}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {in_flags} -label {flags_ucode_i} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_ucode_i}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {in_flags} -label {flags_slave_i} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_slave_i}

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_streamer_o} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_streamer_o}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_engine_o} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_engine_o}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_ucode_o} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_ucode_o}
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_slave_o} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_slave_o}

</%def>
