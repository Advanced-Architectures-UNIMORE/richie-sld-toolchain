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
## HWPE FSM ##
##############
%>

<%def name="vsim_waves_hwpe_ctrl_fsm()">\

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {global} -label {clk_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/clk_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {global} -label {rst_ni} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/rst_ni}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {global} -label {test_mode_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/test_mode_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {global} -label {clear_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/clear_i}

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -label {current_state} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/curr_state}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -label {next_state} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/next_state}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -label {ctrl_fsm_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_i}

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {in_flags} -label {flags_streamer_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_streamer_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {in_flags} -label {flags_engine_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_engine_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {in_flags} -label {flags_ucode_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_ucode_i}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {in_flags} -label {flags_slave_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/flags_slave_i}

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_streamer_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_streamer_o}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_engine_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_engine_o}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_ucode_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_ucode_o}
add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_ctrl} -group {FSM} -group {out_ctrl} -label {ctrl_slave_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_fsm/ctrl_slave_o}

</%def>
