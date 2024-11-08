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

    Description:    Accelerator testbench.

    Date:           1.9.2020

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
###########################################################
## Library of components - Testbench integration of HWPE ##
###########################################################
%>

<%
########################################################
## Testbench integration of HWPE - TCDM master ports  ##
########################################################
%>

<%def name="hwpe_master_ports()">\

  <%
    # Number of HWPE master ports attached to the loagrithmic interconnect.
    n_ports = 0
  %>

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for i in range (acc_wr_in_parallelism_factor[i]):
        <%
          n_ports += 1
        %>
      % endfor
    % else:
      <%
        n_ports += 1
      %>
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for j in range (acc_wr_out_parallelism_factor[j]):
        <%
          n_ports += 1
        %>
      % endfor
    % else:
      <%
        n_ports += 1
      %>
    % endif
  % endfor

${n_ports};

</%def>

<%
########################################################
## Testbench integration of HWPE - TCDM master ports  ##
########################################################
%>

<%def name="hwpe_dut()">\

  ${acc_wr_target}_top_wrap #(
    .N_CORES          ( NC ),
    .MP               ( MP ),
    .ID               ( ID )
  ) i_${acc_wr_target}_top_wrap (
    .clk_i          ( clk_i          ),
    .rst_ni         ( rst_ni         ),
    .test_mode_i    ( 1'b0           ),
    .tcdm_add       ( tcdm_add       ),
    .tcdm_be        ( tcdm_be        ),
    .tcdm_data      ( tcdm_data      ),
    .tcdm_gnt       ( tcdm_gnt       ),
    .tcdm_wen       ( tcdm_wen       ),
    .tcdm_req       ( tcdm_req       ),
    .tcdm_r_data    ( tcdm_r_data    ),
    .tcdm_r_valid   ( tcdm_r_valid   ),
    .periph_add     ( periph_add     ),
    .periph_be      ( periph_be      ),
    .periph_data    ( periph_data    ),
    .periph_gnt     ( periph_gnt     ),
    .periph_wen     ( periph_wen     ),
    .periph_req     ( periph_req     ),
    .periph_id      ( periph_id      ),
    .periph_r_data  ( periph_r_data  ),
    .periph_r_valid ( periph_r_valid ),
    .periph_r_id    ( periph_r_id    ),
    .evt_o          ( evt            )
  );

</%def>


