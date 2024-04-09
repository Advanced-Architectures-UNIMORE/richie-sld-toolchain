<%
'''
    =====================================================================

    Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia

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

    Description:    PULP cluster configuration package.

    Date:           29.12.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
# =====================================================================
# Title:        def_param_hwpe_hci_region
# Type:         Template API
# Description:  Definition of parameters for HWPE-based accelerator 
#               wrappers in the accelerator region.
# =====================================================================
%>

<%def name="def_param_hwpe_hci_region()">\

  <%
    # Check and count HWPE-based wrappers.

    n_hwpe_hci = 0

    for acc_prot in cl_hci_acc_protocols:
      if acc_prot == "hwpe":
        n_hwpe_hci += 1
  %>

  % if (n_hwpe_hci > 0):
    localparam bit HWPE_HCI_PRESENT                   = 1'b1;
  % else:
    localparam bit HWPE_HCI_PRESENT                   = 1'b0;
  % endif

    localparam int N_HWPE_HCI                     = ${n_hwpe_hci};

</%def>\

<%
# =====================================================================
# Title:        def_param_hwpe_hci_interface
# Type:         Template API
# Description:  Definition of parameters for the HCI interconnection of 
#               HWPE-based accelerator wrappers.
# =====================================================================
%>

<%def name="def_param_hwpe_hci_interface()">\

  <%
    # Count number of wrappers

    n_acc_cl = len(cl_hci_acc_names)

    # Count number of data ports associated to HWPE-based wrappers

    n_hwpe_ports_total = 0
    
    for acc_offset in range(n_acc_cl):
      if (cl_hci_acc_protocols[acc_offset] == "hwpe"):
        n_hwpe_ports_total += cl_hci_acc_n_data_ports[acc_offset]
  %>

  % for acc_offset in range(n_acc_cl):
    % if cl_hci_acc_protocols[acc_offset] == "hwpe":
    localparam int N_HWPE_LIC_PORTS_WRAPPER_${acc_offset}             = ${cl_hci_acc_n_data_ports[acc_offset]};
    % endif
  % endfor

    localparam int unsigned N_HWPE_HCI_PORTS_TOTAL    = ${n_hwpe_ports_total};

</%def>\
