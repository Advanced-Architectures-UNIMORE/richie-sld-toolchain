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

    Title:          Python template tools

    Description:    Python tools that might come in useful inside the templates.

    Date:           29.12.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        print_cl_acc_names
# Type:         Template API
# Description:  Print names of accelerators inside CL[cl_id]
# =====================================================================
%>

<%def name="print_cl_acc_names(cl_interco_type)">\
<%
    str_acc = ""

    if (cl_interco_type=="lic"):
        n_acc = len(cl_lic_acc_names)
        if (n_acc > 0):
            for i in range(n_acc-1):
                str_acc += cl_lic_acc_names[i] + ", "
            str_acc += cl_lic_acc_names[n_acc-1]

    if (cl_interco_type=="hci"):
        n_acc = len(cl_hci_acc_names)
        if (n_acc > 0):
            for i in range(n_acc-1):
                str_acc += cl_hci_acc_names[i] + ", "
            str_acc += cl_hci_acc_names[n_acc-1]

%>\
${str_acc}\
</%def>\

<%
# =====================================================================
# Title:        print_cl_acc_n_data_ports
# Type:         Template API
# Description:  Print number of data ports associated with accelerators 
#               inside CL[cl_id]
# =====================================================================
%>

<%def name="print_cl_acc_n_data_ports(cl_interco_type)">\
<%
    str_acc = ""

    if (cl_interco_type=="lic"):
        n_acc = len(cl_lic_acc_n_data_ports)
        if (n_acc > 0):
            for i in range(n_acc-1):
                str_acc += str(cl_lic_acc_n_data_ports[i]) + ", "
            str_acc += str(cl_lic_acc_n_data_ports[n_acc-1])

    if (cl_interco_type=="hci"):
        n_acc = len(cl_hci_acc_n_data_ports)
        if (n_acc > 0):
            for i in range(n_acc-1):
                str_acc += str(cl_hci_acc_n_data_ports[i]) + ", "
            str_acc += str(cl_hci_acc_n_data_ports[n_acc-1])
%>\
${str_acc}\
</%def>\

<%
# =====================================================================
# Title:        print_cl_acc_protocols
# Type:         Template API
# Description:  Print communication protocols associated with accelerators 
#               inside CL[cl_id]
# =====================================================================
%>

<%def name="print_cl_acc_protocols(cl_interco_type)">\
<%
    str_acc = ""
    
    if (cl_interco_type=="lic"):
        n_acc = len(cl_lic_acc_protocols)
        if (n_acc > 0):
            for i in range(n_acc-1):
                str_acc += cl_lic_acc_protocols[i] + ", "
            str_acc += cl_lic_acc_protocols[n_acc-1]

    if (cl_interco_type=="hci"):
        n_acc = len(cl_hci_acc_protocols)
        if (n_acc > 0):
            for i in range(n_acc-1):
                str_acc += cl_lic_acc_protocols[i] + ", "
            str_acc += cl_hci_acc_protocols[n_acc-1]
%>\
${str_acc}\
</%def>\

    