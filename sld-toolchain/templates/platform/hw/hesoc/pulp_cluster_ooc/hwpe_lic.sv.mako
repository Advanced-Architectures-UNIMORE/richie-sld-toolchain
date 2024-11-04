<%
'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

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

    Description:    PULP cluster wrapper for FPGA OOC synthesis.

    Date:           13.1.2022

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        inst_param_hwpe_lic_region
# Type:         Template API
# Description:  Instantiation of parameters for HWPE-based accelerator
#               interfaces.
# =====================================================================
%>

<%def name="inst_param_hwpe_lic_region()">
    .HWPE_LIC_PRESENT         (pulp_cluster_${cl_id}_cfg_pkg::HWPE_LIC_PRESENT),
    .NB_HWPE_LIC              (pulp_cluster_${cl_id}_cfg_pkg::N_HWPE_LIC),
</%def>

<%
# =====================================================================
# Title:        inst_param_hwpe_lic_interface
# Type:         Template API
# Description:  Instantiation of parameters for the LIC interconnection of
#               HWPE-based accelerator interfaces.
# =====================================================================
%>

<%def name="inst_param_hwpe_lic_interface()">
    .NB_HWPE_LIC_PORTS_TOTAL  (pulp_cluster_${cl_id}_cfg_pkg::N_HWPE_LIC_PORTS_TOTAL),
</%def>
