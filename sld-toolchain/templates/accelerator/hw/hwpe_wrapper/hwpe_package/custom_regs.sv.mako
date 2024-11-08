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
##############################################
## Library of components - Custom registers ##
##############################################
%>

<%
###########################################
## Custom registers - Offset declaration ##
###########################################
%>

<%def name="custom_regs(addr_current)">\

  % if acc_wr_custom_reg_num>0:

  // Custom registers

    % for i in range (acc_wr_custom_reg_num):
        <% NAME=acc_wr_custom_reg_name[i].upper() %>
  parameter int unsigned ${acc_wr_target.upper()}_REG_${NAME}             = ${addr_current};
        <%
          addr_current += 1
        %>
    % endfor

  % endif

</%def>
