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

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_bus
# Type:         Template API
# Description:  Cluster bus.
# =====================================================================
%>

<%def name="vsim_waves_cluster_bus()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_bus} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_bus_wrap_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_bus} -group {i_xbar} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_bus_wrap_i/i_xbar/*}
</%def>

<%
# =====================================================================
# Title:        vsim_waves_interconnect
# Type:         Template API
# Description:  Cluster interconnect.
# =====================================================================
%>

<%def name="vsim_waves_cluster_interconnect()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_interconnect} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_interconnect_wrap_i/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_interconnect} -group {tcdm_interco} -group {inputs} -label {s_core_tcdm_bus_add} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_interconnect_wrap_i/s_core_tcdm_bus_add}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_interconnect} -group {tcdm_interco} -group {inputs} -label {iconn_inp_wdata} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_interconnect_wrap_i/iconn_inp_wdata}

% for tcdm_bank_offset in range(cl_n_l1_banks):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_interconnect} -group {tcdm_sram_master} -group {tcdm_sram_master[${tcdm_bank_offset}]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_interconnect_wrap_i/tcdm_sram_master[${tcdm_bank_offset}]/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_cluster_core_periph_slave
# Type:         Template API
# Description:  Peripheral slave.
# =====================================================================
%>

<%def name="vsim_waves_cluster_core_periph_slave()">\
% for core_offset in range(cl_n_cores):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {riscv} -group {core_region[${core_offset}]} -group {core_periph_slave} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_interconnect_wrap_i/core_periph_slave[${core_offset}]/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_tcdm
# Type:         Template API
# Description:  Shared data memory (TCDM).
# =====================================================================
%>

<%def name="vsim_waves_cluster_tcdm()">\
% for tcdm_bank_offset in range(cl_n_l1_banks):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {sram} -group {intf_sram[${tcdm_bank_offset}]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/gen_tcdm_banks[${tcdm_bank_offset}]/i_tc_sram/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_icache
# Type:         Template API
# Description:  Instruction cache.
# =====================================================================
%>

<%def name="vsim_waves_cluster_icache()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {icache[0]} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/icache_top_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {icache[0]} -group {central_controller} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/icache_top_i/u_cache_controller_to_axi/CENTRAL_CONTROLLER/*}

</%def>

<%
# =====================================================================
# Title:        vsim_waves_peripherals
# Type:         Template API
# Description:  Cluster peripherals.
# =====================================================================
%>

<%def name="vsim_waves_cluster_peripherals()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {core_eu_direct_link[0]}  {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/core_eu_direct_link[0]/*}
</%def>

<%
# =====================================================================
# Title:        vsim_waves_cluster_dma_ooc_wrap
# Type:         Template API
# Description:  DMA OOC wrapper.
# =====================================================================
%>

<%def name="vsim_waves_cluster_dma_ooc_wrap()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {dma} -group {ext_master} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/dmac_wrap_i/ext_master/*}
</%def>

<%
# =====================================================================
# Title:        vsim_waves_cluster_speriph_mst
# Type:         Template API
# Description:  Cluster peripheral masters.
# =====================================================================
%>

<%def name="vsim_waves_cluster_speriph_mst(n_peripherals)">\
% for periph_offset in range(n_peripherals):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {speriph_master} -group {[${periph_offset}]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_interconnect_wrap_i/speriph_master[${periph_offset}]/*}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_cluster_event_unit
# Type:         Template API
# Description:  Event unit.
# =====================================================================
%>

<%def name="vsim_waves_cluster_event_unit()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {event_unit} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/event_unit_flex_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {event_unit} -group {soc_fifo} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/event_unit_flex_i/soc_periph_fifo_i/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {event_unit} -group {speriph_slave} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/event_unit_flex_i/speriph_slave/*}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {event_unit} -group {event_unit_interface_mux} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/event_unit_flex_i/event_unit_interface_mux_i/*}
</%def>

<%
# =====================================================================
# Title:        vsim_waves_cluster_timer_unit
# Type:         Template API
# Description:  Timer unit.
# =====================================================================
%>

<%def name="vsim_waves_cluster_timer_unit()">\
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {cluster_peripherals} -group {timer_unit} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/cluster_peripherals_i/cluster_timer_wrap_i/timer_unit_i/*}
</%def>
