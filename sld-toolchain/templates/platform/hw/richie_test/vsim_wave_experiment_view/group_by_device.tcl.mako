<%
'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

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

    Date:           13.10.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_group_by_device
# Type:         Template API
# Description:  Waves grouped by device.
# =====================================================================
%>

<%def name="vsim_waves_group_by_device()">\
% for i_l2_bank in range(n_l2_banks):
add wave -noupdate -group {exp_view_by_device} -group {l2} -label {l2[${i_l2_bank}]-W-valid} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_valid}
add wave -noupdate -group {exp_view_by_device} -group {l2} -label {l2[${i_l2_bank}]-W-ready} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_ready}
add wave -noupdate -group {exp_view_by_device} -group {l2} -label {l2[${i_l2_bank}]-R-valid} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_valid}
add wave -noupdate -group {exp_view_by_device} -group {l2} -label {l2[${i_l2_bank}]-R-ready} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_ready}
% endfor

% for cl_id in range(n_clusters):

    <%
        # Additional design knobs
        cl_lic_acc_names = extra_param_0.list_cl_lic[cl_id][1]
        cl_lic_acc_protocols = extra_param_0.list_cl_lic[cl_id][2]
        cl_lic_acc_n_data_ports = extra_param_0.list_cl_lic[cl_id][3]

        n_acc_cl = len(cl_lic_acc_names)
    %>
add wave -noupdate -group {exp_view_by_device} -group {proxy} -label {proxy[${cl_id},0]-CLK-en}  {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[0]/core_region_i/clock_en_i}
add wave -noupdate -group {exp_view_by_device} -group {proxy} -label {proxy[${cl_id},0]-INSTR-req}  {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/CORE[0]/core_region_i/instr_req_o}

% for i_l1_bank in range(cl_n_l1_banks):
add wave -noupdate -group {exp_view_by_device} -group {l1} -label {l1[${cl_id},${i_l1_bank}]-req} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/gen_tcdm_banks[${i_l1_bank}]/i_tc_sram/req_i}
% endfor

add wave -noupdate -group {exp_view_by_device} -group {dma} -label {dma[${cl_id},0]-W-valid} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/dmac_wrap_i/ext_master/w_valid}
add wave -noupdate -group {exp_view_by_device} -group {dma} -label {dma[${cl_id},0]-W-ready} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/dmac_wrap_i/ext_master/w_ready}
add wave -noupdate -group {exp_view_by_device} -group {dma} -label {dma[${cl_id},0]-R-valid} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/dmac_wrap_i/ext_master/r_valid}
add wave -noupdate -group {exp_view_by_device} -group {dma} -label {dma[${cl_id},0]-R-ready} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/dmac_wrap_i/ext_master/r_ready}

    % for acc_id in range(n_acc_cl):

        <%
            if (cl_lic_acc_protocols[acc_id] == "hwpe"):
                if (acc_id == 0):
                    mst_port_offset_L = 0
                    mst_port_offset_H = cl_lic_acc_n_data_ports[acc_id] - 1
                else:
                    mst_port_offset_L = cl_lic_acc_n_data_ports[acc_id-1] + mst_port_offset_L
                    mst_port_offset_H = cl_lic_acc_n_data_ports[acc_id] + mst_port_offset_H
        %>

        % for port_offset in range(mst_port_offset_L, mst_port_offset_H+1):
add wave -noupdate -group {exp_view_by_device} -group {acc} -label {${cl_lic_acc_names[acc_id].upper()}[${cl_id},${acc_id},${port_offset}]-req} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/hwpe_xbar_master[${port_offset}]/req}
        % endfor

    % endfor
% endfor
</%def>
