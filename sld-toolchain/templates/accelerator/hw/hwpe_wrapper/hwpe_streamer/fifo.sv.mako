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

    Description:    HWPE streamer.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
##################################
## Library of components - FIFO ##
##################################
%>

<%
#############################################################################################################
#############################################################################################################
%>

<%
###############################
## FIFO - TCDM ready signals ##
###############################
%>

<%def name="fifo_tcdm_ready_signs()">\

  // TCDM ready signals

  <%
  # NB - only input streams need 'ready' signal
  %>

  % for i in range ( acc_wr_n_sink ):
    % if ( acc_wr_is_parallel_in[i] ):
      % for k in range ( acc_wr_in_parallelism_factor[i] ):

  logic tcdm_fifo_ready_${acc_wr_stream_in[i]}_${k};

      % endfor
    % else:

  logic tcdm_fifo_ready_${acc_wr_stream_in[i]};

    % endif
  % endfor 

</%def>

<%
#######################################
## FIFO - TCDM interface (Post-FIFO) ##
#######################################
%>

<%def name="fifo_tcdm_intf_post_fifo()">\

  // TCDM interface

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):

  hwpe_stream_intf_tcdm tcdm_fifo_${acc_wr_stream_in[i]}_${k} [0:0] ( .clk (clk_i) );

      % endfor
    % else:

  hwpe_stream_intf_tcdm tcdm_fifo_${acc_wr_stream_in[i]} [0:0] ( .clk (clk_i) );

    % endif
  % endfor 

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  hwpe_stream_intf_tcdm tcdm_fifo_${acc_wr_stream_out[j]}_${k} [0:0] ( .clk (clk_i) );

      % endfor
    % else:

  hwpe_stream_intf_tcdm tcdm_fifo_${acc_wr_stream_out[j]} [0:0] ( .clk (clk_i) );

    % endif
  % endfor

</%def>

<%
####################################
## FIFO - FIFO module (TCDM-side) ##
####################################
%>

<%def name="fifo_tcdm_side()">\

  <%
    tcdm_offset = 0
  %>

  // TCDM-side FIFO - Inputs

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):

  hwpe_stream_tcdm_fifo_load #(
    .FIFO_DEPTH ( 4 )
  ) i_${acc_wr_stream_in[i]}_${k}_tcdm_fifo_load (
    .clk_i       ( clk_i                                    ),
    .rst_ni      ( rst_ni                                   ),
    .clear_i     ( clear_i                                  ),
    .flags_o     (                                          ),
    .ready_i     ( tcdm_fifo_ready_${acc_wr_stream_in[i]}_${k}     ),
    .tcdm_slave  ( tcdm_fifo_${acc_wr_stream_in[i]}_${k}[0]        ),
    .tcdm_master ( tcdm[${tcdm_offset}]                     )
  );
        <%
          tcdm_offset += 1
        %>
      % endfor
    % else:
  hwpe_stream_tcdm_fifo_load #(
    .FIFO_DEPTH ( 4 )
  ) i_${acc_wr_stream_in[i]}_tcdm_fifo_load (
    .clk_i       ( clk_i                                    ),
    .rst_ni      ( rst_ni                                   ),
    .clear_i     ( clear_i                                  ),
    .flags_o     (                                          ),
    .ready_i     ( tcdm_fifo_ready_${acc_wr_stream_in[i]}          ),
    .tcdm_slave  ( tcdm_fifo_${acc_wr_stream_in[i]}[0]             ),
    .tcdm_master ( tcdm[${tcdm_offset}]                     )
  );
        <%
          tcdm_offset += 1
        %>
    % endif
  % endfor

  // TCDM-side FIFO - Outputs

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  hwpe_stream_tcdm_fifo_store #(
    .FIFO_DEPTH ( 4 )
  ) i_${acc_wr_stream_out[j]}_${k}_tcdm_fifo_store (
    .clk_i       ( clk_i                                    ),
    .rst_ni      ( rst_ni                                   ),
    .clear_i     ( clear_i                                  ),
    .flags_o     (                                          ),
    .tcdm_slave  ( tcdm_fifo_${acc_wr_stream_out[j]}_${k}[0]        ),
    .tcdm_master ( tcdm[${tcdm_offset}]                     )
  );
        <%
          tcdm_offset += 1
        %>
      % endfor
    % else:
  hwpe_stream_tcdm_fifo_store #(
    .FIFO_DEPTH ( 4 )
  ) i_${acc_wr_stream_out[j]}_tcdm_fifo_store (
    .clk_i       ( clk_i                                    ),
    .rst_ni      ( rst_ni                                   ),
    .clear_i     ( clear_i                                  ),
    .flags_o     (                                          ),
    .tcdm_slave  ( tcdm_fifo_${acc_wr_stream_out[j]}[0]             ),
    .tcdm_master ( tcdm[${tcdm_offset}]                     )
  );
        <%
          tcdm_offset += 1
        %>
    % endif
  % endfor

