<%
'''
    =====================================================================

    Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia

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

    Date:           29.12.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_lic_acc_region
# Type:         Template API
# Description:  Cluster accelerator interface
# =====================================================================
%>

<%def name="vsim_waves_lic_acc_region(n_acc_cl)">\

% if (n_acc_cl>0):

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {accelerators} -group {lic_acc_region} -group {top} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/*}

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {accelerators} -group {lic_acc_region} -group {events} -label {cl_event} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/evt_o}
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {accelerators} -group {lic_acc_region} -group {events} -label {acc_event} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/hwpe_evt}

  <%
    mst_port_offset_L = 0
    mst_port_offset_H = 0
  %>

  % for acc_offset in range(n_acc_cl):

    <%
      if (cl_lic_acc_protocols[acc_offset] == "hwpe"):
        if (acc_offset == 0):
          mst_port_offset_L = 0
          mst_port_offset_H = cl_lic_acc_n_data_ports[acc_offset] - 1
        else:
          mst_port_offset_L = cl_lic_acc_n_data_ports[acc_offset-1] + mst_port_offset_L
          mst_port_offset_H = cl_lic_acc_n_data_ports[acc_offset] + mst_port_offset_H
    %>

    % for port_offset in range(mst_port_offset_L, mst_port_offset_H+1):
add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {accelerators} -group {lic_acc_region} -group {wrapper[${acc_offset}]} -group {hwpe_xbar_master[${port_offset}]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/hwpe_xbar_master[${port_offset}]/*}
    % endfor

add wave -noupdate -group {pulp_cluster[${cl_id}]} -group {accelerators} -group {lic_acc_region} -group {wrapper[${acc_offset}]} -group {hwpe_cfg_slave[${acc_offset}]} {/richie_tb/dut/gen_clusters[${cl_id}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/hwpe_cfg_slave[${acc_offset}]/*}
  % endfor

% endif

</%def>
