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

    Description:    HWPE kernel adapter.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
######################################
## Kernel interface - MDC dataflow  ##
######################################
%>

<%
########################################
## Kernel interface - Kernel controls ##
########################################
%>

<%def name="mdc_dataflow_kernel_ctrl()">\

  /* ${acc_wr_target} control signals. */

  logic kernel_start;

  // START is not always high. For each READY (~(engine_ready | engine_idle)) that is
  // delivered to the FSM, a new START signal is set high and iaaued to the kernel.

  assign kernel_start = ctrl_i.start;

</%def>

<%
#####################################
## Kernel interface - Kernel flags ##
#####################################
%>

<%def name="mdc_dataflow_kernel_flags()">\

  /* ${acc_wr_target} flag signals. */

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):

  // logic kernel_ready_${acc_wr_stream_in[i]}_${k}; //FIXEME: to be removed
  logic kernel_done_${acc_wr_stream_in[i]}_${k};

      % endfor
    % else:

  // logic kernel_ready_${acc_wr_stream_in[i]}; //FIXEME: to be removed
  logic kernel_done_${acc_wr_stream_in[i]};

    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  logic kernel_done_${acc_wr_stream_out[j]}_${k};

      % endfor
    % else:

  logic kernel_done_${acc_wr_stream_out[j]};

    % endif
  % endfor

  logic kernel_idle;
  // logic kernel_ready;

  /* Done. */
  // A done is generated for each output. These are counted and 
  // delivered to the FSM that decides when to update the address
  // on the basis of the state of the line processing (see HWPE-docs).

  // FIXME: This temporarily works synch-outputs.
  // EX: What if Out_0 is provided at each input and Out_1 once per 10 inputs?
  assign flags_o.done = ${AND_kernel_done_out()};

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_done_${acc_wr_stream_out[j]}_${k}
    if(~rst_ni)
      kernel_done_${acc_wr_stream_out[j]}_${k} = 1'b0;
    else if((${acc_wr_stream_out[j]}_${k}_o.valid)&(${acc_wr_stream_out[j]}_${k}_o.ready))
      kernel_done_${acc_wr_stream_out[j]}_${k} = 1'b1;
    else
      kernel_done_${acc_wr_stream_out[j]}_${k} = 1'b0;
  end

      % endfor
    % else:

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_done_${acc_wr_stream_out[j]}
    if(~rst_ni)
      kernel_done_${acc_wr_stream_out[j]} = 1'b0;
    else if((${acc_wr_stream_out[j]}_o.valid)&(${acc_wr_stream_out[j]}_o.ready))
      kernel_done_${acc_wr_stream_out[j]} = 1'b1;
    else
      kernel_done_${acc_wr_stream_out[j]} = 1'b0;
  end

    % endif
  % endfor

  /* Ready. */
  /* This is used in the hwpe-engine to set flags_o.ready. 
     The latter triggers the START of accelerator. (see FSM_COMPUTE). */
  /* Driven using input counters. */

  assign flags_o.ready = ${AND_kernel_done_in()};

  /* Idle. */
  /* This is used in the hwpe-engine to set flags_o.ready. 
     The latter triggers the START of accelerator. (see FSM_COMPUTE). */
  /* For more infos refer to UG902. */

  assign flags_o.idle = kernel_idle;

  /* The Idle signal indicates when the design is idle and not operating. */
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_idle
		if(~rst_ni) begin
      kernel_idle = 1'b0;
    end 
    else if(kernel_start) begin
      /* Idle goes Low immediately after Start to indicate the design is no longer idle. */
      /* If the Start signal is High when Ready is High, the design continues to operate,
          and the Idle signal remains Low. */
			kernel_idle = 1'b0;
    end 
    else if(!kernel_start) begin 
    // else if((!kernel_start) & (ready)) begin # removed ready signal
      if( ${AND_kernel_done_out()} ) begin
        /* If the Start signal is Low when Ready is High, the design stops operation, and
            the ap_idle signal goes High one cycle after ap_done.*/
        kernel_idle = 1'b1;
      end
    end 
    else begin
			kernel_idle = kernel_idle;
    end
  end

