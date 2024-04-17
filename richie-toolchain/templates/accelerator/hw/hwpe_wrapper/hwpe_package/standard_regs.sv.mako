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
################################################
## Library of components - Standard registers ##
################################################
%>

<%
#############################################
## Standard registers - Offset declaration ##
#############################################
%>

<%def name="standard_regs(addr_current)">\

  parameter int unsigned ${acc_wr_target.upper()}_REG_NB_ITER              = ${addr_current};

        <%
          addr_current += 1
        %>

  parameter int unsigned ${acc_wr_target.upper()}_REG_SHIFT_LINESTRIDE     = ${addr_current};

        <%
          addr_current += 1
        %>

  parameter int unsigned ${acc_wr_target.upper()}_REG_SHIFT_TILESTRIDE     = ${addr_current};

        <%
          addr_current += 1
        %>

  % if acc_wr_is_hls_stream is True:
    % for i in range (acc_wr_n_sink):
  parameter int unsigned ${TARGET}_REG_PACKET_SIZE_${acc_wr_stream_in[i].upper()}     = ${addr_current};
        <%
          addr_current += 1
        %>
    % endfor
  % endif

  % for j in range (acc_wr_n_source):
  parameter int unsigned ${TARGET}_REG_CNT_LIMIT_${acc_wr_stream_out[j].upper()}     = ${addr_current};
        <%
          addr_current += 1
        %>
  % endfor

</%def>
