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

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
# =====================================================================
# Title:        insert_ip_hwpe_intf
# Type:         Template API
# Description:  Interface to HWPE-based accelerator wrapper. Instantiation
#               of HWPE-based accelerator wrapper(-s) connected to the
#               LIC inside a Richie's cluster.
# =====================================================================
%>

<%def name="insert_ip_hwpe_intf()">\

  <%
    # Count number of accelerator interfaces
    n_acc_cl = len(cl_lic_acc_names)
  %>

  logic [NB_CORES-1:0][1:0] hwpe_evt [NB_HWPE-1:0];
  logic hwpe_busy [NB_HWPE-1:0];

  % for i in range(n_acc_cl):
    % if cl_lic_acc_protocols[i] == "hwpe":

      <%
        # Determine accelerator offset

        acc_offset = i
      %>

  /* ---------------------------------------------------------- */

  /* Interface to accelerator #${acc_offset}. */

  ${def_param_master_port_idx(acc_offset)}

  ${cl_lic_acc_names[acc_offset]}_cluster_intf #(
    .N_CORES          ( NB_CORES  ),
    .N_HWPE_PORTS     ( NB_HWPE_LIC_PORTS_WRAPPER_${acc_offset}   ),
    .ID_WIDTH         ( ID_WIDTH )
  ) i_cl_${cl_id}_lic_intf_${acc_offset} (
    .clk              ( clk                                         ),
    .rst_n            ( rst_n                                       ),
    .test_mode        ( test_mode                                   ),
    .hwpe_mst         ( hwpe_xbar_master[mst_idx_${acc_offset}_H:mst_idx_${acc_offset}_L]  ),
    .hwpe_slv         ( hwpe_cfg_slave[${acc_offset}]                          ),
    .evt_o            ( hwpe_evt[${acc_offset}]                                  ),
    .busy_o           ( hwpe_busy[${acc_offset}]                                 )
  );

  assign hwpe_busy[${acc_offset}] = 1'b1;

    % endif
  % endfor

  /* ---------------------------------------------------------- */

  ${proc_signal_evt_o(n_acc_cl)}
  ${proc_signal_busy_o(n_acc_cl)}

endmodule

</%def>

<%
# =====================================================================
# Title:        def_param_master_port_idx
# Type:         Template API
# Description:  Definition and initialization of LIC port indices
#               associated with clustered HWPE-based accelerator wrapper(-s).
#               This is because the master ports are wrapped into an array
#               "hwacc_xbar_master[NB_HWPE_LIC_PORTS_TOTAL-1:0]" that is input
#               to the accelerator interface. The latter subsequently needs
#               to distribute the data ports to each accelerator wrapper.
#               This is accomplished using the indices defined below.
# =====================================================================
%>

<%def name="def_param_master_port_idx(acc_offset)">\

  <%
    is_first_hwpe = True

    str_H = ""
    str_L = ""
  %>

  <%
    # Scan all clustered accelerators till the current one
  %>

  % for i in range(acc_offset+1):

    <%
      # Only HWPE-based accelerator interfaces are currently supported
    %>

    % if cl_lic_acc_protocols[i] == "hwpe":

      <%
        # Construction of the string defining the indices
      %>

      % if is_first_hwpe is True:
        <%
          is_first_hwpe = False

          str_H = "NB_HWPE_LIC_PORTS_WRAPPER_" + str(i) + " - 1"
          str_L = "0"
        %>
      % else:
        <%
          str_H = "NB_HWPE_LIC_PORTS_WRAPPER_" + str(i) + " + " + str_H
        %>

        <%
          str_L = "NB_HWPE_LIC_PORTS_WRAPPER_" + str(i-1) + " + " + str_L
        %>
      % endif
    % endif
  % endfor

  <%
    # Definition and initialization of LIC port indices
  %>

  localparam mst_idx_${acc_offset}_H = ${str_H};
  localparam mst_idx_${acc_offset}_L = ${str_L};

</%def>

<%
# =====================================================================
# Title:        proc_signal_evt_o
# Type:         Template API
# Description:  Assign value of output event signal. This is a combination
#               of the event signals coming from each accelerator interface.
# =====================================================================
%>

<%def name="proc_signal_evt_o(n_acc_cl)">\
\
assign evt_o = \
% for i in range (n_acc_cl-1):
hwpe_evt[${i}] | \
% endfor
\
hwpe_evt[${n_acc_cl-1}];\
\
</%def>

<%
# =====================================================================
# Title:        proc_signal_busy_o
# Type:         Template API
# Description:  Assign value of output busy signal. This is a combination
#               of the busy signals coming from each accelerator interface.
# =====================================================================
%>

<%def name="proc_signal_busy_o(n_acc_cl)">\
\
assign busy_o = \
% for i in range (n_acc_cl-1):
hwpe_busy[${i}] | \
% endfor
\
hwpe_busy[${n_acc_cl-1}];\
\
</%def>