</%def>

<%
##############################################################################################################
##############################################################################################################
%>

<%
###########################################
## FIFO - Streaming interface (Pre-FIFO) ##
###########################################
%>

<%def name="fifo_stream_intf_pre_fifo()">\

  // Streaming interface

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) stream_fifo_${acc_wr_stream_in[i]}_${k} ( .clk (clk_i) );

      % endfor
    % else:

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) stream_fifo_${acc_wr_stream_in[i]} ( .clk (clk_i) );

    % endif
  % endfor 

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) stream_fifo_${acc_wr_stream_out[j]}_${k} ( .clk (clk_i) );

      % endfor
    % else:

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) stream_fifo_${acc_wr_stream_out[j]} ( .clk (clk_i) );

    % endif
  % endfor

</%def>

<%
######################################
## FIFO - FIFO module (Engine-side) ##
######################################
%>

<%def name="fifo_engine_side()">\

  // Engine-side FIFO - Inputs

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):

  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_${acc_wr_stream_in[i]}_${k}_stream_fifo (
    .clk_i   ( clk_i                                      ),
    .rst_ni  ( rst_ni                                     ),
    .clear_i ( clear_i                                    ),
    .push_i  ( stream_fifo_${acc_wr_stream_in[i]}_${k}.sink      ),
    .pop_o   ( ${acc_wr_stream_in[i]}_${k}                       ),
    .flags_o (                                            )
  );

      % endfor 
    % else:

  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_${acc_wr_stream_in[i]}_stream_fifo (
    .clk_i   ( clk_i                                      ),
    .rst_ni  ( rst_ni                                     ),
    .clear_i ( clear_i                                    ),
    .push_i  ( stream_fifo_${acc_wr_stream_in[i]}.sink      ),
    .pop_o   ( ${acc_wr_stream_in[i]}                            ),
    .flags_o (                                            )
  );

    % endif 
  % endfor

  // Engine-side FIFO - Outputs

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_${acc_wr_stream_out[j]}_${k}_stream_fifo (
    .clk_i   ( clk_i                                      ),
    .rst_ni  ( rst_ni                                     ),
    .clear_i ( clear_i                                    ),
    .push_i  ( stream_fifo_${acc_wr_stream_out[j]}_${k}.source   ),
    .pop_o   ( ${acc_wr_stream_out[j]}_${k}                      ),
    .flags_o (                                            )
  );

      % endfor 
    % else:

  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_${acc_wr_stream_out[j]}_stream_fifo (
    .clk_i   ( clk_i                                      ),
    .rst_ni  ( rst_ni                                     ),
    .clear_i ( clear_i                                    ),
    .push_i  ( ${acc_wr_stream_out[j]}                           ),
    .pop_o   ( stream_fifo_${acc_wr_stream_out[j]}.source         ),
    .flags_o (                                            )
  );

    % endif 
  % endfor

</%def>
