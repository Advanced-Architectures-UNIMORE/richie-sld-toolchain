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

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_hw_accelerator
# Type:         Template API
# Description:  Hardware accelerator
# =====================================================================
%>

<%def name="vsim_waves_hw_accelerator()">\

% if (acc_wr_is_ap_ctrl_hs == True) or (acc_wr_is_hls_stream == True):
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {engine} -group {accelerator} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/i_${acc_wr_target}/*}
% endif

% if acc_wr_is_mdc_dataflow == True:
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {engine} -group {accelerator} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/i_${acc_wr_target}_reconf_datapath_top/reconf_dpath/*}
% endif

</%def>

<%
# =====================================================================
# Title:        vsim_waves_accelerator_datapath_adapter
# Type:         Template API
# Description:  Accelerator datapath adapter
# =====================================================================
%>

<%def name="vsim_waves_accelerator_datapath_adapter()">\

% if (acc_wr_is_ap_ctrl_hs == True) or (acc_wr_is_hls_stream == True):
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {engine} -group {adapter} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/*}
% endif

% if acc_wr_is_mdc_dataflow == True:
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {engine} -group {adapter} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/*}
% endif

</%def>