</%def>

<%
#######################################
## Kernel interface - Input counters ##
#######################################
%>

<%def name="mdc_dataflow_counter_in()">\

  /* ${acc_wr_target} input counters. Ready. */

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_is_parallel_in[i]):
      % for k in range (acc_wr_in_parallelism_factor[i]):

  logic unsigned [($clog2(${acc_wr_target.upper()}_CNT_LEN)+1):0] kernel_cnt_${acc_wr_stream_in[i]}_${k};

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_${acc_wr_stream_in[i]}_${k}
    if((~rst_ni) | kernel_start) begin
      kernel_cnt_${acc_wr_stream_in[i]}_${k} = 32'b0;
    end
    else if(kernel_start) begin
      kernel_cnt_${acc_wr_stream_in[i]}_${k} = 32'b0;
    end
    else if ((${acc_wr_stream_in[i]}_${k}_i.valid) & (${acc_wr_stream_in[i]}_${k}_i.ready)) begin
      kernel_cnt_${acc_wr_stream_in[i]}_${k} = kernel_cnt_${acc_wr_stream_in[i]}_${k} + 1;
    end
    else begin
      kernel_cnt_${acc_wr_stream_in[i]}_${k} = kernel_cnt_${acc_wr_stream_in[i]}_${k};
    end
  end

  // FIXME: Now kernel_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to 
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign kernel_done_${acc_wr_stream_in[i]}_${k} = (kernel_cnt_${acc_wr_stream_in[i]}_${k}==1) ? 1 : 0;

      % endfor
    % else:

  logic unsigned [($clog2(${acc_wr_target.upper()}_CNT_LEN)+1):0] kernel_cnt_${acc_wr_stream_in[i]};

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_${acc_wr_stream_in[i]}
    if((~rst_ni) | kernel_start) begin
      kernel_cnt_${acc_wr_stream_in[i]} = 32'b0;
    end
    else if(kernel_start) begin
      kernel_cnt_${acc_wr_stream_in[i]} = 32'b0;
    end
    else if ((${acc_wr_stream_in[i]}_i.valid) & (${acc_wr_stream_in[i]}_i.ready)) begin
      kernel_cnt_${acc_wr_stream_in[i]} = kernel_cnt_${acc_wr_stream_in[i]} + 1;
    end
    else begin
      kernel_cnt_${acc_wr_stream_in[i]} = kernel_cnt_${acc_wr_stream_in[i]};
    end
  end

  // FIXME: Now kernel_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to 
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign kernel_done_${acc_wr_stream_in[i]} = (kernel_cnt_${acc_wr_stream_in[i]}==1) ? 1 : 0;

    % endif
  % endfor 

</%def>

<%
########################################
## Kernel interface - Output counters ##
########################################
%>

