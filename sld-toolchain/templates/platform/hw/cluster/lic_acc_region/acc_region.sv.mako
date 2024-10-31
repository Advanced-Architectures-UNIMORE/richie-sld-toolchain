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

    Description:    PULP cluster accelerator region.

    Date:           29.12.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        def_ip_acc_region
# Type:         Template API
# Description:  Interface to Richie's cluster. Definition of module
#               interface to the LIC inside the Richie's cluster.
# =====================================================================
%>

<%def name="def_ip_acc_region()">\

  <%
    # Count number of accelerator interfaces
    n_acc_cl = len(cl_lic_acc_names)
  %>

  module lic_acc_region
  #(
    // Cluster
    parameter NB_CORES = 2,
    parameter ID_WIDTH = 8,

    // HWPE-based accelerator interfaces
    parameter NB_HWPE = 0,
    parameter NB_HWPE_LIC_PORTS_TOTAL = 0,
    % for acc_offset in range(n_acc_cl):
      % if cl_lic_acc_protocols[acc_offset] == "hwpe":
    parameter NB_HWPE_LIC_PORTS_WRAPPER_${acc_offset} = pulp_cluster_${cl_id}_cfg_pkg::N_HWPE_LIC_PORTS_WRAPPER_${acc_offset},
      % endif
    % endfor

    // Other parameters
    parameter N_DMA = 4,
    parameter N_EXT = 4,
    parameter N_MEM = 16,
    parameter N_MASTER_PORT = 4,
    parameter DEFAULT_DW = 32,
    parameter DEFAULT_AW = 32,
    parameter DEFAULT_BW = 8,
    parameter DEFAULT_WW = 10,
    parameter AWH = DEFAULT_AW
  )
  (
    input  logic                                        clk,
    input  logic                                        rst_n,
    input  logic                                        test_mode,

    XBAR_TCDM_BUS.Master                                hwpe_xbar_master[NB_HWPE_LIC_PORTS_TOTAL-1:0],
    XBAR_PERIPH_BUS.Slave                               hwpe_cfg_slave[NB_HWPE-1:0],

    output logic [NB_CORES-1:0][1:0]                    evt_o,
    output logic                                        busy_o
  );

</%def>
