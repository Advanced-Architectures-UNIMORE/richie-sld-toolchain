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

/* =====================================================================
 *
 * Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * =====================================================================
 *
 * Project:         Richie
 *
 * Title:           pulp_cluster_${cl_id}_cfg_pkg.sv
 *
 * Description:     PULP cluster configuration package.
 *
 * Date:            29.12.2021
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */


package automatic pulp_cluster_${cl_id}_cfg_pkg;

    <%
        # Definition of parameters for proxy core
    %>

    // -- RISC-V cores
    localparam int unsigned CORE_NAME = "${cl_core_name.upper()}";
    // Notes:
    // - instead of using the core name, information has to be propagated in the RTL as a numeric value (core type = 0, 1, etc.)

    localparam int unsigned N_CORES = ${cl_n_cores};
    // Notes:
    // - must be a power of 2 and <= 8
    // - all clusters have same number of cores

    <%
        # Definition of parameters for HWPE-based accelerator interfaces
    %>

    // -- HWPE wrapper - LIC interconnect
    ${def_param_hwpe_lic_region()}
    ${def_param_hwpe_lic_interface()}

    // -- HWPE wrapper - HCI interconnect
    ${def_param_hwpe_hci_region()}
    ${def_param_hwpe_hci_interface()}

    <%
        # Definition of parameters for DMA engine
    %>

    // -- DMA
    localparam int unsigned N_DMAS = ${n_dma}; // Default: 4
                                            // Larger values seem to break the cluster
    localparam int unsigned DMA_FIFO_DEPTH_REQ = ${cl_dma_max_n_reqs};
                                            // Maximum number of requests the DMA can handle in flight
    localparam int unsigned DMA_MAX_N_TXNS = ${cl_dma_max_n_txns}; // Default: N_CORES
                                            // Maximum number of transactions the DMA can have in flight
    localparam int unsigned DMA_STREAMS = ${cl_dma_n_dma_streams}; // Default: 1
    localparam int unsigned DMA_MAX_BURST_SIZE = ${cl_dma_max_burst_size}; // Default: 2048 [B], must be a power of 2

    <%
        # Definition of parameters for memory hierarchy
    %>

    // -- Instruction Cache
    localparam int unsigned ICACHE_SIZE = 4096; // [B], must be a power of 2

    // -- TCDM
    localparam int unsigned N_TCDM_BANKS = ${cl_n_l1_banks}; // must be a power of 2
    localparam int unsigned TCDM_SIZE = ${cl_l1_size}; // [B], must be a power of 2

    // TCDM interconnect
    localparam bit L1_AMO_PRESENT = 1'b0;

    <%
        # Definition of parameters for cluster peripheral interconnect

        # Count number of accelerator interfaces
        n_acc_cl = len(cl_lic_acc_names)
    %>

    // position of HWPE peripherals on slave port of periph interconnect
    localparam int unsigned N_SPERIPHS_HWPE = N_HWPE_LIC + N_HWPE_HCI;
    localparam int unsigned N_SPERIPHS      = N_SPERIPHS_HWPE + 8;

% for i in range(n_acc_cl):
<%
    # Define accelerator offset
    acc_offset = i
%>\
    % if (cl_lic_acc_protocols[acc_offset] == "hwpe"):
    localparam SPER_HWPE_${acc_offset}_ID      = 8 + ${acc_offset};
    % endif
% endfor

endpackage
