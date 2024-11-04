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

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
##############################################
## Library of components - HWPE programming ##
##############################################
%>

<%
#######################################
## HWPE programming - Initialization ##
#######################################
%>

<%def name="hwpe_init()">\

  /* HWPE initialization */

  hwpe_cg_enable();
  while((offload_id_tmp = hwpe_acquire_job()) < 0)

</%def>

<%
#####################################
## HWPE programming - Deactivation ##
#####################################
%>

<%def name="hwpe_disable()">\

  /* Clean and disable HWPE */

  hwpe_soft_clear();
  hwpe_cg_disable();

</%def>

<%
##########################################
## HWPE programming - ULOOP programming ##
##########################################
%>

<%def name="hwpe_uloop_progr()">\

  /* Micro-code processor programming */

  // Set up bytecode
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_LOOPS1_OFFS,           0x00000000);
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_BYTECODE5_LOOPS0_OFFS, 0x00000000);
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_BYTECODE4_OFFS,        0x00000000);
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_BYTECODE3_OFFS,        0x00000000);
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_BYTECODE2_OFFS,        0x00000000);
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_BYTECODE1_OFFS,        0x00000808);
  hwpe_bytecode_set(${acc_wr_target.upper()}_REG_BYTECODE0_OFFS,        0x09e22c24);

  // Ucode parameters
  hwpe_nb_iter_set(stripe_height);
  hwpe_linestride_set(width*sizeof(uint32_t));
  hwpe_tilestride_set(stripe_height*sizeof(uint32_t));

</%def>

<%
###############################################
## HWPE programming - FSM programming ##
###############################################
%>

<%def name="hwpe_fsm_progr()">\

  /* FSM programming */

  % for j in range (acc_wr_n_source):
  hwpe_len_iter_set_${acc_wr_stream_out[j]}(engine_runs_${acc_wr_stream_out[j]}-1);
  % endfor

</%def>

<%
######################################################
## HWPE programming - Address generator programming ##
######################################################
%>

<%def name="hwpe_addressgen_progr()">\

  /* Address generator programming */

  % for i in range (acc_wr_n_sink):
  // Input ${acc_wr_stream_in[i]}
    % if (acc_wr_addr_gen_in_isprogr[i]):
      % if (acc_wr_is_parallel_in[i]):
  hwpe_addr_gen_${acc_wr_stream_in[i]}(
    ${acc_wr_stream_in[i]}_trans_size,
    ${acc_wr_stream_in[i]}_line_stride,
    ${acc_wr_stream_in[i]}_line_length,
    ${acc_wr_stream_in[i]}_feat_stride,
    ${acc_wr_stream_in[i]}_feat_length,
    ${acc_wr_stream_in[i]}_feat_roll,
    ${acc_wr_stream_in[i]}_loop_outer,
    ${acc_wr_stream_in[i]}_realign_type,
    ${acc_wr_stream_in[i]}_port_offset,
    ${acc_wr_stream_in[i]}_step
  );
      % else:
  hwpe_addr_gen_${acc_wr_stream_in[i]}(
    ${acc_wr_stream_in[i]}_trans_size,
    ${acc_wr_stream_in[i]}_line_stride,
    ${acc_wr_stream_in[i]}_line_length,
    ${acc_wr_stream_in[i]}_feat_stride,
    ${acc_wr_stream_in[i]}_feat_length,
    ${acc_wr_stream_in[i]}_feat_roll,
    ${acc_wr_stream_in[i]}_loop_outer,
    ${acc_wr_stream_in[i]}_realign_type,
    ${acc_wr_stream_in[i]}_step
  );
      % endif
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
  // Output ${acc_wr_stream_out[j]}
    % if (acc_wr_addr_gen_out_isprogr[j]):
      % if (acc_wr_is_parallel_out[j]):
  hwpe_addr_gen_${acc_wr_stream_out[j]}(
    ${acc_wr_stream_out[j]}_trans_size,
    ${acc_wr_stream_out[j]}_line_stride,
    ${acc_wr_stream_out[j]}_line_length,
    ${acc_wr_stream_out[j]}_feat_stride,
    ${acc_wr_stream_out[j]}_feat_length,
    ${acc_wr_stream_out[j]}_feat_roll,
    ${acc_wr_stream_out[j]}_loop_outer,
    ${acc_wr_stream_out[j]}_realign_type,
    ${acc_wr_stream_out[j]}_port_offset,
    ${acc_wr_stream_out[j]}_step
  );
      % else:
  hwpe_addr_gen_${acc_wr_stream_out[j]}(
    ${acc_wr_stream_out[j]}_trans_size,
    ${acc_wr_stream_out[j]}_line_stride,
    ${acc_wr_stream_out[j]}_line_length,
    ${acc_wr_stream_out[j]}_feat_stride,
    ${acc_wr_stream_out[j]}_feat_length,
    ${acc_wr_stream_out[j]}_feat_roll,
    ${acc_wr_stream_out[j]}_loop_outer,
    ${acc_wr_stream_out[j]}_realign_type,
    ${acc_wr_stream_out[j]}_step
  );
      % endif
    % endif
  % endfor

</%def>

<%
#####################################################
## HWPE programming - TCDM master port programming ##
#####################################################
%>

<%def name="hwpe_tcdm_progr()">\

  /* Set TCDM address reg values */

  % for i in range (acc_wr_n_sink):
  // input ${acc_wr_stream_in[i]}
  hwpe_${acc_wr_stream_in[i]}_addr_set( ${acc_wr_stream_in[i]}_l1 );
  % endfor

  % for j in range (acc_wr_n_source):
  // output ${acc_wr_stream_out[j]}
  hwpe_${acc_wr_stream_out[j]}_addr_set( ${acc_wr_stream_out[j]}_l1 );
  % endfor

</%def>

<%
#####################################################
## HWPE programming - Custom registers programming ##
#####################################################
%>

<%def name="hwpe_custom_regs_progr()">\

  % if acc_wr_custom_reg_num>0:
  /* Set user custom registers */
    % for i in range (acc_wr_custom_reg_num):
  hwpe_${acc_wr_custom_reg_name[i]}_set( ${acc_wr_custom_reg_name[i]}_val );
    % endfor
  % endif

</%def>
