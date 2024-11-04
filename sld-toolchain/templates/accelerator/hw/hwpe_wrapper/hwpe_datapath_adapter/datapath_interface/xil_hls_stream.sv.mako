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

    Description:    HWPE datapath adapter.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
####################################################
## Datapath interface - Xilinx hls::stream object ##
####################################################
%>

<%
############################################
## Datapath interface - Datapath controls ##
############################################
%>

<%def name="xil_hls_stream_datapath_ctrl_def()">\

  // Global controls
  logic start_stream;

  // Input stream controls
  % for i in range (acc_wr_n_sink):
  logic [${n_bytes_in[i]}-1:0] ${acc_wr_stream_in[i]}_i_TKEEP;
  logic ${acc_wr_stream_in[i]}_i_TUSER;
  logic ${acc_wr_stream_in[i]}_i_TLAST;
  logic ${acc_wr_stream_in[i]}_i_TID;
  logic ${acc_wr_stream_in[i]}_i_TDEST;
  % endfor

  // Input data packet transaction counter
  % for i in range (acc_wr_n_sink):
  logic unsigned [31:0] cnt_last_${acc_wr_stream_in[i]};
  % endfor

  // Output transaction counter
  % for j in range (acc_wr_n_source):
  logic unsigned [31:0] cnt_last_${acc_wr_stream_out[j]};
  % endfor

</%def>

<%def name="xil_hls_stream_datapath_ctrl()">\

  // Pilot global controls
  % for j in range (acc_wr_n_source):
  always_comb
  begin: pilot_start
    if(~rst_ni) begin
      start_stream = '0;
    end
    else if(ctrl_i.start) begin
      start_stream = '1;
    end
    else if(flags_o.done) begin
      start_stream = '0;
    end
    else if ((${acc_wr_stream_out[j]}_o.valid) & (${acc_wr_stream_out[j]}_o.ready)) begin
      start_stream = start_stream;
    end
    else begin
      start_stream = start_stream;
    end
  end
  % endfor

  // Pilot input streaming controls
  % for i in range (acc_wr_n_sink):
  assign ${acc_wr_stream_in[i]}_i_TKEEP = '1;
  assign ${acc_wr_stream_in[i]}_i_TID   = '0;
  assign ${acc_wr_stream_in[i]}_i_TDEST = '0;

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: gen_user_${acc_wr_stream_in[i]}
    if(~rst_ni) begin
      ${acc_wr_stream_in[i]}_i_TUSER = '0;
    end
    else if(ctrl_i.start) begin
      ${acc_wr_stream_in[i]}_i_TUSER = '1;
    end
    else if ((${acc_wr_stream_in[i]}_i.valid) & (${acc_wr_stream_in[i]}_i.ready)) begin
      ${acc_wr_stream_in[i]}_i_TUSER = '0;
    end
    else begin
      ${acc_wr_stream_in[i]}_i_TUSER = ${acc_wr_stream_in[i]}_i_TUSER;
    end
  end
  % endfor

  // Count input data packet transactions
  % for i in range (acc_wr_n_sink):
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: adapter_cnt_${acc_wr_stream_in[i]}_tx
    if(~rst_ni) begin
      cnt_last_${acc_wr_stream_in[i]} = '0;
    end
    else if(ctrl_i.start) begin
      cnt_last_${acc_wr_stream_in[i]} = '0;
    end
    else if(${acc_wr_stream_in[i]}_i_TLAST) begin
      cnt_last_${acc_wr_stream_in[i]} = '0;
    end
    else if ((${acc_wr_stream_in[i]}_i.valid) & (${acc_wr_stream_in[i]}_i.ready)) begin
      cnt_last_${acc_wr_stream_in[i]} = cnt_last_${acc_wr_stream_in[i]} + 1;
    end
    else begin
      cnt_last_${acc_wr_stream_in[i]} = cnt_last_${acc_wr_stream_in[i]};
    end
  end
  % endfor

  // Generate input last signal (for data packets)
  % for i in range (acc_wr_n_sink):
  assign ${acc_wr_stream_in[i]}_i_TLAST = (cnt_last_${acc_wr_stream_in[i]}==ctrl_i.packet_size_${acc_wr_stream_in[i]}) ? 1 : 0;
  % endfor

  // Count output transactions
  % for j in range (acc_wr_n_source):
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: adapter_cnt_${acc_wr_stream_out[j]}_tx
    if(~rst_ni) begin
      cnt_last_${acc_wr_stream_out[j]} = '0;
    end
    else if(ctrl_i.start) begin
      cnt_last_${acc_wr_stream_out[j]} = '0;
    end
    else if ((${acc_wr_stream_out[j]}_o.valid) & (${acc_wr_stream_out[j]}_o.ready)) begin
      cnt_last_${acc_wr_stream_out[j]} = cnt_last_${acc_wr_stream_out[j]} + 1;
    end
    else begin
      cnt_last_${acc_wr_stream_out[j]} = cnt_last_${acc_wr_stream_out[j]};
    end
  end
  % endfor

