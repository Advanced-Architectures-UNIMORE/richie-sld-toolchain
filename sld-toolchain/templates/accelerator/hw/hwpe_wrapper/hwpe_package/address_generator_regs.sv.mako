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

    Description:    HWPE package.

    Date:           11.6.2021

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
###############################################
## Library of components - Address generator ##
###############################################
%>

<%
####################################################################
## Address generator registers - Input streams offset declaration ##
####################################################################
%>

<%def name="addressgen_regs_in(addr_current)">\

  <%
    # Each data port is associated to an address generator that
    # maps streams to TCDM addresses. To define an address are
    # required num_regs_per_port parameters to be defined.

    num_regs_per_port = 9

    # In case interface partitioning is employed, additional
    # parameters are added up to define the partitioned ports
    # offset and the data step. The latter is otherwise hardwired.

    num_regs_per_port_parallel = 10
  %>

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
      % if (acc_wr_is_parallel_in[i]):
    // Input stream - ${acc_wr_stream_in[i]} (unrolled, programmable)
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_TRANS_SIZE       = ${ addr_current + i * num_regs_per_port_parallel + 0 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_STRIDE      = ${ addr_current + i * num_regs_per_port_parallel + 1 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_LENGTH      = ${ addr_current + i * num_regs_per_port_parallel + 2 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_STRIDE      = ${ addr_current + i * num_regs_per_port_parallel + 3 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_LENGTH      = ${ addr_current + i * num_regs_per_port_parallel + 4 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_ROLL        = ${ addr_current + i * num_regs_per_port_parallel + 5 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LOOP_OUTER       = ${ addr_current + i * num_regs_per_port_parallel + 6 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_REALIGN_TYPE     = ${ addr_current + i * num_regs_per_port_parallel + 7 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_PORT_OFFSET      = ${ addr_current + i * num_regs_per_port_parallel + 8 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_STEP             = ${ addr_current + i * num_regs_per_port_parallel + 9 };
      % else:
    // Input stream - ${acc_wr_stream_in[i]} (programmable)
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_TRANS_SIZE       = ${ addr_current + i * num_regs_per_port + 0 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_STRIDE      = ${ addr_current + i * num_regs_per_port + 1 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_LENGTH      = ${ addr_current + i * num_regs_per_port + 2 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_STRIDE      = ${ addr_current + i * num_regs_per_port + 3 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_LENGTH      = ${ addr_current + i * num_regs_per_port + 4 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_ROLL        = ${ addr_current + i * num_regs_per_port + 5 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LOOP_OUTER       = ${ addr_current + i * num_regs_per_port + 6 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_REALIGN_TYPE     = ${ addr_current + i * num_regs_per_port + 7 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_STEP             = ${ addr_current + i * num_regs_per_port + 8 };
      % endif
    % endif
  % endfor

</%def>

<%
#####################################################################
## Address generator registers - Output streams offset declaration ##
#####################################################################
%>

<%def name="addressgen_regs_out(addr_current)">\

  <%
    # Each data port is associated to an address generator that
    # maps streams to TCDM addresses. To define an address are
    # required num_regs_per_port parameters to be defined.

    num_regs_per_port = 9

    # In case interface partitioning is employed, additional
    # parameters are added up to define the partitioned ports
    # offset and the data step. The latter is otherwise hardwired.

    num_regs_per_port_parallel = 10

  %>

  % for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
      % if (acc_wr_is_parallel_out[j]):
    // Output stream - ${acc_wr_stream_out[j]} (unrolled, programmable)
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_TRANS_SIZE       = ${ addr_current + j * num_regs_per_port_parallel + 0 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_STRIDE      = ${ addr_current + j * num_regs_per_port_parallel + 1 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_LENGTH      = ${ addr_current + j * num_regs_per_port_parallel + 2 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_STRIDE      = ${ addr_current + j * num_regs_per_port_parallel + 3 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_LENGTH      = ${ addr_current + j * num_regs_per_port_parallel + 4 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_ROLL        = ${ addr_current + j * num_regs_per_port_parallel + 5 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LOOP_OUTER       = ${ addr_current + j * num_regs_per_port_parallel + 6 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_REALIGN_TYPE     = ${ addr_current + j * num_regs_per_port_parallel + 7 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_PORT_OFFSET      = ${ addr_current + j * num_regs_per_port_parallel + 8 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_STEP             = ${ addr_current + j * num_regs_per_port_parallel + 9 };
      % else:
    // Output stream - ${acc_wr_stream_out[j]} (programmable)
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_TRANS_SIZE       = ${ addr_current + j * num_regs_per_port + 0 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_STRIDE      = ${ addr_current + j * num_regs_per_port + 1 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_LENGTH      = ${ addr_current + j * num_regs_per_port + 2 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_STRIDE      = ${ addr_current + j * num_regs_per_port + 3 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_LENGTH      = ${ addr_current + j * num_regs_per_port + 4 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_ROLL        = ${ addr_current + j * num_regs_per_port + 5 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LOOP_OUTER       = ${ addr_current + j * num_regs_per_port + 6 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_REALIGN_TYPE     = ${ addr_current + j * num_regs_per_port + 7 };
    parameter int unsigned ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_STEP             = ${ addr_current + j * num_regs_per_port + 8 };
      % endif
    % endif
  % endfor

</%def>

