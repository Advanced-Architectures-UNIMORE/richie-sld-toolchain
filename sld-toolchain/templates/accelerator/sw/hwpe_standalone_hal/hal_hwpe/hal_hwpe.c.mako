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

    Description:    HWPE Hardware Abstraction Layer.

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

#ifndef __HAL_HWPE_H__
#define __HAL_HWPE_H__

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
 * ================================================================================
 *
 */

<%
##########################################
## Low-level hardware abstraction layer ##
##########################################
%>

#define HWPE_ADDR_BASE ARCHI_FC_HWPE_ADDR
#define HWPE_ADDR_SPACE 0x00000100

// For all the following functions we use __builtin_pulp_OffsetedWrite and __builtin_pulp_OffsetedRead
// instead of classic load/store because otherwise the compiler is not able to correctly factorize
// the HWPE base in case several accesses are done, ending up with twice more code

// #define HWPE_WRITE(value, offset) *(volatile int *)(ARCHI_HWPE_ADDR_BASE + offset) = value
// #define HWPE_READ(offset) *(volatile int *)(ARCHI_HWPE_ADDR_BASE + offset)

#define HWPE_WRITE(value, offset) *(int *)(ARCHI_HWPE_ADDR_BASE + offset) = value
#define HWPE_READ(offset) *(int *)(ARCHI_HWPE_ADDR_BASE + offset)

<%
#####################################################
## Hardware abstraction layer - Standard registers ##
#####################################################
%>

/* uloop hal */

static inline void hwpe_nb_iter_set(unsigned int value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_NB_ITER);
}

static inline void hwpe_linestride_set(unsigned int value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_LINESTRIDE);
}

static inline void hwpe_tilestride_set(unsigned int value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_TILESTRIDE);
}

% for j in range (acc_wr_n_source):
static inline void hwpe_len_iter_set_${acc_wr_stream_out[j]}(unsigned int value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_CNT_LIMIT_${acc_wr_stream_out[j].upper()});
}
% endfor

<%
#####################################################################################
## Hardware abstraction layer - User-specific (engine-specific) control registers  ##
## These are to be used in case the accelerator needs to access runtime parameters ##
#####################################################################################
%>

% if acc_wr_custom_reg_num>0:
/* custom hal */
  % for i in range (acc_wr_custom_reg_num):
static inline void hwpe_${acc_wr_custom_reg_name[i]}_set(${acc_wr_custom_reg_dtype[i]} value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_${acc_wr_custom_reg_name[i].upper()} );
}
  % endfor
% endif


<%
##########################################################################
## Hardware abstraction layer to control the streamer address generator ##
##########################################################################
%>

<%
# Input streams
%>

% for i in range (acc_wr_n_sink):
  % if (acc_wr_addr_gen_in_isprogr[i]):
/* address generator hal - inputs */
    % if (acc_wr_is_parallel_in[i]):
// input ${acc_wr_stream_in[i]}
static inline void hwpe_addr_gen_${acc_wr_stream_in[i]}(
  unsigned int  ${acc_wr_stream_in[i]}_trans_size,
  unsigned int  ${acc_wr_stream_in[i]}_line_stride,
  unsigned int  ${acc_wr_stream_in[i]}_line_length,
  unsigned int  ${acc_wr_stream_in[i]}_feat_stride,
  unsigned int  ${acc_wr_stream_in[i]}_feat_length,
  unsigned int  ${acc_wr_stream_in[i]}_feat_roll,
  unsigned int  ${acc_wr_stream_in[i]}_loop_outer,
  unsigned int  ${acc_wr_stream_in[i]}_realign_type,
  unsigned int  ${acc_wr_stream_in[i]}_port_offset,
  unsigned int  ${acc_wr_stream_in[i]}_step)
{
  HWPE_WRITE(${acc_wr_stream_in[i]}_trans_size,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_TRANS_SIZE  );
  HWPE_WRITE(${acc_wr_stream_in[i]}_line_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_STRIDE );
  HWPE_WRITE(${acc_wr_stream_in[i]}_line_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_LENGTH );
  HWPE_WRITE(${acc_wr_stream_in[i]}_feat_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_STRIDE );
  HWPE_WRITE(${acc_wr_stream_in[i]}_feat_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_LENGTH );
  HWPE_WRITE(${acc_wr_stream_in[i]}_feat_roll,     ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_ROLL   );
  HWPE_WRITE(${acc_wr_stream_in[i]}_loop_outer,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LOOP_OUTER  );
  HWPE_WRITE(${acc_wr_stream_in[i]}_realign_type,  ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_REALIGN_TYPE);
  HWPE_WRITE(${acc_wr_stream_in[i]}_port_offset,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_PORT_OFFSET );
  HWPE_WRITE(${acc_wr_stream_in[i]}_step,          ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_STEP        );
}
    % else:
