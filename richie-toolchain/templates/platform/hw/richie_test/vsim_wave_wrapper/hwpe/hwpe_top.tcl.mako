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
# Title:        vsim_waves_hwpe_top
# Type:         Template API
# Description:  HWPE top
# =====================================================================
%>

<%def name="vsim_waves_hwpe_top()">\

add wave -noupdate -group {pulp_cluster[${extra_param_0}]} -group {accelerators} -group {wrapper[${extra_param_1}]} -group {top} {/richie_tb/dut/gen_clusters[${extra_param_0}]/gen_cluster_sync/i_cluster/i_ooc/i_bound/lic_acc_region_gen/lic_acc_region_i/i_cl_${extra_param_0}_lic_intf_${extra_param_1}/i_top_wrap/*}

</%def>