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
# Title:        vsim_waves_hwpe_ctrl
# Type:         Template API
# Description:  HWPE controller
# =====================================================================
%>

<%def name="vsim_waves_hwpe_ctrl()">\

<%
# HWPE controller - Top
%>

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {top} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/*}

<%
# HWPE controller - Slave
%>

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {slave} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_slave/*}

<%
# Slave port of HWPE controller exposed on the peripheral interconnect
%>

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {slave_periph_port} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_slave/cfg/*}

</%def>

<%
# =====================================================================
# Title:        vsim_waves_hwpe_ctrl_regfile
# Type:         Template API
# Description:  HWPE register file
# =====================================================================
%>

<%def name="vsim_waves_hwpe_ctrl_regfile()">\
add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {regfile} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_slave/i_regfile/*}
</%def>

<%
# =====================================================================
# Title:        vsim_waves_hwpe_ctrl_uloop
# Type:         Template API
# Description:  HWPE uloop
# =====================================================================
%>

<%def name="vsim_waves_hwpe_ctrl_uloop()">\

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {lic_acc_region} -group {acc_${acc_wr_target}[${extra_param_1}]} -group {ctrl} -group {uloop} -group {top} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/i_${acc_wr_target}_top/i_ctrl/i_uloop/*}

</%def>
