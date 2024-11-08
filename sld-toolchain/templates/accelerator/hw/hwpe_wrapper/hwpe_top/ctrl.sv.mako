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

    Description:    HWPE top.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
#####################################
## Library of components - Control ##
#####################################
%>

<%
######################################
## Control - Number of IO registers ##
######################################
%>

<%
  # IO registers - What?
  # To this category grasp a number of classes of HWPE registers
  # that are required to to support the operations of the accelerated 
  # datapath. To this end, these registered are accessible by the cluster
  # cores that can thus execute R/W operations. These tipically include
  # standard and custom registers, as well those pertaining to programmability
  # of the streamer (e.g. address generator and TCDM master port addresses).
%>

<%def name="ctrl_n_io_regs()">\

<%
  # The methodology to calculate the number of IO registers is similar to the
  # offset calculation in the "hwpe_package" module. Basically, the registers
  # information that is specified by the user in the input specification file
  # is analyzed to gather the total amount of required entities. A "n_io_regs"
  # counter is incremented up to the final value that will be instantiated in 
  # the rendered SystemVerilog module.
%>

<%
  # Initialize n_io_regs counter 
  n_io_regs = 0
%>

<%
  # Counting standard registers

  # 1. a part of standard registers do not change with a variable number of IO streams ("nb_iter", "linestride", "tilestride").
  
  n_io_regs += acc_wr_std_reg_num - 1 
  
  # 2. "cnt_limit" registers are always one per source stream (input), so they account for acc_wr_n_source items.
  # The register information is used in the FSM to know how many engine "done" events terminate datapath execution.

  n_io_regs += acc_wr_n_source
  
  # 3. In case of an hls::stream interface, then one register per source stream is added to specify the packet dimension (refer to AMBA® 4 AXI4-Stream Protocol).
  
  n_io_regs += acc_wr_n_sink
%>

<%
  # Counting custom registers
  n_io_regs += acc_wr_custom_reg_num
%>

<%
  # Counting address generator registers - Input streams

  # Each data port is associated to an address generator that
  # maps streams to TCDM addresses. To define an address are
  # required num_regs_per_port parameters to be defined.

  num_regs_per_port = 9

  # In case interface partitioning is employed, additional
  # parameters are added up to define the partitioned ports 
  # offset and the data step. The latter is otherwise hardwired.

  num_regs_per_port_parallel = 10

  for i in range (acc_wr_n_sink):
    if (acc_wr_addr_gen_in_isprogr[i]):
      if (acc_wr_is_parallel_in[i]):
        n_io_regs += num_regs_per_port_parallel
      else:
        n_io_regs += num_regs_per_port
      endif
    endif
  endfor
%>

<%
  # Counting address generator registers - Output streams

  # Each data port is associated to an address generator that
  # maps streams to TCDM addresses. To define an address are
  # required num_regs_per_port parameters to be defined.

  num_regs_per_port = 9

  # In case interface partitioning is employed, additional
  # parameters are added up to define the partitioned ports 
  # offset and the data step. The latter is otherwise hardwired.

  num_regs_per_port_parallel = 10

  for j in range (acc_wr_n_source):
    if (acc_wr_addr_gen_out_isprogr[j]):
      if (acc_wr_is_parallel_out[j]):
        n_io_regs += num_regs_per_port_parallel
      else:
        n_io_regs += num_regs_per_port
      endif
    endif
  endfor
%>

<%
  # Counting TCDM
  n_io_regs += acc_wr_n_sink + acc_wr_n_source
%>

<%
  # Instantiate at RTL-level
%>

    .N_IO_REGS ( ${n_io_regs} ),

</%def>