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

    Description:    HWPE architecture macros.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/*
 * Copyright (C) 2018-2019 ETH Zurich and University of Bologna
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Author: Francesco Conti <fconti@iis.ee.ethz.ch>
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 */

#ifndef __ARCHI_HWPE_H__
#define __ARCHI_HWPE_H__

/*
 * Control and generic configuration register layout
 * ================================================================================
 *  # reg |  offset  |  bits   |   bitmask    ||  content
 * -------+----------+---------+--------------++-----------------------------------
 *     0  |  0x0000  |  31: 0  |  0xffffffff  ||  TRIGGER
 *     1  |  0x0004  |  31: 0  |  0xffffffff  ||  ACQUIRE
 *     2  |  0x0008  |  31: 0  |  0xffffffff  ||  EVT_ENABLE
 *     3  |  0x000c  |  31: 0  |  0xffffffff  ||  STATUS
 *     4  |  0x0010  |  31: 0  |  0xffffffff  ||  RUNNING_JOB
 *     5  |  0x0014  |  31: 0  |  0xffffffff  ||  SOFT_CLEAR
 *   6-7  |          |         |              ||  Reserved
 *     8  |  0x0020  |  31: 0  |  0xffffffff  ||  BYTECODE0 [31:0]
 *     9  |  0x0024  |  31: 0  |  0xffffffff  ||  BYTECODE1 [63:32]
 *    10  |  0x0028  |  31: 0  |  0xffffffff  ||  BYTECODE2 [95:64]
 *    11  |  0x002c  |  31: 0  |  0xffffffff  ||  BYTECODE3 [127:96]
 *    12  |  0x0030  |  31: 0  |  0xffffffff  ||  BYTECODE4 [159:128]
 *    13  |  0x0034  |  31:16  |  0xffff0000  ||  LOOPS0    [15:0]
 *        |          |  15: 0  |  0x0000ffff  ||  BYTECODE5 [175:160]
 *    14  |  0x0038  |  31: 0  |  0xffffffff  ||  LOOPS1    [47:16]
 *    15  |          |  31: 0  |  0xffffffff  ||  Reserved
 * ================================================================================
 *
 * Job-dependent registers layout
 * ================================================================================
 *  # reg |  offset  |  bits   |   bitmask    ||  content
 * -------+----------+---------+--------------++-----------------------------------
 % for i in range (acc_wr_n_sink+acc_wr_n_source):
 *     ${i}  |  ${"0x{:04x}".format(64+i*4)}  |  31: 0  |  0xffffffff  ||  ${chr(i+65)}_ADDR
% endfor

 *     ${i+1}  |  ${"0x{:04x}".format(64+(acc_wr_n_sink+acc_wr_n_source)*4)}  |  31: 0  |  0xffffffff  ||  NB_ITER
 *     ${i+2}  |  ${"0x{:04x}".format(64+(acc_wr_n_sink+acc_wr_n_source+1)*4)}  |  31: 0  |  0xffffffff  ||  LEN_ITER
 *     ${i+3}  |  ${"0x{:04x}".format(64+(acc_wr_n_sink+acc_wr_n_source+2)*4)}  |  31:16  |  0xffff0000  ||  SHIFT
 *        |          |   0: 0  |  0x00000001  ||  SIMPLEMUL
 *     ${i+4}  |  ${"0x{:04x}".format(64+(acc_wr_n_sink+acc_wr_n_source+3)*4)}  |  31: 0  |  0xffffffff  ||  VECTSTRIDE
 *     ${i+5}  |  ${"0x{:04x}".format(64+(acc_wr_n_sink+acc_wr_n_source+4)*4)}  |  31: 0  |  0xffffffff  ||  VECTSTRIDE2
 % for i in range (acc_wr_custom_reg_num):
 <% NAME=acc_wr_custom_reg_name[i].upper() %>
 *     ${acc_wr_n_sink+acc_wr_n_source+acc_wr_std_reg_num+i}  |  ${"0x{:04x}".format(92+i*4)}  |  ${acc_wr_custom_reg_dim[i]-1}: 0  |  0xffffffff  ||  HWPE_${NAME}
 % endfor
 *
 * ================================================================================
 *
 */

#define ARCHI_CL_EVT_ACC0 0
#define ARCHI_CL_EVT_ACC1 1
#define ARCHI_HWPE_ADDR_BASE 0x100000
#define ARCHI_HWPE_EU_OFFSET 12
#define __builtin_bitinsert(a,b,c,d) (a | (((b << (32-c)) >> (32-c)) << d))

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
    # registers. Their ordering has to match their counterpart in teh SystemVerilog
    # top package. The latter comprises the offsets of the the HWPE parameter registers.
    # HWPE parameters are collected under the 'ctrl_regfile_t' typedef defined in 'hwpe_ctrl'.
    # It is really important to map the HWPE parameters after basic and uloop registers;
    # this ordering is required by the implementation of the controller.

    # Notice that offsets increment with a step of 4 because HWPE
    # controller implements 32-bit control registers.
%>

<%
########################################################
## Basic control registers archi - Offset declaration ##
########################################################
%>

<%
    # Control/flag signals for basic interaction with HWPE
    # Do not change the positioning of these offsets definition
    # unless the controller slave is properly updated
%>

/* Basic archi */

${basic_archi(addr_current)}

<%
addr_top = 32 # let new addr_top passed to uloop be set at 0x20
addr_current = addr_top
%>

<%
################################################
## ULOOP registers archi - Offset declaration ##
################################################
%>

<%
    # Bytecodes for microcode processor
    # Do not change the positioning of these offsets definition
    # unless the controller slave is properly updated
%>

/* Microcode processor registers archi */

${uloop_archi(addr_current)}

<%
addr_top = 64 # let new addr_top passed to tcdm regs be set at 0x40
addr_current = addr_top
%>

<%
###############################################
## TCDM registers archi - Offset declaration ##
###############################################
%>

/* TCDM registers archi */

${tcdm_archi(addr_current)}

<%
addr_top += (acc_wr_n_sink + acc_wr_n_source) * 4
addr_current = addr_top
%>

<%
###################################################
## Standard registers archi - Offset declaration ##
###################################################
%>

/* Standard registers archi */

${standard_archi(addr_current)}

<%
addr_top += ((acc_wr_std_reg_num -1) + acc_wr_n_source) * 4 # number of "cnt_limit" regs scale linearly with "acc_wr_n_source", while other std-regs are constant
addr_current = addr_top
%>

<%
#################################################
## Custom registers archi - Offset declaration ##
#################################################
%>

/* Custom registers archi */

${custom_archi(addr_current)}

<%
addr_top += acc_wr_custom_reg_num * 4
addr_current = addr_top
%>

<%
##########################################################################
## Address generator registers archi - Input streams offset declaration ##
##########################################################################
%>

/* Address generator archi */

${addressgen_archi_in(addr_current)}

<%
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
            addr_top += num_regs_per_port_parallel * 4
        else:
            addr_top += num_regs_per_port * 4
        endif
    endif
endfor

addr_current = addr_top
%>

<%
###########################################################################
## Address generator registers archi - Output streams offset declaration ##
###########################################################################
%>

${addressgen_archi_out(addr_current)}

<%
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
            addr_top += num_regs_per_port_parallel * 4
        else:
            addr_top += num_regs_per_port * 4
        endif
    endif
endfor

addr_current = addr_top
%>

#endif
