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
##########################################
## Library of components - Test stimuli ##
##########################################
%>

<%
######################################
## Test stimuli - Include libraries ##
######################################
%>

<%def name="include_t_libs()">\

  // Synthetic stimuli
  % for i in range (acc_wr_n_sink):
  #include "inc/stim/${acc_wr_stream_in[i]}.h"
  % endfor

  // Golden results
  % for j in range (acc_wr_n_source):
  #include "inc/stim/${acc_wr_stream_out[j]}.h"
  % endfor

</%def>

<%
###############################
## Test stimuli - Allocation ##
###############################
%>

<%def name="allocate_t_stims()">\

  /* Allocation of I/O arrays. */

  // Stimuli

  % for i in range (acc_wr_n_sink):
  ${acc_wr_stream_in_dtype[i]} * ${acc_wr_stream_in[i]}_l1 = hero_l1malloc(sizeof(int32_t)*${acc_wr_stream_in[i]}_stripe_in_len);
  % endfor

  // Results

  % for j in range (acc_wr_n_source):
  ${acc_wr_stream_out_dtype[j]} * ${acc_wr_stream_out[j]}_l1 = hero_l1malloc(sizeof(int32_t)*${acc_wr_stream_out[j]}_stripe_out_len);
  % endfor

  // Golden results

  % for j in range (acc_wr_n_source):
  ${acc_wr_stream_out_dtype[j]} * ${acc_wr_stream_out[j]}_golden_l1 = hero_l1malloc(sizeof(int32_t)*${acc_wr_stream_out[j]}_stripe_out_len);
  % endfor

</%def>

<%
###################################
## Test stimuli - Initialization ##
###################################
%>

<%def name="init_t_stims()">\

  /* Initialization of I/O arrays. */

  // Stimuli

  % for i in range (acc_wr_n_sink):
  for (i = 0; i < ${acc_wr_stream_in[i]}_stripe_height; i++){
    for (j = 0; j < ${acc_wr_stream_in[i]}_width; j++){
      ${acc_wr_stream_in[i]}_l1[i*${acc_wr_stream_in[i]}_width+j] = ${acc_wr_stream_in[i]}[i*${acc_wr_stream_in[i]}_width+j];
    }
  }
  % endfor

  // Golden results

  % for j in range (acc_wr_n_source):
  for (i = 0; i < ${acc_wr_stream_out[j]}_stripe_height; i++){
    for (j = 0; j < ${acc_wr_stream_out[j]}_width; j++){
      ${acc_wr_stream_out[j]}_golden_l1[i*${acc_wr_stream_out[j]}_width+j] = ${acc_wr_stream_out[j]}[i*${acc_wr_stream_out[j]}_width+j];
    }
  }
  % endfor

</%def>