</%def>

<%
##################################################
## Datapath interface - Generate stream strobes ##
##################################################
%>

<%def name="xil_hls_stream_stream_strobes_def()">\

  // Input strobes
  % for i in range (acc_wr_n_sink):
  logic [${n_bytes_in[i]}-1:0] ${acc_wr_stream_in[i]}_i_TSTRB;
  % endfor

  // Output strobes
  % for j in range (acc_wr_n_source):
  logic [${n_bytes_out[j]}-1:0] ${acc_wr_stream_out[j]}_o_TSTRB;
  % endfor

</%def>

<%def name="xil_hls_stream_stream_strobes()">\

  // Assign input strobes
  % for i in range (acc_wr_n_sink):
  assign ${acc_wr_stream_in[i]}_i_TSTRB = '0;
  % endfor

  // Get output strobes
  % for j in range (acc_wr_n_source):
  assign ${acc_wr_stream_out[j]}_o.strb = '1;
  % endfor

</%def>

<%
#########################################
## Datapath interface - Datapath flags ##
#########################################
%>

<%def name="xil_hls_stream_datapath_flags_def()">\

  // Output stream flags
  % for j in range (acc_wr_n_source):
  logic [${n_bytes_out[j]}-1:0] ${acc_wr_stream_out[j]}_o_TKEEP;
  logic ${acc_wr_stream_out[j]}_o_TUSER;
  logic ${acc_wr_stream_out[j]}_o_TLAST;
  logic ${acc_wr_stream_out[j]}_o_TID;
  logic ${acc_wr_stream_out[j]}_o_TDEST;
  % endfor

</%def>

<%def name="xil_hls_stream_datapath_flags()">\

  // Get output last signal (for data packets)
  % for j in range (acc_wr_n_source):
  assign flags_o.last[${j}] = ${acc_wr_stream_out[j]}_o_TLAST;
  % endfor

</%def>

<%
################################################################
## Datapath interface - Xilinx hls::stream datapath interface ##
################################################################
%>

<%def name="xil_hls_stream_datapath_intf()">\

  /* ${acc_wr_target} datapath interface */

  ${acc_wr_target} i_${acc_wr_target} (
    // Global signals
    .ap_clk       ( clk_i            ),
    .ap_rst_n     ( rst_ni           ),

    // Sink ports
    % for i in range (acc_wr_n_sink):
    .${acc_wr_stream_in[i]}_TDATA  ( ${acc_wr_stream_in[i]}_data_datapath ),
    .${acc_wr_stream_in[i]}_TVALID ( ${acc_wr_stream_in[i]}_i.valid ),
    .${acc_wr_stream_in[i]}_TREADY ( ${acc_wr_stream_in[i]}_i.ready ),

    .${acc_wr_stream_in[i]}_TKEEP  ( ${acc_wr_stream_in[i]}_i_TKEEP ),
    .${acc_wr_stream_in[i]}_TSTRB  ( ${acc_wr_stream_in[i]}_i_TSTRB ),
    .${acc_wr_stream_in[i]}_TUSER  ( ${acc_wr_stream_in[i]}_i_TUSER ),
    .${acc_wr_stream_in[i]}_TLAST  ( ${acc_wr_stream_in[i]}_i_TLAST ),
    .${acc_wr_stream_in[i]}_TID    ( ${acc_wr_stream_in[i]}_i_TID   ),
    .${acc_wr_stream_in[i]}_TDEST  ( ${acc_wr_stream_in[i]}_i_TDEST ),
    % endfor

    // Source ports
    % for j in range (acc_wr_n_source):
    .${acc_wr_stream_out[j]}_TDATA  ( ${acc_wr_stream_out[j]}_data_datapath ),
    .${acc_wr_stream_out[j]}_TVALID ( ${acc_wr_stream_out[j]}_o.valid ),
    .${acc_wr_stream_out[j]}_TREADY ( ${acc_wr_stream_out[j]}_o.ready ),

    .${acc_wr_stream_out[j]}_TKEEP  ( ${acc_wr_stream_out[j]}_o_TKEEP ),
    .${acc_wr_stream_out[j]}_TSTRB  ( ${acc_wr_stream_out[j]}_o_TSTRB ),
    .${acc_wr_stream_out[j]}_TUSER  ( ${acc_wr_stream_out[j]}_o_TUSER ),
    .${acc_wr_stream_out[j]}_TLAST  ( ${acc_wr_stream_out[j]}_o_TLAST ),
    .${acc_wr_stream_out[j]}_TID    ( ${acc_wr_stream_out[j]}_o_TID   ),
    .${acc_wr_stream_out[j]}_TDEST  ( ${acc_wr_stream_out[j]}_o_TDEST ),
    % endfor

    % if acc_wr_custom_reg_num>0:
    // Datapath parameters
      % for i in range (acc_wr_custom_reg_num):
        % if acc_wr_custom_reg_isport[i]:
    .${acc_wr_custom_reg_name[i]}        ( ${acc_wr_custom_reg_name[i]} ),
        % endif
      % endfor
    % endif

    // Control signals
    .ap_start      ( start_stream             ),
    .ap_done       ( flags_o.done             ),
    .ap_idle       ( flags_o.idle             ),
    .ap_ready      ( flags_o.ready            )
  );
