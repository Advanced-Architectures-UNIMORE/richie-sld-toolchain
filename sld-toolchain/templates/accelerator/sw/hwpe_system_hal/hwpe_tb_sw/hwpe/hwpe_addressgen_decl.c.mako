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
######################################################################
## Library of components - Address generator parameters declaration ##
######################################################################
%>

<%
# The parameters for the address generator are initialized in a
# a way to support basic matrix multiplication. A future milestone
# might be to search for automated methods to set these parameters.
# Ref -> https://github.com/imranashraf/mcprof
%>

<%
######################################################
## Address generator parameters declaration - Input ##
######################################################
%>

<%
# Declaration for matrix multiplication with TCDM data reuse.
%>

<%def name="hwpe_addressgen_in_tcdm_reuse()">\

  /* Address generator (input) - Parameters */

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
      % if (acc_wr_is_parallel_in[i]):
  const unsigned ${acc_wr_stream_in[i]}_parallelism_factor     = 16;
  const unsigned ${acc_wr_stream_in[i]}_trans_size             = (${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height * ${acc_wr_stream_in[i]}_stripe_height) / ${acc_wr_stream_in[i]}_parallelism_factor;
  const unsigned ${acc_wr_stream_in[i]}_line_stride            = 0;
  const unsigned ${acc_wr_stream_in[i]}_line_length            = ${acc_wr_stream_in[i]}_width / ${acc_wr_stream_in[i]}_parallelism_factor;
  const unsigned ${acc_wr_stream_in[i]}_feat_stride            = ${acc_wr_stream_in[i]}_width * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_in[i]}_feat_length            = ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_feat_roll              = ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_loop_outer             = 0;
  const unsigned ${acc_wr_stream_in[i]}_realign_type           = 0;
  const unsigned ${acc_wr_stream_in[i]}_step                   = ${acc_wr_stream_in[i]}_parallelism_factor * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_in[i]}_port_offset            = sizeof(uint32_t);
      % else:
  const unsigned ${acc_wr_stream_in[i]}_trans_size             = ${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height * ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_line_stride            = 0;
  const unsigned ${acc_wr_stream_in[i]}_line_length            = ${acc_wr_stream_in[i]}_width;
  const unsigned ${acc_wr_stream_in[i]}_feat_stride            = ${acc_wr_stream_in[i]}_width * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_in[i]}_feat_length            = ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_feat_roll              = ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_loop_outer             = 0;
  const unsigned ${acc_wr_stream_in[i]}_realign_type           = 0;
  const unsigned ${acc_wr_stream_in[i]}_step                   = 4;
      % endif
    % endif
  % endfor

</%def>

<%
# Declaration for matrix multiplication with memcpy from TCDM to accelerator local memory.
%>

