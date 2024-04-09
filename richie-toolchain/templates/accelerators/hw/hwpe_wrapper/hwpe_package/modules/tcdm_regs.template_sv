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

    Description:    HWPE package.

    Date:           11.6.2021

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
############################################
## Library of components - TCDM registers ##
############################################
%>

<%
#####################################################
## TCDM registers - Master port offset declaration ##
#####################################################
%>

<%def name="tcdm_master_regs(addr_current)">\

  // TCDM

  // Input ports
  % for i in range (n_sink):
    % if (is_parallel_in[i]):
  parameter int unsigned ${target.upper()}_REG_${stream_in[i].upper()}_ADDR                = ${addr_current};
    % else:
  parameter int unsigned ${target.upper()}_REG_${stream_in[i].upper()}_ADDR                = ${addr_current};
    % endif
        <%
          addr_current += 1
        %>
  % endfor

  // Output ports
  % for j in range (n_source):
    % if (is_parallel_out[j]):
  parameter int unsigned ${target.upper()}_REG_${stream_out[j].upper()}_ADDR                = ${addr_current};
    % else:
  parameter int unsigned ${target.upper()}_REG_${stream_out[j].upper()}_ADDR                = ${addr_current};
    % endif
        <%
          addr_current += 1
        %>
  % endfor

</%def>