<%def name="mdc_dataflow_counter_out()">\
  /* ${acc_wr_target} output counters. */

  % for j in range (acc_wr_n_source):
    % if (acc_wr_is_parallel_out[j]):
      % for k in range (acc_wr_out_parallelism_factor[j]):

  logic unsigned [($clog2(${acc_wr_target.upper()}_CNT_LEN)+1):0] kernel_cnt_${acc_wr_stream_out[j]}_${k};

  // Suggested design:
  //      ap_done = done_out0 & ... & done_outM;
  //      done_outM = cnt_out,i == ctrl_i.max_out,i; (for i=1,..,N)
  // However, loop ctrl is already implemented in micro-code looper that sits
  // in the hwpe-ctrl. Thus, the done information provided by this stage should 
  // concern a single output element, not a tile (block,..).
  // FIXME: At this point, cnt_out is not essential here and could be removed.

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_${acc_wr_stream_out[j]}_${k}
    if((~rst_ni) | kernel_start)
      kernel_cnt_${acc_wr_stream_out[j]}_${k} = 32'b0;
    else if(!kernel_idle) begin
      if((${acc_wr_stream_out[j]}_${k}_o.valid)&(${acc_wr_stream_out[j]}_${k}_o.ready))
        kernel_cnt_${acc_wr_stream_out[j]}_${k} = kernel_cnt_${acc_wr_stream_out[j]}_${k} + 1;
      else
        kernel_cnt_${acc_wr_stream_out[j]}_${k} = kernel_cnt_${acc_wr_stream_out[j]}_${k};
    end
  end

  assign cnt_${acc_wr_stream_out[j]}_${k} = kernel_cnt_${acc_wr_stream_out[j]}_${k};

      % endfor
    % else:

  logic unsigned [($clog2(${acc_wr_target.upper()}_CNT_LEN)+1):0] kernel_cnt_${acc_wr_stream_out[j]};

  // Suggested design:
  //      ap_done = done_out0 & ... & done_outM;
  //      done_outM = cnt_out,i == ctrl_i.max_out,i; (for i=1,..,N)
  // However, loop ctrl is already implemented in micro-code looper that sits
  // in the hwpe-ctrl. Thus, the done information provided by this stage should 
  // concern a single output element, not a tile (block,..).
  // FIXME: At this point, cnt_out is not essential here and could be removed.

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_${acc_wr_stream_out[j]}
    if((~rst_ni) | kernel_start)
      kernel_cnt_${acc_wr_stream_out[j]} = 32'b0;
    else if(!kernel_idle) begin
      if((${acc_wr_stream_out[j]}_o.valid)&(${acc_wr_stream_out[j]}_o.ready))
        kernel_cnt_${acc_wr_stream_out[j]} = kernel_cnt_${acc_wr_stream_out[j]} + 1;
      else
        kernel_cnt_${acc_wr_stream_out[j]} = kernel_cnt_${acc_wr_stream_out[j]};
    end
  end

  assign cnt_${acc_wr_stream_out[j]} = kernel_cnt_${acc_wr_stream_out[j]};

    % endif
  % endfor

</%def>

<%
######################################################
## Kernel interface - MDC dataflow kernel interface ##
######################################################
%>