<%def name="hwpe_addressgen_in_memcpy_acc_mem()">\

  /* Address generator (input) - Parameters */

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
      % if (acc_wr_is_parallel_in[i]):
  const unsigned ${acc_wr_stream_in[i]}_parallelism_factor     = 16;
  const unsigned ${acc_wr_stream_in[i]}_trans_size             = (${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height) / ${acc_wr_stream_in[i]}_parallelism_factor;
  const unsigned ${acc_wr_stream_in[i]}_line_stride            = 0;
  const unsigned ${acc_wr_stream_in[i]}_line_length            = (${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height) / ${acc_wr_stream_in[i]}_parallelism_factor;
  const unsigned ${acc_wr_stream_in[i]}_feat_stride            = 0;
  const unsigned ${acc_wr_stream_in[i]}_feat_length            = 1;
  const unsigned ${acc_wr_stream_in[i]}_feat_roll              = 0;
  const unsigned ${acc_wr_stream_in[i]}_loop_outer             = 0;
  const unsigned ${acc_wr_stream_in[i]}_realign_type           = 0;
  const unsigned ${acc_wr_stream_in[i]}_step                   = ${acc_wr_stream_in[i]}_parallelism_factor * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_in[i]}_port_offset            = sizeof(uint32_t);
      % else:
  const unsigned ${acc_wr_stream_in[i]}_trans_size             = ${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_line_stride            = 0;
  const unsigned ${acc_wr_stream_in[i]}_line_length            = ${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height;
  const unsigned ${acc_wr_stream_in[i]}_feat_stride            = 0;
  const unsigned ${acc_wr_stream_in[i]}_feat_length            = 1;
  const unsigned ${acc_wr_stream_in[i]}_feat_roll              = 0;
  const unsigned ${acc_wr_stream_in[i]}_loop_outer             = 0;
  const unsigned ${acc_wr_stream_in[i]}_realign_type           = 0;
  const unsigned ${acc_wr_stream_in[i]}_step                   = 4;
      % endif
    % endif
  % endfor

</%def>

<%
#######################################################
## Address generator parameters declaration - Output ##
#######################################################
%>

<%
# Declaration for matrix multiplication with TCDM data reuse.
%>

<%def name="hwpe_addressgen_out_tcdm_reuse()">\

  /* Address generator (output) - Parameters */

  % for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
      % if (acc_wr_is_parallel_out[j]):
  const unsigned ${acc_wr_stream_out[j]}_parallelism_factor    = 16;
  const unsigned ${acc_wr_stream_out[j]}_trans_size            = (${acc_wr_stream_out[j]}_width * ${acc_wr_stream_out[j]}_stripe_height * ${acc_wr_stream_out[j]}_stripe_height) / ${acc_wr_stream_out[j]}_parallelism_factor;
  const unsigned ${acc_wr_stream_out[j]}_line_stride           = 0;
  const unsigned ${acc_wr_stream_out[j]}_line_length           = ${acc_wr_stream_out[j]}_width / ${acc_wr_stream_out[j]}_parallelism_factor;
  const unsigned ${acc_wr_stream_out[j]}_feat_stride           = ${acc_wr_stream_out[j]}_width * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_feat_length           = ${acc_wr_stream_out[j]}_stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_feat_roll             = ${acc_wr_stream_out[j]}_stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_loop_outer            = 0;
  const unsigned ${acc_wr_stream_out[j]}_realign_type          = 0;
  const unsigned ${acc_wr_stream_out[j]}_step                  = ${acc_wr_stream_out[j]}_parallelism_factor * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_port_offset           = sizeof(uint32_t);
      % else:
  const unsigned ${acc_wr_stream_out[j]}_trans_size            = ${acc_wr_stream_out[j]}_stripe_height * ${acc_wr_stream_out[j]}_stripe_height; // stripe_height * stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_line_stride           = sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_line_length           = 1;
  const unsigned ${acc_wr_stream_out[j]}_feat_stride           = ${acc_wr_stream_out[j]}_stripe_height * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_feat_length           = ${acc_wr_stream_out[j]}_stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_feat_roll             = ${acc_wr_stream_out[j]}_stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_loop_outer            = 0;
  const unsigned ${acc_wr_stream_out[j]}_realign_type          = 0; // Unused.
  const unsigned ${acc_wr_stream_out[j]}_step                   = 4;
      % endif
    % endif
  % endfor

</%def>

<%
# Declaration for matrix multiplication with memcpy from TCDM to accelerator local memory.
%>

<%def name="hwpe_addressgen_out_memcpy_acc_mem()">\

  /* Address generator (output) - Parameters */

  % for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
      % if (acc_wr_is_parallel_out[j]):
  const unsigned ${acc_wr_stream_out[j]}_parallelism_factor     = 16;
  const unsigned ${acc_wr_stream_out[j]}_trans_size             = (${acc_wr_stream_out[j]}_width * ${acc_wr_stream_out[j]}_stripe_height) / ${acc_wr_stream_out[j]}_parallelism_factor;
  const unsigned ${acc_wr_stream_out[j]}_line_stride            = 0;
  const unsigned ${acc_wr_stream_out[j]}_line_length            = (${acc_wr_stream_out[j]}_width * ${acc_wr_stream_out[j]}_stripe_height) / ${acc_wr_stream_out[j]}_parallelism_factor;
  const unsigned ${acc_wr_stream_out[j]}_feat_stride            = 0;
  const unsigned ${acc_wr_stream_out[j]}_feat_length            = 1;
  const unsigned ${acc_wr_stream_out[j]}_feat_roll              = 0;
  const unsigned ${acc_wr_stream_out[j]}_loop_outer             = 0;
  const unsigned ${acc_wr_stream_out[j]}_realign_type           = 0;
  const unsigned ${acc_wr_stream_out[j]}_step                   = ${acc_wr_stream_out[j]}_parallelism_factor * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_port_offset            = sizeof(uint32_t);
      % else:
  const unsigned ${acc_wr_stream_out[j]}_trans_size             = ${acc_wr_stream_out[j]}_stripe_height * ${acc_wr_stream_out[j]}_stripe_height + 1;
  const unsigned ${acc_wr_stream_out[j]}_line_stride            = sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_line_length            = 1;
  const unsigned ${acc_wr_stream_out[j]}_feat_stride            = ${acc_wr_stream_out[j]}_width * sizeof(uint32_t);
  const unsigned ${acc_wr_stream_out[j]}_feat_length            = ${acc_wr_stream_out[j]}_stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_feat_roll              = ${acc_wr_stream_out[j]}_stripe_height;
  const unsigned ${acc_wr_stream_out[j]}_loop_outer             = 0;
  const unsigned ${acc_wr_stream_out[j]}_realign_type           = 0;
  const unsigned ${acc_wr_stream_out[j]}_step                   = 4;
      % endif
    % endif
  % endfor

</%def>
