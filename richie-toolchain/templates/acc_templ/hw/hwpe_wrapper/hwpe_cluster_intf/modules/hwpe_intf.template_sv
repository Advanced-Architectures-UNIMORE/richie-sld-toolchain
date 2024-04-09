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

    Description:    PULP cluster interface for HWPE accelerators.

    Date:           29.12.2021

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
# =====================================================================
# Title:        def_ip_hwpe_cluster_intf
# Type:         Template API
# Description:  Definition of module for HWPE cluster interface.
# =====================================================================
%>

<%def name="def_ip_hwpe_cluster_intf()">\
module ${target}_cluster_intf
#(
  parameter N_CORES = 2,
  parameter N_HWPE_PORTS = 2,
  parameter ID_WIDTH = 8
)
(
  input  logic                                        clk,
  input  logic                                        rst_n,
  input  logic                                        test_mode,

  XBAR_TCDM_BUS.Master                                hwpe_mst[N_HWPE_PORTS-1:0],
  XBAR_PERIPH_BUS.Slave                               hwpe_slv,

  output logic [N_CORES-1:0][1:0]                     evt_o,
  output logic                                        busy_o
);

</%def>

<%
# =====================================================================
# Title:        insert_ip_hwpe_wrapper
# Type:         Template API
# Description:  Instantiation of HWPE-based accelerator wrapper.
# =====================================================================
%>

<%def name="insert_ip_hwpe_wrapper()">\

  /* Local shared-memory interface. */

  logic [N_HWPE_PORTS-1:0]           tcdm_req;
  logic [N_HWPE_PORTS-1:0]           tcdm_gnt;
  logic [N_HWPE_PORTS-1:0] [32-1:0]  tcdm_add;
  logic [N_HWPE_PORTS-1:0]           tcdm_type;
  logic [N_HWPE_PORTS-1:0] [4 -1:0]  tcdm_be;
  logic [N_HWPE_PORTS-1:0] [32-1:0]  tcdm_wdata;
  logic [N_HWPE_PORTS-1:0] [32-1:0]  tcdm_r_rdata;
  logic [N_HWPE_PORTS-1:0]           tcdm_r_valid;

  /* Target accelerator wrapper. */
  % if is_third_party == False:
  ${target}_top_wrap #(
  % else:
    % if design_type == 'hls':
      % if is_mdc_dataflow == True:
  multi_dataflow_${target}_top_wrap #(
      % endif
    % endif
   % endif
    .N_CORES          ( N_CORES ),
    .MP               ( N_HWPE_PORTS ),
    .ID               ( ID_WIDTH )
  ) i_top_wrap (
    .clk_i          ( clk                           ),
    .rst_ni         ( rst_n                         ),
    .test_mode_i    ( test_mode                     ),
    .tcdm_add       ( tcdm_add                      ),
    .tcdm_be        ( tcdm_be                       ),
    .tcdm_data      ( tcdm_wdata                    ),
    .tcdm_gnt       ( tcdm_gnt                      ),
    .tcdm_wen       ( tcdm_type                     ),
    .tcdm_req       ( tcdm_req                      ),
    .tcdm_r_data    ( tcdm_r_rdata                  ),
    .tcdm_r_valid   ( tcdm_r_valid                  ),
    .periph_add     ( hwpe_slv.add                  ),
    .periph_be      ( hwpe_slv.be                   ),
    .periph_data    ( hwpe_slv.wdata                ),
    .periph_gnt     ( hwpe_slv.gnt                  ),
    .periph_wen     ( hwpe_slv.wen                  ),
    .periph_req     ( hwpe_slv.req                  ),
    .periph_id      ( hwpe_slv.id                   ),
    .periph_r_data  ( hwpe_slv.r_rdata              ),
    .periph_r_valid ( hwpe_slv.r_valid              ),
    .periph_r_id    ( hwpe_slv.r_id                 ),
    .evt_o          ( evt_o[0]                      )
  );

  /* Local control. */

  assign busy_o = 1'b1;
  genvar i;
  generate
    for (i=0;i<N_HWPE_PORTS;i++) begin : hwacc_binding
      assign hwpe_mst[i].req   = tcdm_req   [i];
      assign hwpe_mst[i].add   = tcdm_add   [i];
      assign hwpe_mst[i].wen   = tcdm_type  [i];
      assign hwpe_mst[i].wdata = tcdm_wdata [i];
      assign hwpe_mst[i].be    = tcdm_be    [i];
      // response channel
      assign tcdm_gnt     [i] = hwpe_mst[i].gnt;
      assign tcdm_r_rdata [i] = hwpe_mst[i].r_rdata;
      assign tcdm_r_valid [i] = hwpe_mst[i].r_valid;
    end
  endgenerate
endmodule

</%def>
