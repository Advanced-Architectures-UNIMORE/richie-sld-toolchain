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
# =====================================================================
# Title:        vsim_waves_axi_mst
# Type:         Template API
# Description:  Cluster AXI master ports.
# =====================================================================
%>

<%def name="vsim_waves_hesoc_cluster_axi_inputs(cluster_offset)">\
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_id}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_addr}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_len}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_size}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_burst}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_lock}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_cache}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_prot}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_qos}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_region}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_atop}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_user}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_valid}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/aw_ready}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/w_data}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/w_strb}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/w_last}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/w_user}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/w_valid}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/w_ready}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/b_id}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/b_resp}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/b_user}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/b_valid}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/b_ready}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_id}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_addr}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_len}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_size}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_burst}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_lock}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_cache}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_prot}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_qos}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_region}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_user}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_valid}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/ar_ready}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_id}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_data}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_resp}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_last}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_user}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_valid}
add wave -noupdate -group {HeSoC} -group {pulp_cluster[${cluster_offset}]} -group {cl_inp[${cluster_offset}]} {/richie_tb/dut/cl_inp[${cluster_offset}]/r_ready}
</%def>