static inline void hwpe_addr_gen_${acc_wr_stream_in[i]}(
  unsigned int ${acc_wr_stream_in[i]}_trans_size,
  unsigned int ${acc_wr_stream_in[i]}_line_stride,
  unsigned int ${acc_wr_stream_in[i]}_line_length,
  unsigned int ${acc_wr_stream_in[i]}_feat_stride,
  unsigned int ${acc_wr_stream_in[i]}_feat_length,
  unsigned int ${acc_wr_stream_in[i]}_feat_roll,
  unsigned int ${acc_wr_stream_in[i]}_loop_outer,
  unsigned int ${acc_wr_stream_in[i]}_realign_type,
  unsigned int ${acc_wr_stream_in[i]}_step)
{
  HWPE_WRITE(${acc_wr_stream_in[i]}_trans_size,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_TRANS_SIZE  );
  HWPE_WRITE(${acc_wr_stream_in[i]}_line_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_STRIDE );
  HWPE_WRITE(${acc_wr_stream_in[i]}_line_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LINE_LENGTH );
  HWPE_WRITE(${acc_wr_stream_in[i]}_feat_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_STRIDE );
  HWPE_WRITE(${acc_wr_stream_in[i]}_feat_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_LENGTH );
  HWPE_WRITE(${acc_wr_stream_in[i]}_feat_roll,     ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_FEAT_ROLL   );
  HWPE_WRITE(${acc_wr_stream_in[i]}_loop_outer,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_LOOP_OUTER  );
  HWPE_WRITE(${acc_wr_stream_in[i]}_realign_type,  ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_REALIGN_TYPE);
  HWPE_WRITE(${acc_wr_stream_in[i]}_step,          ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_STEP        );
}
    % endif
  % endif
% endfor

<%
# Output streams
%>

% for j in range (acc_wr_n_source):
  % if (acc_wr_addr_gen_out_isprogr[j]):
/* address generator hal - outputs */
    % if (acc_wr_is_parallel_out[j]):
// output ${acc_wr_stream_out[j]}
static inline void hwpe_addr_gen_${acc_wr_stream_out[j]}(
  unsigned int  ${acc_wr_stream_out[j]}_trans_size,
  unsigned int  ${acc_wr_stream_out[j]}_line_stride,
  unsigned int  ${acc_wr_stream_out[j]}_line_length,
  unsigned int  ${acc_wr_stream_out[j]}_feat_stride,
  unsigned int  ${acc_wr_stream_out[j]}_feat_length,
  unsigned int  ${acc_wr_stream_out[j]}_feat_roll,
  unsigned int  ${acc_wr_stream_out[j]}_loop_outer,
  unsigned int  ${acc_wr_stream_out[j]}_realign_type,
  unsigned int  ${acc_wr_stream_out[j]}_port_offset,
  unsigned int  ${acc_wr_stream_out[j]}_step)
{
  HWPE_WRITE(${acc_wr_stream_out[j]}_trans_size,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_TRANS_SIZE  );
  HWPE_WRITE(${acc_wr_stream_out[j]}_line_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_STRIDE );
  HWPE_WRITE(${acc_wr_stream_out[j]}_line_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_LENGTH );
  HWPE_WRITE(${acc_wr_stream_out[j]}_feat_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_STRIDE );
  HWPE_WRITE(${acc_wr_stream_out[j]}_feat_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_LENGTH );
  HWPE_WRITE(${acc_wr_stream_out[j]}_feat_roll,     ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_ROLL   );
  HWPE_WRITE(${acc_wr_stream_out[j]}_loop_outer,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LOOP_OUTER  );
  HWPE_WRITE(${acc_wr_stream_out[j]}_realign_type,  ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_REALIGN_TYPE);
  HWPE_WRITE(${acc_wr_stream_out[j]}_port_offset,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_PORT_OFFSET );
  HWPE_WRITE(${acc_wr_stream_out[j]}_step,          ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_STEP        );
}
  % else:
static inline void hwpe_addr_gen_${acc_wr_stream_out[j]}(
  unsigned int  ${acc_wr_stream_out[j]}_trans_size,
  unsigned int  ${acc_wr_stream_out[j]}_line_stride,
  unsigned int  ${acc_wr_stream_out[j]}_line_length,
  unsigned int  ${acc_wr_stream_out[j]}_feat_stride,
  unsigned int  ${acc_wr_stream_out[j]}_feat_length,
  unsigned int  ${acc_wr_stream_out[j]}_feat_roll,
  unsigned int  ${acc_wr_stream_out[j]}_loop_outer,
  unsigned int  ${acc_wr_stream_out[j]}_realign_type,
  unsigned int  ${acc_wr_stream_out[j]}_step)
{
  HWPE_WRITE(${acc_wr_stream_out[j]}_trans_size,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_TRANS_SIZE  );
  HWPE_WRITE(${acc_wr_stream_out[j]}_line_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_STRIDE );
  HWPE_WRITE(${acc_wr_stream_out[j]}_line_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LINE_LENGTH );
  HWPE_WRITE(${acc_wr_stream_out[j]}_feat_stride,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_STRIDE );
  HWPE_WRITE(${acc_wr_stream_out[j]}_feat_length,   ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_LENGTH );
  HWPE_WRITE(${acc_wr_stream_out[j]}_feat_roll,     ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_FEAT_ROLL   );
  HWPE_WRITE(${acc_wr_stream_out[j]}_loop_outer,    ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_LOOP_OUTER  );
  HWPE_WRITE(${acc_wr_stream_out[j]}_realign_type,  ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_REALIGN_TYPE);
  HWPE_WRITE(${acc_wr_stream_out[j]}_step,          ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_STEP        );
}
    % endif
  % endif
% endfor

<%
#################################################################
## Basic hardware abstraction layer to control HWPE operations ##
#################################################################
%>

/* basic hal */

static inline void hwpe_trigger_job() {
  HWPE_WRITE(0, ${acc_wr_target.upper()}_REG_TRIGGER);
}

static inline int hwpe_acquire_job() {
  return HWPE_READ(${acc_wr_target.upper()}_REG_ACQUIRE);
}

static inline unsigned int hwpe_get_status() {
  return HWPE_READ(${acc_wr_target.upper()}_REG_STATUS);
}

static inline void hwpe_soft_clear() {
  volatile int i;
  HWPE_WRITE(0, ${acc_wr_target.upper()}_REG_SOFT_CLEAR);
}

static inline void hwpe_cg_enable() {
  return;
}

static inline void hwpe_cg_disable() {
  return;
}

static inline void hwpe_bytecode_set(unsigned int offs, unsigned int value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_BYTECODE+offs);
}

<%
#######################################################################
## Hardware abstraction layer to control TCDM master port addressing ##
#######################################################################
%>

/* tcdm master port hal */

% for i in range (acc_wr_n_sink):
// input ${acc_wr_stream_in[i]}
static inline void hwpe_${acc_wr_stream_in[i]}_addr_set(${acc_wr_stream_in_dtype[i]} value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_${acc_wr_stream_in[i].upper()}_ADDR);
}
% endfor

% for j in range (acc_wr_n_source):
// output ${acc_wr_stream_out[j]}
static inline void hwpe_${acc_wr_stream_out[j]}_addr_set(${acc_wr_stream_out_dtype[j]} value) {
  HWPE_WRITE(value, ${acc_wr_target.upper()}_REG_${acc_wr_stream_out[j].upper()}_ADDR);
}
% endfor

#endif /* __HAL_HWPE_H__ */

