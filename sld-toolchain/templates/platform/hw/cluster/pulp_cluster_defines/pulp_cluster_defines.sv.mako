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

    Description:    PULP cluster macros.

    Date:           23.11.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

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
 * Title:           pulp_cluster_${cl_id}_defines.sv
 *
 * Description:     The interface is positioned in between an accelerator
 *                  region and the top module of an accelerator wrapper.
 *                  The goal of the IP is to decompose the crossbar TCDM
 *                  master interface (from Richie's cluster) into the
 *                  single signals of the TCDM communication protocol.
 *
 * Date:            23.11.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

`ifndef PULP_CLUSTER_${cl_id}_DEFINES_SV
`define PULP_CLUSTER_${cl_id}_DEFINES_SV

<%
    # Definition of macros for instruction cache
%>

// WPI:
//  1. Differentiate on cluster ID to enable heterogeneous clusters
//  2. Wrap instruction caches and generate their wrapper where different versions are enabled through MACROs
//  3. In pulp_cluster find a way to instantiate different caches. Same also applies for HWPEs, clusters in HeSoC, etc. A common solution is needed.

// `define PULP_CLUSTER_PRIVATE_ICACHE
`define PULP_CLUSTER_MP_ICACHE

`endif
