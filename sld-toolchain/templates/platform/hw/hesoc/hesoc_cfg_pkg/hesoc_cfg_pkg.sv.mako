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

    Description:    HeSoC configuration package.

    Date:           13.1.2022

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/* =====================================================================
 *
 * Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia
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
 * Title:           hesoc_cfg_pkg.sv
 *
 * Description:     HeSoC configuration package.
 *
 * Date:            13.1.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */


package automatic hesoc_cfg_pkg;

  <%
    # Definition of parameters for clock domain
  %>

  // -- Decoupling of cluster clock domain
  localparam bit          ASYNC = 1'b0;
  localparam int unsigned DC_BUF_W = 8;

  <%
    # Definition of parameters for AXI interfaces
  %>

  // -- AXI
  localparam int unsigned AXI_AW = 64; // [bit]
  localparam int unsigned AXI_DW = 64; // [bit]
  localparam int unsigned AXI_IW_MST = 6; // [bit]; do not change, seems to break instruction cache
  localparam int unsigned AXI_IW_SLV = 4; // [bit]
  localparam int unsigned AXI_UW = 4; // [bit]

  <%
    # Definition of parameters for clusters
  %>

  // -- Cluster
  localparam int unsigned N_CLUSTERS = ${n_clusters};

  <%
    # Definition of parameters for memory hierarchy
  %>

  // -- L2 Memory
  localparam int unsigned L2_SIZE = ${l2_size}; // [B], must be a power of 2
  localparam int unsigned L2_N_AXI_PORTS = ${n_l2_banks};
  localparam bit L2_AMO_PRESENT = 1'b0;

  <%
    # Definition of parameters for HeSoC interconnect
  %>

  // Maximum number of beats in a DMA burst on the HeSoC interconnect
  localparam int unsigned DMA_MAX_BURST_LEN = (pulp_cluster_${cl_id}_cfg_pkg::DMA_MAX_BURST_SIZE) / (AXI_DW/8); // to be possibly specified for each cluster on the basis of BW needs

  <%
    # Definition of data types
  %>

  typedef logic      [AXI_AW-1:0] addr_t;
  typedef logic             [5:0] cluster_id_t;
  typedef logic      [AXI_DW-1:0] data_t;
  typedef logic    [DC_BUF_W-1:0] dc_buf_t;
  typedef logic  [AXI_IW_MST-1:0] id_mst_t;
  typedef logic  [AXI_IW_SLV-1:0] id_slv_t;
  typedef logic    [AXI_DW/8-1:0] strb_t;
  typedef logic      [AXI_UW-1:0] user_t;

endpackage
