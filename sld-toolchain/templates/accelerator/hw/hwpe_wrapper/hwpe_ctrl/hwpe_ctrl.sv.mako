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

    Description:    HWPE controller.

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

/*
 * Copyright (C) 2018 ETH Zurich, University of Bologna
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * Author: Francesco Conti <fconti@iis.ee.ethz.ch>
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: ${acc_wr_target}_ctrl.sv
 *
 */

import ${acc_wr_target}_package::*;
import hwpe_ctrl_package::*;

module ${acc_wr_target}_ctrl
#(
  parameter int unsigned N_CORES         = 2,
  parameter int unsigned N_CONTEXT       = 2,
  parameter int unsigned N_IO_REGS       = 16,
  parameter int unsigned ID              = 10,
  parameter int unsigned UCODE_HARDWIRED = 0
)
(\
  // Global signals
  input  logic                                  clk_i,
  input  logic                                  rst_ni,
  input  logic                                  test_mode_i,
  output logic                                  clear_o,
  // events
  output logic [N_CORES-1:0][REGFILE_N_EVT-1:0] evt_o,
  // ctrl & flags
  output ctrl_streamer_${acc_wr_target}_t                        ctrl_streamer_o,
  input  flags_streamer_${acc_wr_target}_t                       flags_streamer_i,
  output ctrl_engine_${acc_wr_target}_t                          ctrl_engine_o,
  input  flags_engine_${acc_wr_target}_t                         flags_engine_i,
  // periph slave port
  hwpe_ctrl_intf_periph.slave                   periph
);

  /* Ctrl/flag signals */

  // Slave
  ctrl_slave_t   slave_ctrl;
  flags_slave_t  slave_flags;

  // Register file
  ctrl_regfile_t reg_file;

  // Uloop
  logic [223:0]  ucode_flat;
  uloop_code_t   ucode;
  ctrl_uloop_t   ucode_ctrl;
  flags_uloop_t  ucode_flags;
  logic [11:0][31:0] ucode_registers_read;

  /* Standard registers */

  // Uloop
  logic unsigned [31:0] static_reg_nb_iter;
  logic unsigned [31:0] static_reg_vectstride;
  logic unsigned [31:0] static_reg_onestride;

  // Address generator
  % for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
  // Controls - ${acc_wr_stream_in[i]}
  logic unsigned [31:0] static_reg_${acc_wr_stream_in[i]}_trans_size;
  logic unsigned [15:0] static_reg_${acc_wr_stream_in[i]}_line_stride;
  logic unsigned [15:0] static_reg_${acc_wr_stream_in[i]}_line_length;
  logic unsigned [15:0] static_reg_${acc_wr_stream_in[i]}_feat_stride;
  logic unsigned [15:0] static_reg_${acc_wr_stream_in[i]}_feat_length;
  logic unsigned [15:0] static_reg_${acc_wr_stream_in[i]}_feat_roll;
  logic unsigned [15:0] static_reg_${acc_wr_stream_in[i]}_step;
  logic unsigned static_reg_${acc_wr_stream_in[i]}_loop_outer;
  logic unsigned static_reg_${acc_wr_stream_in[i]}_realign_type;
      % if (acc_wr_is_parallel_in[i]):
  logic unsigned [31:0] static_reg_${acc_wr_stream_in[i]}_port_offset;
      % endif
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
  // Controls - ${acc_wr_stream_out[j]}
  logic unsigned [31:0] static_reg_${acc_wr_stream_out[j]}_trans_size;
  logic unsigned [15:0] static_reg_${acc_wr_stream_out[j]}_line_stride;
  logic unsigned [15:0] static_reg_${acc_wr_stream_out[j]}_line_length;
  logic unsigned [15:0] static_reg_${acc_wr_stream_out[j]}_feat_stride;
  logic unsigned [15:0] static_reg_${acc_wr_stream_out[j]}_feat_length;
  logic unsigned [15:0] static_reg_${acc_wr_stream_out[j]}_feat_roll;
  logic unsigned [15:0] static_reg_${acc_wr_stream_out[j]}_step;
  logic unsigned static_reg_${acc_wr_stream_out[j]}_loop_outer;
  logic unsigned static_reg_${acc_wr_stream_out[j]}_realign_type;
      % if (acc_wr_is_parallel_out[j]):
  logic unsigned [31:0] static_reg_${acc_wr_stream_out[j]}_port_offset;
      % endif
    % endif
  % endfor

  % if acc_wr_is_hls_stream is True:
  // Packet size - hls::stream
    % for i in range (acc_wr_n_sink):
  logic unsigned [31:0] static_reg_packet_size_${acc_wr_stream_in[i]};
    % endfor
  % endif

  // Number of compute cycles per output data
  // TODO: Add more documentation for this
  % for j in range (acc_wr_n_source):
  logic unsigned [31:0] static_reg_cnt_limit_${acc_wr_stream_out[j]};
  % endfor

  % if acc_wr_custom_reg_num>0:
  /* Custom registers */
  % for i in range (acc_wr_custom_reg_num):
  logic unsigned [(${acc_wr_custom_reg_dim[i]}-1):0] static_reg_${acc_wr_custom_reg_name[i]};
  % endfor
  % endif

  /* FSM input signals */
  ctrl_fsm_${acc_wr_target}_t fsm_ctrl;

  /* Peripheral slave & register file */
  hwpe_ctrl_slave #(
    .N_CORES        ( N_CORES               ),
    .N_CONTEXT      ( N_CONTEXT             ),
    .N_IO_REGS      ( N_IO_REGS             ),
    .N_GENERIC_REGS ( (1-UCODE_HARDWIRED)*8 ),
    .ID_WIDTH       ( ID                    )
  ) i_slave (
    .clk_i    ( clk_i       ),
    .rst_ni   ( rst_ni      ),
    .clear_o  ( clear_o     ),
    .cfg      ( periph      ),
    .ctrl_i   ( slave_ctrl  ),
    .flags_o  ( slave_flags ),
    .reg_file ( reg_file    )
  );

  /* Events */
  assign evt_o = slave_flags.evt;

  /* Direct register file mappings */

  // Uloop registers
  assign static_reg_nb_iter    = reg_file.hwpe_params[${TARGET}_REG_NB_ITER]  + 1;
  assign static_reg_linestride = reg_file.hwpe_params[${TARGET}_REG_SHIFT_LINESTRIDE];
  assign static_reg_tilestride = reg_file.hwpe_params[${TARGET}_REG_SHIFT_TILESTRIDE];
  assign static_reg_onestride  = 4;

  % if acc_wr_is_hls_stream is True:
  // Packet size - hls::stream
    % for i in range (acc_wr_n_sink):
  assign static_reg_packet_size_${acc_wr_stream_in[i]} = reg_file.hwpe_params[${TARGET}_REG_PACKET_SIZE_${acc_wr_stream_in[i].upper()}];
    % endfor
  % endif

  // Number of compute cycles per output data
  // TODO: Add more documentation for this
  % for j in range (acc_wr_n_source):
  assign static_reg_cnt_limit_${acc_wr_stream_out[j]} = reg_file.hwpe_params[${TARGET}_REG_CNT_LIMIT_${acc_wr_stream_out[j].upper()}] + 1;
  % endfor

  // Address generator
  % for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
  // Mapping - ${acc_wr_stream_in[i]}
  assign static_reg_${acc_wr_stream_in[i]}_trans_size          = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_TRANS_SIZE];
  assign static_reg_${acc_wr_stream_in[i]}_line_stride         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_LINE_STRIDE];
  assign static_reg_${acc_wr_stream_in[i]}_line_length         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_LINE_LENGTH];
  assign static_reg_${acc_wr_stream_in[i]}_feat_stride         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_FEAT_STRIDE];
  assign static_reg_${acc_wr_stream_in[i]}_feat_length         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_FEAT_LENGTH];
  assign static_reg_${acc_wr_stream_in[i]}_feat_roll           = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_FEAT_ROLL];
  assign static_reg_${acc_wr_stream_in[i]}_step                = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_STEP];
  assign static_reg_${acc_wr_stream_in[i]}_loop_outer          = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_LOOP_OUTER];
  assign static_reg_${acc_wr_stream_in[i]}_realign_type        = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_REALIGN_TYPE];
      % if (acc_wr_is_parallel_in[i]):
  assign static_reg_${acc_wr_stream_in[i]}_port_offset         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_in[i].upper()}_PORT_OFFSET];
      % endif
    % endif
  % endfor

  % for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
  // Mapping - ${acc_wr_stream_out[j]}
  assign static_reg_${acc_wr_stream_out[j]}_trans_size         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_TRANS_SIZE];
  assign static_reg_${acc_wr_stream_out[j]}_line_stride        = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_LINE_STRIDE];
  assign static_reg_${acc_wr_stream_out[j]}_line_length        = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_LINE_LENGTH];
  assign static_reg_${acc_wr_stream_out[j]}_feat_stride        = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_FEAT_STRIDE];
  assign static_reg_${acc_wr_stream_out[j]}_feat_length        = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_FEAT_LENGTH];
  assign static_reg_${acc_wr_stream_out[j]}_feat_roll          = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_FEAT_ROLL];
  assign static_reg_${acc_wr_stream_out[j]}_step               = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_STEP];
  assign static_reg_${acc_wr_stream_out[j]}_loop_outer         = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_LOOP_OUTER];
  assign static_reg_${acc_wr_stream_out[j]}_realign_type       = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_REALIGN_TYPE];
      % if (acc_wr_is_parallel_out[j]):
  assign static_reg_${acc_wr_stream_out[j]}_port_offset        = reg_file.hwpe_params[${TARGET}_REG_${acc_wr_stream_out[j].upper()}_PORT_OFFSET];
      % endif
    % endif
  % endfor

  % if acc_wr_custom_reg_num>0:
  // Custom registers
    % for i in range (acc_wr_custom_reg_num):
  assign static_reg_${acc_wr_custom_reg_name[i]} = reg_file.hwpe_params[${acc_wr_target.upper()}_REG_${acc_wr_custom_reg_name[i].upper()}];
    % endfor
  % endif


  /* Microcode processor */
  generate
    if(UCODE_HARDWIRED != 0) begin
      // equivalent to the microcode in ucode/code.yml
      assign ucode_flat = 224'h0000000000040000000000000000000000000000000008cd11a12c05;
    end
    else begin
      // the microcode is stored in registers independent of context (job)
      assign ucode_flat = reg_file.generic_params[6:0];
    end
  endgenerate
  assign ucode = {
    // loops & bytecode
    ucode_flat,
    // ranges
    12'b0,
    12'b0,
    12'b0,
    12'b0,
    12'b0,
    static_reg_nb_iter[11:0]
  };
  assign ucode_registers_read[${TARGET}_UCODE_MNEM_NBITER]     = static_reg_nb_iter;
  assign ucode_registers_read[${TARGET}_UCODE_MNEM_ITERSTRIDE] = static_reg_linestride;
  assign ucode_registers_read[${TARGET}_UCODE_MNEM_ONESTRIDE]  = static_reg_onestride;
  assign ucode_registers_read[${TARGET}_UCODE_MNEM_TILESTRIDE] = static_reg_tilestride;
  assign ucode_registers_read[11:4] = '0;

  hwpe_ctrl_uloop #(
    .NB_LOOPS       ( 2  ), // Default: 1
    .NB_REG         ( 4  ),
    .NB_RO_REG      ( 12 ),
    .DEBUG_DISPLAY  ( 1  )  // Default: 0
  ) i_uloop (
    .clk_i            ( clk_i                ),
    .rst_ni           ( rst_ni               ),
    .test_mode_i      ( test_mode_i          ),
    .clear_i          ( clear_o              ),
    .ctrl_i           ( ucode_ctrl           ),
    .flags_o          ( ucode_flags          ),
    .uloop_code_i     ( ucode                ),
    .registers_read_i ( ucode_registers_read )
  );

  /* Main FSM */
  ${acc_wr_target}_fsm i_fsm (
    .clk_i            ( clk_i              ),
    .rst_ni           ( rst_ni             ),
    .test_mode_i      ( test_mode_i        ),
    .clear_i          ( clear_o            ),
    .ctrl_streamer_o  ( ctrl_streamer_o    ),
    .flags_streamer_i ( flags_streamer_i   ),
    .ctrl_engine_o    ( ctrl_engine_o      ),
    .flags_engine_i   ( flags_engine_i     ),
    .ctrl_ucode_o     ( ucode_ctrl         ),
    .flags_ucode_i    ( ucode_flags        ),
    .ctrl_slave_o     ( slave_ctrl         ),
    .flags_slave_i    ( slave_flags        ),
    .reg_file_i       ( reg_file           ),
    .ctrl_i           ( fsm_ctrl           )
  );
  always_comb
  begin

    // Address generator
    % for i in range (acc_wr_n_sink):
      % if (acc_wr_addr_gen_in_isprogr[i]):
    // Mapping - ${acc_wr_stream_in[i]}
    fsm_ctrl.${acc_wr_stream_in[i]}_trans_size     = static_reg_${acc_wr_stream_in[i]}_trans_size;
    fsm_ctrl.${acc_wr_stream_in[i]}_line_stride    = static_reg_${acc_wr_stream_in[i]}_line_stride;
    fsm_ctrl.${acc_wr_stream_in[i]}_line_length    = static_reg_${acc_wr_stream_in[i]}_line_length;
    fsm_ctrl.${acc_wr_stream_in[i]}_feat_stride    = static_reg_${acc_wr_stream_in[i]}_feat_stride;
    fsm_ctrl.${acc_wr_stream_in[i]}_feat_length    = static_reg_${acc_wr_stream_in[i]}_feat_length;
    fsm_ctrl.${acc_wr_stream_in[i]}_feat_roll      = static_reg_${acc_wr_stream_in[i]}_feat_roll;
    fsm_ctrl.${acc_wr_stream_in[i]}_step           = static_reg_${acc_wr_stream_in[i]}_step;
    fsm_ctrl.${acc_wr_stream_in[i]}_loop_outer     = static_reg_${acc_wr_stream_in[i]}_loop_outer;
    fsm_ctrl.${acc_wr_stream_in[i]}_realign_type   = static_reg_${acc_wr_stream_in[i]}_realign_type;
        % if (acc_wr_is_parallel_in[i]):
    fsm_ctrl.${acc_wr_stream_in[i]}_port_offset    = static_reg_${acc_wr_stream_in[i]}_port_offset;
        % endif
      % endif
    % endfor

    % for j in range (acc_wr_n_source):
      % if (acc_wr_addr_gen_out_isprogr[j]):
    // Mapping - ${acc_wr_stream_out[j]}
    fsm_ctrl.${acc_wr_stream_out[j]}_trans_size     = static_reg_${acc_wr_stream_out[j]}_trans_size;
    fsm_ctrl.${acc_wr_stream_out[j]}_line_stride    = static_reg_${acc_wr_stream_out[j]}_line_stride;
    fsm_ctrl.${acc_wr_stream_out[j]}_line_length    = static_reg_${acc_wr_stream_out[j]}_line_length;
    fsm_ctrl.${acc_wr_stream_out[j]}_feat_stride    = static_reg_${acc_wr_stream_out[j]}_feat_stride;
    fsm_ctrl.${acc_wr_stream_out[j]}_feat_length    = static_reg_${acc_wr_stream_out[j]}_feat_length;
    fsm_ctrl.${acc_wr_stream_out[j]}_feat_roll      = static_reg_${acc_wr_stream_out[j]}_feat_roll;
    fsm_ctrl.${acc_wr_stream_out[j]}_step           = static_reg_${acc_wr_stream_out[j]}_step;
    fsm_ctrl.${acc_wr_stream_out[j]}_loop_outer     = static_reg_${acc_wr_stream_out[j]}_loop_outer;
    fsm_ctrl.${acc_wr_stream_out[j]}_realign_type   = static_reg_${acc_wr_stream_out[j]}_realign_type;
        % if (acc_wr_is_parallel_out[j]):
    fsm_ctrl.${acc_wr_stream_out[j]}_port_offset    = static_reg_${acc_wr_stream_out[j]}_port_offset;
        % endif
      % endif
    % endfor

    /* Standard register file mappings to FSM */
    % if acc_wr_is_hls_stream is True:
    // Packet size - hls::stream
      % for i in range (acc_wr_n_sink):
    fsm_ctrl.packet_size_${acc_wr_stream_in[i]}            = static_reg_packet_size_${acc_wr_stream_in[i]};
      % endfor
    % endif

    % for j in range (acc_wr_n_source):
    fsm_ctrl.cnt_limit_${acc_wr_stream_out[j]}             = static_reg_cnt_limit_${acc_wr_stream_out[j]};
    % endfor

    /* Custom register file mappings to FSM */
    % if acc_wr_custom_reg_num>0:
      % for i in range (acc_wr_custom_reg_num):
    fsm_ctrl.${acc_wr_custom_reg_name[i]}    = static_reg_${acc_wr_custom_reg_name[i]}; \
      % endfor
    % endif

  end

endmodule
