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

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_richie_acc_intf
# Type:         Template API
# Description:  Overlay-to-accelerator interface
# =====================================================================
%>

${vsim_waves_richie_acc_intf()}

<%
###############
## HWPE top  ##
###############
%>

${vsim_waves_hwpe_top()}

<%
#################
## HWPE engine ##
#################
%>

${vsim_waves_hwpe_engine()}

<%
###########################
## HWPE datapath adapter ##
###########################
%>

% if acc_wr_is_ap_ctrl_hs == True:
${vsim_waves_hwpe_datapath_adapter_xil_ap_ctrl_hs()}
% endif

% if acc_wr_is_mdc_dataflow == True:
${vsim_waves_hwpe_datapath_adapter_mdc_dataflow()}
% endif

<%
#######################
## HWPE datapath HLS ##
#######################
%>

% if acc_wr_design_type == 'hls':
${vsim_waves_hwpe_datapath_HLS()}
% endif

<%
###################
## HWPE streamer ##
###################
%>

${vsim_waves_hwpe_streamer()}
${vsim_waves_hwpe_streamer_source()}
${vsim_waves_hwpe_streamer_sink()}
${vsim_waves_hwpe_streamer_addressgen()}

<%
#####################
## HWPE controller ##
#####################
%>

${vsim_waves_hwpe_ctrl()}
${vsim_waves_hwpe_ctrl_regfile()}
${vsim_waves_hwpe_ctrl_fsm()}
${vsim_waves_hwpe_ctrl_uloop()}
