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

    Description:    HWPE engine.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
#############################################
## Kernel adapter interface - MDC dataflow ##
#############################################
%>

<%
#################################################
## Kernel adapter interface - Custom registers ##
#################################################
%>

<%def name="mdc_dataflow_kernel_adapter_custom_regs()">\

    % if acc_wr_custom_reg_num>0:
    // Kernel parameters
      % for i in range (acc_wr_custom_reg_num):
        % if acc_wr_custom_reg_isport[i]:
    .${acc_wr_custom_reg_name[i]}        ( ctrl_i.${acc_wr_custom_reg_name[i]}      ),
        % endif
      % endfor
    % endif 

</%def>

<%
#########################################
## Kernel adapter interface - Controls ##
#########################################

# Reference flags mapping: map_engine_ctrl_v1_hls
%>

<%def name="mdc_dataflow_kernel_adapter_ctrl()">\

    // Control signals
    .ctrl_i      ( ctrl_adapter            ),

</%def>

<%
######################################
## Kernel adapter interface - Flags ##
######################################

# Reference flags mapping: map_engine_flags_v1_hls
%>

<%def name="mdc_dataflow_kernel_adapter_flags()">\

    // Flag signals
    .flags_o       ( flags_adapter             )

</%def>