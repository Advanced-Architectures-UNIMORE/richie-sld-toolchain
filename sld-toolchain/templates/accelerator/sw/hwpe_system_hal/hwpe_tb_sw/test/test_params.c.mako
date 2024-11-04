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
#############################################
## Library of components - Test parameters ##
#############################################
%>

<%
###################################
## Test parameters - Declaration ##
###################################
%>

<%def name="decl_t_params()">\

  /* Application-specific parameters. */

  // These parameters have to be set by the user before to compile the application.

  // 1. Workload

  uint32_t width                  = ;
  uint32_t height                 = ;
  uint32_t stripe_height          = ;

  // 2. Accelerator execution

  // Number of engine runs needed to terminate the accelerator job.
  // This is equivalent to the number of 'done' signals that are
  // produced by the engine itself.

  % for j in range (acc_wr_n_source):
  const unsigned engine_runs_${acc_wr_stream_out[j]} = ;
  % endfor


  % if acc_wr_custom_reg_num>0:
  // 3. Custom registers
    % for i in range (acc_wr_custom_reg_num):
  const unsigned ${acc_wr_custom_reg_name[i]}_val = ;
    % endfor
  % endif

  /* General parameters. */

  volatile int errors = 0;
  int i, j;
  int offload_id_tmp, offload_id;

  omp_set_num_threads(1);

  <%
  ###############################################
  ## Declaration of stream-specific parameters ##
  ###############################################
  %>

  /* Stream-specific parameters. */

  % for i in range (acc_wr_n_sink):
  const unsigned ${acc_wr_stream_in[i]}_width              = width;
  const unsigned ${acc_wr_stream_in[i]}_height             = height;
  const unsigned ${acc_wr_stream_in[i]}_stripe_height      = stripe_height;
  % endfor

  % for j in range (acc_wr_n_source):
  const unsigned ${acc_wr_stream_out[j]}_width             = width;
  const unsigned ${acc_wr_stream_out[j]}_height            = height;
  const unsigned ${acc_wr_stream_out[j]}_stripe_height     = stripe_height;
  % endfor

  <%
  ####################################
  ## Dataset parameters declaration ##
  ####################################
  %>

  /* Dataset parameters. */
  % for i in range (acc_wr_n_sink):
  const unsigned ${acc_wr_stream_in[i]}_stim_dim               = ${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_height;
  const unsigned ${acc_wr_stream_in[i]}_stripe_in_len          = ${acc_wr_stream_in[i]}_width * ${acc_wr_stream_in[i]}_stripe_height;
  % endfor

  % for j in range (acc_wr_n_source):
  const unsigned ${acc_wr_stream_out[j]}_stim_dim              = ${acc_wr_stream_out[j]}_width * ${acc_wr_stream_out[j]}_height;
  const unsigned ${acc_wr_stream_out[j]}_stripe_out_len        = ${acc_wr_stream_out[j]}_width * ${acc_wr_stream_out[j]}_stripe_height;
  % endfor

</%def>
