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

    Date:           18.4.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        vsim_waves_hwpe
# Type:         Template API
# Description:  HWPE components.
# =====================================================================
%>

<%def name="vsim_waves_hwpe()">

<%
# =====================================================================
# Description:  HWPE top.
# =====================================================================
%>

${vsim_waves_hwpe_top()}

<%
# =====================================================================
# Description:  HWPE engine.
# =====================================================================
%>

${vsim_waves_hwpe_engine()}

<%
# =====================================================================
# Description:  Accelerator datapath adapter.
# =====================================================================
%>

${vsim_waves_accelerator_datapath_adapter()}

<%
# =====================================================================
# Description:  HW accelerator.
# =====================================================================
%>

${vsim_waves_hw_accelerator()}

<%
# =====================================================================
# Description:  HWPE streamer.
# =====================================================================
%>

% if (acc_wr_is_ap_ctrl_hs == True) or (acc_wr_is_hls_stream == True):
${vsim_waves_hwpe_streamer()}
${vsim_waves_hwpe_streamer_source()}
${vsim_waves_hwpe_streamer_sink()}
${vsim_waves_hwpe_streamer_addressgen()}
% endif

% if acc_wr_is_mdc_dataflow == True:
${vsim_waves_hwpe_streamer()}
% endif

<%
# =====================================================================
# Description:  HWPE controller.
# =====================================================================
%>

${vsim_waves_hwpe_ctrl()}
${vsim_waves_hwpe_ctrl_regfile()}
${vsim_waves_hwpe_ctrl_fsm()}
${vsim_waves_hwpe_ctrl_uloop()}

</%def>
