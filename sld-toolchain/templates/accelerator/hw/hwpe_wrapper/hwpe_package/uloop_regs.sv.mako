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
###########################################################
## Library of components - Microcode processor registers ##
###########################################################
%>

<%
########################################################
## Microcode processor registers - Offset declaration ##
########################################################
%>

<%def name="uloop_regs(addr_current)">\

  /* Microcode processor */

  // offset indeces -- this should be aligned to the microcode compiler of course!
  % for i in range (acc_wr_n_sink):
  parameter int unsigned ${acc_wr_target.upper()}_UCODE_${acc_wr_stream_in[i].upper()}_OFFS               = ${addr_current+i};
  % endfor

        <%
          addr_current += acc_wr_n_sink
        %>

  % for j in range (acc_wr_n_source):
  parameter int unsigned ${acc_wr_target.upper()}_UCODE_${acc_wr_stream_out[j].upper()}_OFFS              = ${addr_current+j};
  % endfor

  // mnemonics -- this should be aligned to the microcode compiler of course!

        <%
          addr_current = 0
        %>

  parameter int unsigned ${acc_wr_target.upper()}_UCODE_MNEM_NBITER      = ${addr_current};

        <%
          addr_current += 1
        %>

  parameter int unsigned ${acc_wr_target.upper()}_UCODE_MNEM_ITERSTRIDE  = ${addr_current};

        <%
          addr_current += 1
        %>

  parameter int unsigned ${acc_wr_target.upper()}_UCODE_MNEM_ONESTRIDE   = ${addr_current};

        <%
          addr_current += 1
        %>

  parameter int unsigned ${acc_wr_target.upper()}_UCODE_MNEM_TILESTRIDE  = ${addr_current};

</%def>