<%def name="mdc_dataflow_kernel_intf()">\

  /* ${acc_wr_target} kernel interface. */

  ${acc_wr_target} i_${acc_wr_target} (
    // Global signals.
    .ap_clk             ( clk_i            ), 
    .ap_rst_n           ( rst_ni           ), 

    % if acc_wr_custom_reg_num>0:
    // Kernel parameters
      % for i in range (acc_wr_custom_reg_num):
        % if acc_wr_custom_reg_isport[i]:
    .${acc_wr_custom_reg_name[i]}        ( ${acc_wr_custom_reg_name[i]} ),
        % endif
      % endfor
    % endif 

    // Sink ports
    % for i in range (acc_wr_n_sink):
      % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
    .${acc_wr_stream_in[i]}_${k}_TDATA  ( ${acc_wr_stream_in[i]}_${k}_i.data  ),
    .${acc_wr_stream_in[i]}_${k}_TVALID ( ${acc_wr_stream_in[i]}_${k}_i.valid ),
    .${acc_wr_stream_in[i]}_${k}_TREADY ( ${acc_wr_stream_in[i]}_${k}_i.ready ),
        % endfor
      % else:
    .${acc_wr_stream_in[i]}_TDATA  ( ${acc_wr_stream_in[i]}_i.data  ),
    .${acc_wr_stream_in[i]}_TVALID ( ${acc_wr_stream_in[i]}_i.valid ),
    .${acc_wr_stream_in[i]}_TREADY ( ${acc_wr_stream_in[i]}_i.ready ),
      % endif
    % endfor  

    // Source ports
    % for j in range (acc_wr_n_source-1):
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
    .${acc_wr_stream_out[j]}_${k}_TDATA  ( ${acc_wr_stream_out[j]}_${k}_o.data  ),
    .${acc_wr_stream_out[j]}_${k}_TVALID ( ${acc_wr_stream_out[j]}_${k}_o.valid ),
    .${acc_wr_stream_out[j]}_${k}_TREADY ( ${acc_wr_stream_out[j]}_${k}_o.ready ),
        % endfor
      % else:
    .${acc_wr_stream_out[j]}_TDATA  ( ${acc_wr_stream_out[j]}_o.data  ),
    .${acc_wr_stream_out[j]}_TVALID ( ${acc_wr_stream_out[j]}_o.valid ),
    .${acc_wr_stream_out[j]}_TREADY ( ${acc_wr_stream_out[j]}_o.ready ),
      % endif
    % endfor

    % if (acc_wr_is_parallel_out[acc_wr_n_source-1]):
      % for k in range (acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1):
    .${acc_wr_stream_out[acc_wr_n_source-1]}_${k}_TDATA  ( ${acc_wr_stream_out[acc_wr_n_source-1]}_${k}_o.data  ),
    .${acc_wr_stream_out[acc_wr_n_source-1]}_${k}_TVALID ( ${acc_wr_stream_out[acc_wr_n_source-1]}_${k}_o.valid ),
    .${acc_wr_stream_out[acc_wr_n_source-1]}_${k}_TREADY ( ${acc_wr_stream_out[acc_wr_n_source-1]}_${k}_o.ready ),
      % endfor
    % else:
    .${acc_wr_stream_out[acc_wr_n_source-1]}_TDATA  ( ${acc_wr_stream_out[acc_wr_n_source-1]}_o.data  ),
    .${acc_wr_stream_out[acc_wr_n_source-1]}_TVALID ( ${acc_wr_stream_out[acc_wr_n_source-1]}_o.valid ),
    .${acc_wr_stream_out[acc_wr_n_source-1]}_TREADY ( ${acc_wr_stream_out[acc_wr_n_source-1]}_o.ready )
    % endif

    % if (acc_wr_is_parallel_out[acc_wr_n_source-1]):
    .${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}_TDATA  ( ${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}_o.data  ),
    .${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}_TVALID ( ${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}_o.valid ),
    .${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}_TREADY ( ${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1}_o.ready )
    % endif

  );

</%def>

<%
################################################
## Kernel interface - Generate stream strobes ##
################################################
%>

<%def name="mdc_dataflow_stream_strobes()">\

</%def>

<%
#############################################
## Kernel interface - AND-ing done signals ##
#############################################
%>


<%def name="AND_kernel_done_in()">\
\
% for i in range (acc_wr_n_sink-1):
    % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
kernel_done_${acc_wr_stream_in[i]}_${k} & \
        % endfor
    % else:
kernel_done_${acc_wr_stream_in[i]} & \
    % endif
% endfor
\
% if (acc_wr_is_parallel_in[acc_wr_n_sink-1]):
    % for k in range (acc_wr_in_parallelism_factor[acc_wr_n_sink-1]-1):
kernel_done_${acc_wr_stream_in[acc_wr_n_sink-1]}_${k} & \
    % endfor
kernel_done_${acc_wr_stream_in[acc_wr_n_sink-1]}_${acc_wr_in_parallelism_factor[acc_wr_n_sink-1]-1};\
% else:
kernel_done_${acc_wr_stream_in[acc_wr_n_sink-1]}\
% endif
\
</%def>

<%def name="AND_kernel_done_out()">\
\
% for j in range (acc_wr_n_source-1):
    % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
kernel_done_${acc_wr_stream_out[j]}_${k} & \
        % endfor
    % else:
kernel_done_${acc_wr_stream_out[j]} & \
    % endif
% endfor
\
% if (acc_wr_is_parallel_out[acc_wr_n_source-1]):
    % for k in range (acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1):
kernel_done_${acc_wr_stream_out[acc_wr_n_source-1]}_${k} & \
    % endfor
kernel_done_${acc_wr_stream_out[acc_wr_n_source-1]}_${acc_wr_out_parallelism_factor[acc_wr_n_source-1]-1};\
% else:
kernel_done_${acc_wr_stream_out[acc_wr_n_source-1]}\
% endif
\
</%def>