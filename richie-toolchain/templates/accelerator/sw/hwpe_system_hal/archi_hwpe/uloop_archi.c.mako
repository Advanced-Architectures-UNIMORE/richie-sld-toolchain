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
#######################################################
## Library of components - Microcode processor archi ##
#######################################################
%>

<%
####################################################
## Microcode processor archi - Offset declaration ##
####################################################
%>

<%def name="uloop_archi(addr_current)">\

  /* Microcode processor */

        <%
          # Differently from the other archi components, here we set
          # *_REG_BYTECODE to addr_current, and then set the others with
          # new offsets. This is because we take advantage of the HAL
          # api "hwpe_bytecode_set()" to program the bytecode.
        %>

#define ${target.upper()}_REG_BYTECODE                                 ${hex(addr_current)}

        <%
          # Now let's re-initialize addr_current to 0
          # and associate 32b to each bytecode.
          addr_current = 0
        %>

#define ${target.upper()}_REG_BYTECODE0_OFFS                           ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_BYTECODE1_OFFS                           ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_BYTECODE2_OFFS                           ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_BYTECODE3_OFFS                           ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_BYTECODE4_OFFS                           ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_BYTECODE5_LOOPS0_OFFS                    ${hex(addr_current)}

        <%
          addr_current += 4
        %>

#define ${target.upper()}_REG_LOOPS1_OFFS                              ${hex(addr_current)}

</%def>
