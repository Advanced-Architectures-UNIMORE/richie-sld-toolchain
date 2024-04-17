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

    Description:    HWPE FSM.

    Date:           11.6.2021

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
###############################################
## Library of components - Address generator ##
###############################################
%>

<%
#############################################################################
## Address generator - Mapping control signals to streamer (input streams) ##
#############################################################################
%>

<%def name="addressgen_mapping_in()">\

  % for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
      % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
    // Input stream - ${acc_wr_stream_in[i]}_${k} (unrolled, programmable)
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.${acc_wr_stream_in[i]}_trans_size;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.${acc_wr_stream_in[i]}_line_stride;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.${acc_wr_stream_in[i]}_line_length;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.${acc_wr_stream_in[i]}_feat_stride;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.${acc_wr_stream_in[i]}_feat_length;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.${acc_wr_stream_in[i]}_port_offset * ${k} + reg_file_i.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_ADDR] + (flags_ucode_i.offs[${TARGET}_UCODE_${acc_wr_stream_in[i].upper()}_OFFS]);
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.${acc_wr_stream_in[i]}_feat_roll;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.${acc_wr_stream_in[i]}_loop_outer;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.${acc_wr_stream_in[i]}_realign_type;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.step            = ctrl_i.${acc_wr_stream_in[i]}_step;
        % endfor
      % else:
    // Input stream - ${acc_wr_stream_in[i]} (programmable)
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.${acc_wr_stream_in[i]}_trans_size;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.${acc_wr_stream_in[i]}_line_stride;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.${acc_wr_stream_in[i]}_line_length;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.${acc_wr_stream_in[i]}_feat_stride;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.${acc_wr_stream_in[i]}_feat_length;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.base_addr       = reg_file_i.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_ADDR] + (flags_ucode_i.offs[${TARGET}_UCODE_${acc_wr_stream_in[i].upper()}_OFFS]);
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.${acc_wr_stream_in[i]}_feat_roll;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.${acc_wr_stream_in[i]}_loop_outer;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.${acc_wr_stream_in[i]}_realign_type;
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.step            = ctrl_i.${acc_wr_stream_in[i]}_step;
      % endif
    % else:
      % if (acc_wr_is_parallel_in[i]):
        % for k in range (acc_wr_in_parallelism_factor[i]):
    // Input stream - ${acc_wr_stream_in[i]}_${k} (unrolled, hardwired)
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.trans_size      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.line_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.line_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.feat_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.feat_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.base_addr       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.feat_roll       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.loop_outer      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.realign_type    = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_${k}_source_ctrl.addressgen_ctrl.step            = /* ASSIGN A VALUE */
        % endfor
      % else:
    // Input stream - ${acc_wr_stream_in[i]} (hardwired)
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.trans_size      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.line_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.line_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.feat_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.feat_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.base_addr       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.feat_roll       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.loop_outer      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.realign_type    = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_in[i]}_source_ctrl.addressgen_ctrl.step            = /* ASSIGN A VALUE */
      % endif
    % endif
  % endfor

</%def>

<%
##############################################################################
## Address generator - Mapping control signals to streamer (output streams) ##
##############################################################################
%>

<%def name="addressgen_mapping_out()">\

  % for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
    // Output stream - ${acc_wr_stream_out[j]}_${k} (unrolled, programmable)
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.trans_size      = ctrl_i.${acc_wr_stream_out[j]}_trans_size;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.line_stride     = ctrl_i.${acc_wr_stream_out[j]}_line_stride;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.line_length     = ctrl_i.${acc_wr_stream_out[j]}_line_length;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.${acc_wr_stream_out[j]}_feat_stride;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.feat_length     = ctrl_i.${acc_wr_stream_out[j]}_feat_length;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.base_addr       = ctrl_i.${acc_wr_stream_out[j]}_port_offset * ${k} + reg_file_i.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_ADDR] + (flags_ucode_i.offs[${TARGET}_UCODE_${acc_wr_stream_out[j].upper()}_OFFS]);
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.${acc_wr_stream_out[j]}_feat_roll;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.${acc_wr_stream_out[j]}_loop_outer;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.realign_type    = ctrl_i.${acc_wr_stream_out[j]}_realign_type;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.step            = ctrl_i.${acc_wr_stream_out[j]}_step;
        % endfor
      % else:
    // Output stream - ${acc_wr_stream_out[j]} (programmable)
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.trans_size      = ctrl_i.${acc_wr_stream_out[j]}_trans_size;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.line_stride     = ctrl_i.${acc_wr_stream_out[j]}_line_stride;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.line_length     = ctrl_i.${acc_wr_stream_out[j]}_line_length;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.${acc_wr_stream_out[j]}_feat_stride;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.feat_length     = ctrl_i.${acc_wr_stream_out[j]}_feat_length;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.base_addr       = reg_file_i.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_ADDR] + (flags_ucode_i.offs[${TARGET}_UCODE_${acc_wr_stream_out[j].upper()}_OFFS]);
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.${acc_wr_stream_out[j]}_feat_roll;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.${acc_wr_stream_out[j]}_loop_outer;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.realign_type    = ctrl_i.${acc_wr_stream_out[j]}_realign_type;
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.step            = ctrl_i.${acc_wr_stream_out[j]}_step;
      % endif
    % else:
      % if (acc_wr_is_parallel_out[j]):
        % for k in range (acc_wr_out_parallelism_factor[j]):
    // Output stream - ${acc_wr_stream_out[j]}_${k} (unrolled, hardwired)
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.trans_size      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.line_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.line_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.feat_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.feat_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.base_addr       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.feat_roll       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.loop_outer      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.realign_type    = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_${k}_sink_ctrl.addressgen_ctrl.step            = /* ASSIGN A VALUE */
        % endfor
      % else:
    // Output stream - ${acc_wr_stream_out[j]} (hardwired)
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.trans_size      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.line_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.line_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.feat_stride     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.feat_length     = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.base_addr       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.feat_roll       = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.loop_outer      = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.realign_type    = /* ASSIGN A VALUE */
    ctrl_streamer_o.${acc_wr_stream_out[j]}_sink_ctrl.addressgen_ctrl.step            = /* ASSIGN A VALUE */
      % endif
    % endif
  % endfor

</%def>

