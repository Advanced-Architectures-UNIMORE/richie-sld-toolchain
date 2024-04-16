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

    Description:    HWPE architecture macros.

    Date:           11.6.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
############################################
## Library of components - Standard archi ##
############################################
%>

<%
#########################################
## Standard archi - Offset declaration ##
#########################################
%>

<%def name="standard_archi(addr_current)">\

#define ${target.upper()}_REG_NB_ITER                         ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_LINESTRIDE                ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_TILESTRIDE                ${hex(addr_current)}

        <%
          addr_current += 4
        %>

  % if is_hls_stream is True:
    % for i in range (n_sink):
  #define ${target.upper()}_REG_PACKET_SIZE_${stream_in[i].upper()}                 ${hex(addr_current)}
        <%
          addr_current += 4
        %>
    % endfor
  % endif

  % for j in range (n_source):
#define ${target.upper()}_REG_CNT_LIMIT_${stream_out[j].upper()}                 ${hex(addr_current)}
        <%
          addr_current += 4
        %>
  % endfor

</%def>