</%def>

<%
#########################################################
## Datapath interface - Match data width of IO streams ##
#########################################################
%>

<%def name="xil_hls_stream_stream_dwidth_match_def()">\

  // Input data - Data width adaptation
  % for i in range (acc_wr_n_sink):
  logic [${acc_wr_stream_in_dwidth[i]}-1:0] ${acc_wr_stream_in[i]}_data_datapath;
  % endfor

  // Output data - Data width adaptation
  % for j in range (acc_wr_n_source):
  logic [${acc_wr_stream_out_dwidth[j]}-1:0] ${acc_wr_stream_out[j]}_data_datapath;
  % endfor

</%def>

<%def name="xil_hls_stream_stream_dwidth_match()">\

  // Adapat input data interface (from system) to datapath data interface
  % for i in range (acc_wr_n_sink):
    % if acc_wr_stream_in_dwidth[i]>pulp_dwidth:

      <%
        diff_dwidth = acc_wr_stream_in_dwidth[i] - pulp_dwidth
      %>
\
  assign ${acc_wr_stream_in[i]}_data_datapath = {${diff_dwidth}'b0, ${acc_wr_stream_in[i]}_i.data};

    % elif acc_wr_stream_in_dwidth[i]<pulp_dwidth:

      <%
        diff_dwidth = pulp_dwidth - acc_wr_stream_in_dwidth[i]
      %>
\
  // TO-DO: Not supported yet
  assign ${acc_wr_stream_in[i]}_data_datapath = ${acc_wr_stream_in[i]}_i.data;

    % elif acc_wr_stream_in_dwidth[i]==pulp_dwidth:
\
  assign ${acc_wr_stream_in[i]}_data_datapath = ${acc_wr_stream_in[i]}_i.data;

    % endif
  % endfor

  // Adapat datapath data interface to output data interface (to system)
  % for j in range (acc_wr_n_source):
    % if acc_wr_stream_out_dwidth[j]>pulp_dwidth:

      <%
        diff_dwidth = acc_wr_stream_out_dwidth[j] - pulp_dwidth
      %>
\
  // TO-DO: Not supported yet
  assign ${acc_wr_stream_out[j]}_o.data = ${acc_wr_stream_out[j]}_data_datapath;

    % elif acc_wr_stream_out_dwidth[j]<pulp_dwidth:

      <%
        diff_dwidth = pulp_dwidth - acc_wr_stream_out_dwidth[j]
      %>
\
  assign ${acc_wr_stream_out[j]}_o.data = {${diff_dwidth}'b0, ${acc_wr_stream_out[j]}_data_datapath};

    % elif acc_wr_stream_out_dwidth[j]==pulp_dwidth:
\
  assign ${acc_wr_stream_out[j]}_o.data = ${acc_wr_stream_out[j]}_data_datapath;

    % endif
  % endfor
</%def>
