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
#####################
## HWPE controller ##
#####################
%>

<%def name="vsim_waves_hwpe_ctrl()">\

<%
# HWPE controller - Top
%>

add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {top} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/*}

<%
# Slave port of HWPE controller exposed on the peripheral interconnect
%>

add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {add} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/add}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {wen} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/wen}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {be} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/be}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {data} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/data}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {id} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/id}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {r_data} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/r_data}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {r_valid} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/r_valid}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {slave_periph_port} -label {r_id} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/cfg/r_id}

</%def>

<%
########################
## HWPE register file ##
########################
%>

<%def name="vsim_waves_hwpe_ctrl_regfile()">\
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {clear_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/clear_i}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {in} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_in_i}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {out} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_out_o}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {flags} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/flags_i}

add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {reg_file} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/reg_file}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {regfile_mem} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_mem}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {regfile_mem_mandatory} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_mem_mandatory}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {regfile_mem_generic} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_mem_generic}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {regfile_mem_dout} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_mem_dout}

add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -label {clear_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_slave/i_regfile/regfile_latch_mem}

% for i in range (custom_reg_num):
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {regfile} -group {${target}_static_regs} -label {${custom_reg_name[i]}} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/static_reg_${custom_reg_name[i]}}
% endfor

</%def>

<%
################
## HWPE ULOOP ##
################
%>

<%def name="vsim_waves_hwpe_ctrl_uloop()">\

add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {global} -label {clk_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/clk_i}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {global} -label {rst_ni} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/rst_ni}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {global} -label {test_mode_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/test_mode_i}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {global} -label {clear_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/clear_i}

add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {i/o} -label {ctrl_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/ctrl_i}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {i/o} -label {flags_o} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/flags_o}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {i/o} -label {uloop_code_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/uloop_code_i}
add wave -noupdate -group {HWPE ${target}} -group {hwpe_ctrl} -group {uloop} -group {i/o} -label {registers_read_i} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${target}_top/i_ctrl/i_uloop/registers_read_i}

</%def>
