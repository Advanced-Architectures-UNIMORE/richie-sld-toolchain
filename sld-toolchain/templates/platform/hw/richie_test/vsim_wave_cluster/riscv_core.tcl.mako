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

    Date:           18.1.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
# =====================================================================
# CORE REGION
# =====================================================================
%>

<%
# =====================================================================
# Title:        vsim_waves_core_region
# Type:         Template API
# Description:  Core region.
# =====================================================================
%>

<%def name="vsim_waves_core_region()">\

% for core_offset in range(cl_n_cores):

onerror {resume}
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/decoder_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/decoder_i/instr_rdata_i[24:20]} rs2
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/decoder_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/decoder_i/instr_rdata_i[19:15]} rs1
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/instr_rdata_i[6:0]} opcode
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/instr_rdata_i[11:7]} rd
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/instr_rdata_i[14:12]} funct3
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/instr_rdata_i[19:15]} rs1
quietly virtual signal -install {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i} { /richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/instr_rdata_i[24:20]} rs2
quietly WaveActivateNextPane {} 0

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_core_demux
# Type:         Template API
# Description:  Core demux.
# =====================================================================
%>

<%def name="vsim_waves_core_demux()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {core_demux} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/core_demux_i/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_core_periph_demux
# Type:         Template API
# Description:  Peripheral demux.
# =====================================================================
%>

<%def name="vsim_waves_core_periph_demux()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {periph_demux} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/periph_demux_i/*}
% endfor
</%def>

<%
# =====================================================================
# RISC-V CORE
# =====================================================================
%>

<%
# =====================================================================
# Title:        vsim_waves_core_if_stage
# Type:         Template API
# Description:  Instruction fetch stage.
# =====================================================================
%>

<%def name="vsim_waves_core_if_stage()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {riscv} -group {IF_stage} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/if_stage_i/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_core_id_stage
# Type:         Template API
# Description:  Instruction decode stage.
# =====================================================================
%>

<%def name="vsim_waves_core_id_stage()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {riscv} -group {ID_stage} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/id_stage_i/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_core_ex_stage
# Type:         Template API
# Description:  Execution stage.
# =====================================================================
%>

<%def name="vsim_waves_core_ex_stage()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {riscv} -group {EX_stage} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/ex_stage_i/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_core_lsu
# Type:         Template API
# Description:  Core load store unit (LSU).
# =====================================================================
%>

<%def name="vsim_waves_core_lsu()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {riscv} -group {LSU} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/load_store_unit_i/*}
% endfor
</%def>

<%
# =====================================================================
# INTERFACES
# =====================================================================
%>

<%
# =====================================================================
# Title:        vsim_waves_core_eu_ctrl
# Type:         Template API
# Description:  Event unit controller.
# =====================================================================
%>

<%def name="vsim_waves_core_eu_ctrl()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {eu_ctrl_master} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/eu_ctrl_master/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_core_cs_registers
# Type:         Template API
# Description:  Control status registers.
# =====================================================================
%>

<%def name="vsim_waves_core_cs_registers()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {cs_registers} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[${core_offset}]/core_region_i/RISCV_CORE/cs_registers_i/*}
% endfor
</%def>