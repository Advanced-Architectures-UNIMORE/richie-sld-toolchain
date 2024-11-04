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
################################################################
## HWPE datapath adapter - Xilinx ap_ctrl_hs (refer to UG902) ##
################################################################
%>

<%def name="vsim_waves_hwpe_datapath_HLS()">\

add wave -noupdate -group {HWPE ${acc_wr_target}} -group {hwpe_${acc_wr_target}_datapath_HLS} {/pulp_tb/dut/gen_clusters[0]/gen_cluster_sync/i_cluster/i_ooc/i_bound/hwpe_gen/hwpe_wrap_i/i_hwpe_top_wrap/i_${acc_wr_target}_top/i_engine/i_${acc_wr_target}_adapter/i_${acc_wr_target}/*}

</%def>
