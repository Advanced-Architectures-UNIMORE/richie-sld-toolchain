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

    Description:    HWPE kernel adapter.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
##############################################
## Kernel adapter interface - MDC dataflow  ##
##############################################
%>

<%
##################################################
## Kernel adapter interface - Control interface ##
##################################################
%>

<%def name="mdc_dataflow_engine_ctrl()">\

  // Control signals
  input  ctrl_kernel_adapter_${acc_wr_target}_t           ctrl_i,

</%def>

<%
################################################
## Kernel adapter interface - Flags interface ##
################################################
%>

<%def name="mdc_dataflow_engine_flags()">\

  // Flag signals
  output  flags_kernel_adapter_${acc_wr_target}_t           flags_o
\
</%def>