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

    Description:    Peripheral accelerato interface.

    Date:           19.1.2022

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
 * Title:           pulp_cluster_${cl_id}_periph_acc_intf.sv
 *
 * Description:     The peripheral accelerator interface routes the slave 
 *                  peripheral signals toward the slave port of HWPE-based
 *                  accelerators.
 *
 * Date:            19.1.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

<%
  # Count number of wrappers

  n_acc_cl = len(cl_lic_acc_names)
%>

module periph_acc_intf
#(
  parameter NB_SPERIPHS       = 8,
  parameter NB_SPERIPHS_HWPE  = 0
)
(
  input  logic                                        clk,
  input  logic                                        rst_n,
  input  logic                                        test_mode,

  XBAR_PERIPH_BUS.Slave                               speriph_hwpe_slave[NB_SPERIPHS_HWPE-1:0],
  XBAR_PERIPH_BUS.Master                              hwpe_cfg_master[NB_SPERIPHS_HWPE-1:0]
);

  % for i in range(n_acc_cl): 
    <%
      # Define accelerator offset

      acc_offset = i
    %>
    % if (cl_lic_acc_protocols[acc_offset] == "hwpe"):

  // Wrapper #${acc_offset}
  localparam HWPE_${acc_offset}_ID = pulp_cluster_${cl_id}_cfg_pkg::SPER_HWPE_${acc_offset}_ID - (NB_SPERIPHS - NB_SPERIPHS_HWPE);

  assign speriph_hwpe_slave[HWPE_${acc_offset}_ID].gnt     = hwpe_cfg_master[${acc_offset}].gnt;
  assign speriph_hwpe_slave[HWPE_${acc_offset}_ID].r_rdata = hwpe_cfg_master[${acc_offset}].r_rdata;
  assign speriph_hwpe_slave[HWPE_${acc_offset}_ID].r_opc   = hwpe_cfg_master[${acc_offset}].r_opc;
  assign speriph_hwpe_slave[HWPE_${acc_offset}_ID].r_id    = hwpe_cfg_master[${acc_offset}].r_id;
  assign speriph_hwpe_slave[HWPE_${acc_offset}_ID].r_valid = hwpe_cfg_master[${acc_offset}].r_valid;
  
  assign hwpe_cfg_master[${acc_offset}].req   = speriph_hwpe_slave[HWPE_${acc_offset}_ID].req;
  assign hwpe_cfg_master[${acc_offset}].add   = speriph_hwpe_slave[HWPE_${acc_offset}_ID].add;
  assign hwpe_cfg_master[${acc_offset}].wen   = speriph_hwpe_slave[HWPE_${acc_offset}_ID].wen;
  assign hwpe_cfg_master[${acc_offset}].wdata = speriph_hwpe_slave[HWPE_${acc_offset}_ID].wdata;
  assign hwpe_cfg_master[${acc_offset}].be    = speriph_hwpe_slave[HWPE_${acc_offset}_ID].be;
  assign hwpe_cfg_master[${acc_offset}].id    = speriph_hwpe_slave[HWPE_${acc_offset}_ID].id;
    % endif
  % endfor

endmodule