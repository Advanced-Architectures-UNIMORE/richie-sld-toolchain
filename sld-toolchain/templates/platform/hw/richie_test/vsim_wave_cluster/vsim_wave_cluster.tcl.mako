<%
'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

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

    Date:           19.1.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>


<%
    # Additional design knobs
    n_acc_cl = len(cl_lic_acc_names)
    n_periphs = 8 + n_acc_cl - 1
%>

<%
    # PULP cluster (top)
%>

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {top} -group {s_mperiph_bus} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/s_mperiph_bus/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {top} -group {s_mperiph_demux_bus[0]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/s_mperiph_demux_bus[0]/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {top} -group {s_mperiph_demux_bus[1]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/s_mperiph_demux_bus[1]/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {axi2per_wrap_i} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/axi2per_wrap_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {axi2per_wrap_i} -group {axi2per_i} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/axi2per_wrap_i/axi2per_i/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {axi2per_wrap_i} -group {req_channel} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/axi2per_wrap_i/axi2per_i/req_channel_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {axi2per_wrap_i} -group {resp_channel} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/axi2per_wrap_i/axi2per_i/res_channel_i/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {per2axi_wrap_i} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/per2axi_wrap_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {per2axi_wrap_i} -group {per2axi_i} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/per2axi_wrap_i/per2axi_i/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {periph_demux} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/per_demux_wrap_i/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {tryx_ctrl_i} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/tryx_ctrl_i/*}

${vsim_waves_cluster_bus()}
${vsim_waves_cluster_interconnect()}
${vsim_waves_cluster_peripherals()}

<%
    # RISC-V core waves
%>

${vsim_waves_core_region()}
${vsim_waves_core_demux()}
${vsim_waves_core_periph_demux()}

${vsim_waves_core_if_stage()}
${vsim_waves_core_id_stage()}
${vsim_waves_core_ex_stage()}
${vsim_waves_core_cs_registers()}
${vsim_waves_core_lsu()}
${vsim_waves_core_eu_ctrl()}

<%
    # Cluster components waves
%>

${vsim_waves_cluster_core_periph_slave()}
${vsim_waves_cluster_dma_ooc_wrap()}
${vsim_waves_cluster_event_unit()}
${vsim_waves_cluster_timer_unit()}
${vsim_waves_cluster_speriph_mst(n_periphs)}
${vsim_waves_cluster_tcdm()}
${vsim_waves_cluster_icache()}

<%
    # LIC accelerator region waves
%>

${vsim_waves_lic_acc_region(n_acc_cl)}
