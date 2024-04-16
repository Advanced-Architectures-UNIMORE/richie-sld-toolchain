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

/*
 *
 * Copyright (C) 2018 ETH Zurich, University of Bologna
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * Author: Francesco Conti <fconti@iis.ee.ethz.ch>
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: ${target}_package.sv
 *
 */

import hwpe_stream_package::*;

package ${target}_package;

  parameter int unsigned ${target.upper()}_CNT_LEN = 1024; // maximum length of the vectors for a scalar product

  /* Registers */

<%
##########################
## Addresses definition ##
##########################
%>

<%
    # Top offset - HWPE register file
    # Employed to start calculating the offset value pertaining to
    # a certain class of registers (standard, TCDM, and so on).

addr_top = 0

    # Current offset - HWPE register file
    # Employed to calculate the offset value to assign to a register
    # pertaining to a certain class (standard, TCDM, and so on).

addr_current = addr_top

    # HWPE parameters
    # At the moment, these are TCDM, standard, custom and address generator
    # registers. Their ordering has to match their counterpart in archi_hwpe
    # header file. The latter comprises the offsets of the physical memory
    # mapping of the HWPE registers. HWPE parameters are collected under the
    # 'ctrl_regfile_t' typedef defined in 'hwpe_ctrl'.
%>

  <%
  #####################################################
  ## TCDM registers - Master port offset declaration ##
  #####################################################
  %>

  ${tcdm_master_regs(addr_current)}

  <%
    addr_top += n_sink + n_source
    addr_current = addr_top
  %>

  <%
  #############################################
  ## Standard registers - Offset declaration ##
  #############################################
  %>

  // Standard registers
  ${standard_regs(addr_current)}

  <%
    # 1. a part of standard registers do not change with a variable number of IO streams.
    # 2. "cnt_limit" registers are always one per source stream (input), so they account for n_source items.
    # 3. in case of an hls::stream interface, then one register per source stream is added to specify the packet dimension (refer to AMBA® 4 AXI4-Stream Protocol).

    addr_top += (std_reg_num -1) + n_source

    if (is_hls_stream is True):
      addr_top += n_source
    endif

    addr_current = addr_top
  %>

  <%
  ###########################################
  ## Custom registers - Offset declaration ##
  ###########################################
  %>

  ${custom_regs(addr_current)}

  <%
    addr_top += custom_reg_num
    addr_current = addr_top
  %>

  <%
  ####################################################################
  ## Address generator registers - Input streams offset declaration ##
  ####################################################################
  %>

  ${addressgen_regs_in(addr_current)}

  <%
    # Each data port is associated to an address generator that
    # maps streams to TCDM addresses. To define an address are
    # required num_regs_per_port parameters to be defined.

    num_regs_per_port = 9

    # In case interface partitioning is employed, additional
    # parameters are added up to define the partitioned ports
    # offset and the data step. The latter is otherwise hardwired.

    num_regs_per_port_parallel = 10

    for i in range (n_sink):
      if (addr_gen_in_isprogr[i]):
        if (is_parallel_in[i]):
          addr_top += num_regs_per_port_parallel
        else:
          addr_top += num_regs_per_port
        endif
      endif
    endfor

    addr_current = addr_top
  %>

  <%
  #####################################################################
  ## Address generator registers - Output streams offset declaration ##
  #####################################################################
  %>

  ${addressgen_regs_out(addr_current)}

  <%
    # Each data port is associated to an address generator that
    # maps streams to TCDM addresses. To define an address are
    # required num_regs_per_port parameters to be defined.

    num_regs_per_port = 9

    # In case interface partitioning is employed, additional
    # parameters are added up to define the partitioned ports
    # offset and the data step. The latter is otherwise hardwired.

    num_regs_per_port_parallel = 10

    for j in range (n_source):
      if (addr_gen_out_isprogr[j]):
        if (is_parallel_out[j]):
          addr_top += num_regs_per_port_parallel
        else:
          addr_top += num_regs_per_port
        endif
      endif
    endfor

    addr_current = addr_top
  %>

  <%
  ########################################################
  ## Microcode processor registers - Offset declaration ##
  ########################################################
  %>

  <%
    addr_top = 0
    addr_current = addr_top
  %>

  ${uloop_regs(addr_current)}

  /* Typedefs */

  <%
  #######################
  ## Typedefs - Engine ##
  #######################
  %>

  typedef struct packed {
    logic clear;
    logic enable;
    logic start;

    % if is_hls_stream is True:
      % for i in range (n_sink):
    logic unsigned [23:0] packet_size_${stream_in[i]};
      % endfor
    % endif

    % for j in range (n_source):
      % if (is_parallel_out[j]):
    logic unsigned [$clog2(${target.upper()}_CNT_LEN):0] cnt_limit_${stream_out[j]};
      % else:
    logic unsigned [$clog2(${target.upper()}_CNT_LEN):0] cnt_limit_${stream_out[j]};
      % endif
    % endfor

    % if custom_reg_num>0:
    // Custom registers
      % for i in range (custom_reg_num):
    logic unsigned [${custom_reg_dim[i]}-1:0] ${custom_reg_name[i]};
      % endfor
    % endif
  } ctrl_engine_${target}_t;

  typedef struct packed {

    % for j in range (n_source):
      % if (is_parallel_out[j]):
    logic unsigned [$clog2(${target.upper()}_CNT_LEN):0] cnt_${stream_out[j]};
      % else:
    logic unsigned [$clog2(${target.upper()}_CNT_LEN):0] cnt_${stream_out[j]};
      % endif
    % endfor

    logic done;
    logic ready;
  } flags_engine_${target}_t;

  <%
  ###############################
  ## Typedefs - Kernel adapter ##
  ###############################
  %>

  typedef struct packed {
    logic start;
    % if is_hls_stream is True:
      % for i in range (n_sink):
    logic unsigned [23:0] packet_size_${stream_in[i]};
      % endfor
    % endif
  } ctrl_kernel_adapter_${target}_t;

  typedef struct packed {
    logic done;
    logic idle;
    logic ready;
    % if is_hls_stream is True:
    logic [${n_sink}-1:0] last;
    % endif


  } flags_kernel_adapter_${target}_t;

  <%
  #########################
  ## Typedefs - Streamer ##
  #########################
  %>

  typedef struct packed {

    % for i in range (n_sink):
      % if (is_parallel_in[i]):
        % for k in range (in_parallelism_factor[i]):
    hwpe_stream_package::ctrl_sourcesink_t ${stream_in[i]}_${k}_source_ctrl;
        % endfor
      % else:
    hwpe_stream_package::ctrl_sourcesink_t ${stream_in[i]}_source_ctrl;
      % endif
    % endfor

    % for j in range (n_source):
      % if (is_parallel_out[j]):
        % for k in range (out_parallelism_factor[j]):
    hwpe_stream_package::ctrl_sourcesink_t ${stream_out[j]}_${k}_sink_ctrl;
        % endfor
      % else:
    hwpe_stream_package::ctrl_sourcesink_t ${stream_out[j]}_sink_ctrl;
      % endif
    % endfor

  } ctrl_streamer_${target}_t;

  typedef struct packed {

    % for i in range (n_sink):
      % if (is_parallel_in[i]):
        % for k in range (in_parallelism_factor[i]):
    hwpe_stream_package::flags_sourcesink_t ${stream_in[i]}_${k}_source_flags;
        % endfor
      % else:
    hwpe_stream_package::flags_sourcesink_t ${stream_in[i]}_source_flags;
      % endif
    % endfor

    % for j in range (n_source):
      % if (is_parallel_out[j]):
        % for k in range (out_parallelism_factor[j]):
    hwpe_stream_package::flags_sourcesink_t ${stream_out[j]}_${k}_sink_flags;
        % endfor
      % else:
    hwpe_stream_package::flags_sourcesink_t ${stream_out[j]}_sink_flags;
      % endif
    % endfor

  } flags_streamer_${target}_t;

  <%
  ####################
  ## Typedefs - FSM ##
  ####################
  %>

  typedef struct packed {

    % for i in range (n_sink):
      % if (addr_gen_in_isprogr[i]):
        % if (is_parallel_in[i]):
    // Input stream - ${stream_in[i]} (unrolled, programmable)
    logic unsigned [31:0] ${stream_in[i]}_trans_size;
    logic unsigned [31:0] ${stream_in[i]}_port_offset;
    logic unsigned [15:0] ${stream_in[i]}_line_stride;
    logic unsigned [15:0] ${stream_in[i]}_line_length;
    logic unsigned [15:0] ${stream_in[i]}_feat_stride;
    logic unsigned [15:0] ${stream_in[i]}_feat_length;
    logic unsigned [15:0] ${stream_in[i]}_feat_roll;
    logic unsigned [15:0] ${stream_in[i]}_step;
    logic unsigned ${stream_in[i]}_loop_outer;
    logic unsigned ${stream_in[i]}_realign_type;
      % else:
    // Input stream - ${stream_in[i]} (programmable)
    logic unsigned [31:0] ${stream_in[i]}_trans_size;
    logic unsigned [15:0] ${stream_in[i]}_line_stride;
    logic unsigned [15:0] ${stream_in[i]}_line_length;
    logic unsigned [15:0] ${stream_in[i]}_feat_stride;
    logic unsigned [15:0] ${stream_in[i]}_feat_length;
    logic unsigned [15:0] ${stream_in[i]}_feat_roll;
    logic unsigned [15:0] ${stream_in[i]}_step;
    logic unsigned ${stream_in[i]}_loop_outer;
    logic unsigned ${stream_in[i]}_realign_type;
        % endif
      % endif
    % endfor

    % for j in range (n_source):
      % if (addr_gen_out_isprogr[j]):
        % if (is_parallel_out[j]):
    // Output stream - ${stream_out[j]} (unrolled, programmable)
    logic unsigned [31:0] ${stream_out[j]}_trans_size;
    logic unsigned [31:0] ${stream_out[j]}_port_offset;
    logic unsigned [15:0] ${stream_out[j]}_line_stride;
    logic unsigned [15:0] ${stream_out[j]}_line_length;
    logic unsigned [15:0] ${stream_out[j]}_feat_stride;
    logic unsigned [15:0] ${stream_out[j]}_feat_length;
    logic unsigned [15:0] ${stream_out[j]}_feat_roll;
    logic unsigned [15:0] ${stream_out[j]}_step;
    logic unsigned ${stream_out[j]}_loop_outer;
    logic unsigned ${stream_out[j]}_realign_type;
      % else:
    // Output stream - ${stream_out[j]} (programmable)
    logic unsigned [31:0] ${stream_out[j]}_trans_size;
    logic unsigned [15:0] ${stream_out[j]}_line_stride;
    logic unsigned [15:0] ${stream_out[j]}_line_length;
    logic unsigned [15:0] ${stream_out[j]}_feat_stride;
    logic unsigned [15:0] ${stream_out[j]}_feat_length;
    logic unsigned [15:0] ${stream_out[j]}_feat_roll;
    logic unsigned [15:0] ${stream_out[j]}_step;
    logic unsigned ${stream_out[j]}_loop_outer;
    logic unsigned ${stream_out[j]}_realign_type;
        % endif
      % endif
    % endfor

    // Computation
    % if is_hls_stream is True:
      % for i in range (n_sink):
    logic unsigned [23:0] packet_size_${stream_in[i]};
      % endfor
    % endif

    % for j in range (n_source):
    logic unsigned [$clog2(${target.upper()}_CNT_LEN):0] cnt_limit_${stream_out[j]};
    % endfor

    % if custom_reg_num>0:
    // Custom registers
      % for i in range (custom_reg_num):
    logic unsigned [${custom_reg_dim[i]}-1:0] ${custom_reg_name[i]};
      % endfor
    % endif

  } ctrl_fsm_${target}_t;

endpackage
