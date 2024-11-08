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
#######################################
## Library of components - Streaming ##
#######################################
%>

<%
###########################
## Streaming - Interface ##
###########################
%>

<%def name="streaming_intf()">\

  // Streaming interfaces
  
  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):
  hwpe_stream_intf_stream.source ${acc_wr_stream_in[i]}_${k},
      % endfor
    % else:
  hwpe_stream_intf_stream.source ${acc_wr_stream_in[i]},
    % endif
  % endfor 

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):
  hwpe_stream_intf_stream.sink ${acc_wr_stream_out[j]}_${k},
      % endfor
    % else:
  hwpe_stream_intf_stream.sink ${acc_wr_stream_out[j]},
    % endif
  % endfor 

</%def>

<%
#############################
## Streaming - Source/Sink ##
#############################
%>

<%def name="streaming_source_sink()">\

  // Source modules (TCDM -> HWPE)

  % for i in range (acc_wr_n_sink):
    % if ( acc_wr_is_parallel_in[i] ):
      % for k in range ( acc_wr_in_parallelism_factor[i] ):
  hwpe_stream_source #(
    .DATA_WIDTH       ( 32 ),
    .DECOUPLED        ( 1  ),
    .TRANS_CNT        ( 24  ),
        % if acc_wr_addr_gen_in_isprogr[i]:
    .IS_ADDRESSGEN_PROGR  ( 1  )
        % else:
    .IS_ADDRESSGEN_PROGR  ( 0  )
        % endif
  ) i_${ acc_wr_stream_in[i] }_${k}_source (
    .clk_i              ( clk_i                                       ),
    .rst_ni             ( rst_ni                                      ),
    .test_mode_i        ( test_mode_i                                 ),
    .clear_i            ( clear_i                                     ),
    .tcdm               ( tcdm_fifo_${acc_wr_stream_in[i]}_${k}              ), 
    .stream             ( stream_fifo_${acc_wr_stream_in[i]}_${k}.source     ),
    .ctrl_i             ( ctrl_i.${acc_wr_stream_in[i]}_${k}_source_ctrl     ),
    .flags_o            ( flags_o.${acc_wr_stream_in[i]}_${k}_source_flags   ),
    .tcdm_fifo_ready_o  ( tcdm_fifo_ready_${acc_wr_stream_in[i]}_${k}        )
  );
      % endfor
    % else:
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  ),
    .TRANS_CNT    ( 24  ),
        % if acc_wr_addr_gen_in_isprogr[i]:
    .IS_ADDRESSGEN_PROGR  ( 1  )
        % else:
    .IS_ADDRESSGEN_PROGR  ( 0  )
        % endif
  ) i_${ acc_wr_stream_in[i] }_source (
    .clk_i              ( clk_i                                       ),
    .rst_ni             ( rst_ni                                      ),
    .test_mode_i        ( test_mode_i                                 ),
    .clear_i            ( clear_i                                     ),
    .tcdm               ( tcdm_fifo_${acc_wr_stream_in[i]}                   ), 
    .stream             ( stream_fifo_${acc_wr_stream_in[i]}.source          ),
    .ctrl_i             ( ctrl_i.${acc_wr_stream_in[i]}_source_ctrl          ),
    .flags_o            ( flags_o.${acc_wr_stream_in[i]}_source_flags        ),
    .tcdm_fifo_ready_o  ( tcdm_fifo_ready_${acc_wr_stream_in[i]}             )
  );
    % endif
  % endfor 

  // Sink modules (TCDM <- HWPE)

  % for j in range (acc_wr_n_source):
    % if ( acc_wr_is_parallel_out[j] ):
      % for k in range ( acc_wr_out_parallelism_factor[j] ):
  hwpe_stream_sink #(
    .DATA_WIDTH ( 32 ),
        % if acc_wr_addr_gen_out_isprogr[j]:
    .IS_ADDRESSGEN_PROGR  ( 1  )
        % else:
    .IS_ADDRESSGEN_PROGR  ( 0  )
        % endif
    // .NB_TCDM_PORTS (    )
  ) i_${ acc_wr_stream_out[j] }_${k}_sink (
    .clk_i              ( clk_i                                       ),
    .rst_ni             ( rst_ni                                      ),
    .test_mode_i        ( test_mode_i                                 ),
    .clear_i            ( clear_i                                     ),
    .tcdm               ( tcdm_fifo_${acc_wr_stream_out[j]}_${k}             ), 
    .stream             ( stream_fifo_${acc_wr_stream_out[j]}_${k}.sink      ),
    .ctrl_i             ( ctrl_i.${acc_wr_stream_out[j]}_${k}_sink_ctrl      ),
    .flags_o            ( flags_o.${acc_wr_stream_out[j]}_${k}_sink_flags    )
  );
      % endfor
    % else:
  hwpe_stream_sink #(
    .DATA_WIDTH ( 32 ),
        % if acc_wr_addr_gen_out_isprogr[j]:
    .IS_ADDRESSGEN_PROGR  ( 1  )
        % else:
    .IS_ADDRESSGEN_PROGR  ( 0  )
        % endif
    // .NB_TCDM_PORTS (    )
  ) i_${ acc_wr_stream_out[j] }_sink (
    .clk_i              ( clk_i                                       ),
    .rst_ni             ( rst_ni                                      ),
    .test_mode_i        ( test_mode_i                                 ),
    .clear_i            ( clear_i                                     ),
    .tcdm               ( tcdm_fifo_${acc_wr_stream_out[j]}                  ), 
    .stream             ( stream_fifo_${acc_wr_stream_out[j]}.sink           ),
    .ctrl_i             ( ctrl_i.${ acc_wr_stream_out[j] }_sink_ctrl         ),
    .flags_o            ( flags_o.${ acc_wr_stream_out[j] }_sink_flags       )
  );
    % endif
  % endfor 

</%def>