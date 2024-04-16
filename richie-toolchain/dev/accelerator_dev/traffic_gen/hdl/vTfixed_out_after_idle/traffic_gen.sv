/* =====================================================================
 * Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * =====================================================================
 *
 * Project:       GenOv
 *
 * Title:         Traffic Generator
 *
 * Description:   Hardware traffic generator meant to be integrated inside
 *                PULP-based cluster to emulate the behavior of an HWPE-based
 *                accelerator.
 *
 * Date:          16.2.2022
 *
 * Author:        Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

module traffic_gen #(
  parameter int unsigned WORD_WIDTH = 32
) (
  // global signals
  input  logic                                      ap_clk,
  input  logic                                      ap_rst_n,

  // input a stream
  input logic                                       r_reqs_TVALID,
  output logic                                      r_reqs_TREADY,
  input logic [WORD_WIDTH-1:0]                      r_reqs_TDATA,
  // hwpe_stream_intf_stream.sink                      r_reqs,

  // output d stream
  output logic                                      w_reqs_TVALID,
  input logic                                       w_reqs_TREADY,
  output logic [WORD_WIDTH-1:0]                     w_reqs_TDATA,
  // hwpe_stream_intf_stream.source                    w_reqs,

  // control channel (custom registers)
  input logic unsigned [WORD_WIDTH-1:0]             n_total_reqs,
  input logic unsigned [WORD_WIDTH-1:0]             t_ck_reqs,
  input logic unsigned [WORD_WIDTH-1:0]             t_ck_idle,

  // Control signals
  input logic                                       ap_start,
  output logic                                      ap_done,
  output logic                                      ap_idle,
  output logic                                      ap_ready

  // input  ctrl_engine_t                              ctrl_i, 
  // output flags_engine_t                             flags_o
);

  logic [WORD_WIDTH-1:0] out;
  logic [WORD_WIDTH-1:0] r_out;
  logic r_out_valid;
  logic r_out_ready;

  logic unsigned [WORD_WIDTH-1:0] burst_r_cnt;
  logic unsigned [WORD_WIDTH-1:0] read_r_cnt, read_cnt;
  logic unsigned [WORD_WIDTH-1:0] write_r_cnt, write_cnt;

  logic issue_last_idle, last_idle, last_r_idle;
  logic stream_idle, stream_r_idle;
  logic [WORD_WIDTH-1:0] count_idle;

  logic acc_done, r_acc_done;

  logic unsigned [WORD_WIDTH-1:0] local_n_reqs;
  logic unsigned [WORD_WIDTH-1:0] local_t_reqs;
  logic unsigned [WORD_WIDTH-1:0] local_t_idle;

  ////////////////////////////////////////////////////////////////////////////////////////////

  // TODO:
  // - The control routine of the traffic generator can be re-designed in a more elegant way using a FSM.

  ////////////////////////////////////////////////////////////////////////////////////////////

  // Check if t_ck_idle is null or not
  always_comb 
  begin
    local_n_reqs = n_total_reqs;
    local_t_reqs = t_ck_reqs;
    local_t_idle = t_ck_idle;
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // Burst counter
  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin // reset counter
      burst_r_cnt <= '0;
    end
    else if(r_acc_done) begin // reset counter
      burst_r_cnt <= '0;
    end
    // idle is not null
    else if (local_t_idle>0) begin
      if ((local_t_reqs>1)&&(burst_r_cnt==local_t_reqs-1)) begin
        burst_r_cnt <= '0;
      end
      else if ((local_t_reqs==1)&&(burst_r_cnt==local_t_reqs)) begin
        burst_r_cnt <= '0;
      end
      else if (ap_start & (r_reqs_TVALID & r_reqs_TREADY=='1)) begin
        burst_r_cnt <= burst_r_cnt + 1;
      end
    end
    // idle is null, then the burst length is equal to the number
    // of read transactions (n_total_reqs)
    else if (ap_start & (r_reqs_TVALID & r_reqs_TREADY=='1)) begin
      burst_r_cnt <= burst_r_cnt + 1;
    end
  end

  // Drive stream idle signal
  always_comb
  begin
    // idle is not null
    if ((local_t_idle>0) && (read_r_cnt<local_n_reqs)) begin
      if (ap_start && (local_t_reqs==1) && (r_reqs_TVALID & r_reqs_TREADY)) begin
        stream_idle = 1'b1;
      end
      else if (ap_start && (local_t_reqs>1) && (burst_r_cnt==local_t_reqs-1)) begin
        stream_idle = 1'b1;
      end
      else begin
        stream_idle = 1'b0;
      end
    end
    // idle is null, then you just have a last_idle after all reads are completed
    else begin
      stream_idle = 1'b0;
    end
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin // reset counter
      stream_r_idle <= '0;
    end
    else if(ap_start) begin
      if (stream_idle) begin
        stream_r_idle <= stream_idle;
      end
      else if ((local_t_idle==0) | (local_t_idle==1)) begin
        stream_r_idle <= '0;
      end
      else if ((local_t_idle>1) && (count_idle==(local_t_idle-1))) begin
        stream_r_idle <= '0;
      end
    end
    else begin
      stream_r_idle <= '0;
    end
  end

  // Drive last idle signal
  always_comb 
  begin
    if(ap_start && (read_r_cnt>0) && (read_r_cnt == local_n_reqs) && ~last_r_idle && ~acc_done) begin
      issue_last_idle = '1;
    end
    else begin
      issue_last_idle = '0;
    end
  end

  always_comb 
  begin
    if(issue_last_idle) begin
      last_idle = '1;
    end
    else begin
      last_idle = '0;
    end
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin // reset counter
      last_r_idle <= '0;
    end
    else if(ap_start) begin
      if (last_idle) begin
        last_r_idle <= last_idle;
      end
      else if ((local_t_idle==0) | (local_t_idle==1)) begin
        last_r_idle <= '0;
      end
      else if ((local_t_idle>1) && (count_idle==(local_t_idle-1))) begin
        last_r_idle <= '0;
      end
    end
    else begin
      last_r_idle <= '0;
    end
  end

  // Idle timer
  PWM_timer #(
      .WORD_WIDTH (WORD_WIDTH)
  ) i_idle_timer (   
      .clk        ( ap_clk                  ),
      .rstn       ( ap_rst_n                ),
      .restart    ( stream_idle | last_idle ),
      .count      ( count_idle              )
  );

  ////////////////////////////////////////////////////////////////////////////////////////////

  // Count read transactions
  always_comb
  begin
    read_cnt = read_r_cnt + 1;
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin // reset counter
      read_r_cnt <= '0;
    end
    else if(r_acc_done) begin // reset counter
      read_r_cnt <= '0;
    end
    else if(ap_start) begin
      if (r_reqs_TVALID & r_reqs_TREADY=='1) begin
        read_r_cnt <= read_cnt;
      end
    end
    else begin
      read_r_cnt <= '0;
    end
  end

  // Count write transactions
  always_comb
  begin
    write_cnt = write_r_cnt + 1;
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin // reset counter
      write_r_cnt <= '0; 
    end
    else if(r_acc_done) begin // reset counter
      write_r_cnt <= '0;
    end
    else if(ap_start) begin
      if ((write_r_cnt < local_n_reqs) && (w_reqs_TVALID & w_reqs_TREADY == 1'b1)) begin
        write_r_cnt <= write_cnt;
      end
    end
    else begin
      write_r_cnt <= '0;
    end
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // Generate output values
  always_comb
  begin
    out = write_r_cnt;
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin
      r_out <= '0;
    end
    else if(ap_start) begin // if job
      if (stream_idle | last_idle) begin
        r_out <= out;
      end
    end
  end

  // r_out is valid following a valid handshake
  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin
      r_out_valid <= '0;
    end
    else if(ap_start) begin // if job
      if (((local_t_idle==0) | (local_t_idle==1)) && (last_r_idle)) begin
        r_out_valid <= (((local_t_idle==0) | (local_t_idle==1)) && (last_r_idle));
      end
      else if ((local_t_idle==1) && (stream_r_idle)) begin
        r_out_valid <= ((local_t_idle==1) && (stream_r_idle));
      end
      else if ((local_t_idle>1) && (count_idle==(local_t_idle-1))) begin
        r_out_valid <= ((local_t_idle>1) && (count_idle==(local_t_idle-1)));
      end
      else begin
        r_out_valid <= '0;
      end
      // else if((read_r_cnt>0) && (read_r_cnt == local_n_reqs) && ~stream_r_idle) begin
      //   r_out_valid <= ((read_r_cnt>0) && (read_r_cnt == local_n_reqs) && ~stream_r_idle);
      // end
    end
  end

  assign r_out_ready = w_reqs_TREADY;

  ////////////////////////////////////////////////////////////////////////////////////////////

  // Drive done signal
  always_comb 
  begin
    if((read_r_cnt>0) && (read_r_cnt == local_n_reqs)) begin
      if (((local_t_idle==0) | (local_t_idle==1)) && (last_r_idle>0)) begin
        acc_done = '1;
      end
      else if (((local_t_idle>1) && (count_idle==(local_t_idle-1)))) begin
        acc_done = '1;
      end
      // acc_done = '1;
    end
    else begin
      acc_done = '0;
    end
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin
      r_acc_done <= '0;
    end
    else if (ap_start && ~last_r_idle) begin
      r_acc_done <= acc_done;
    end
    else begin
      r_acc_done <= '0;
    end
  end

  assign ap_done = r_acc_done;

  // Drive idle/ready signals

  // TO-DO; Need to re-think the generated control interface for handcrafted accelerators.
  // The signals should be standardized and a clear technical guide on how to use them
  // should be written.

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin: fsm_flags_status
    if(~ap_rst_n) begin
      ap_ready <= 1'b0;
      ap_idle  <= 1'b0;
    end
    else if(ap_start) begin
      ap_ready <= 1'b1;
      ap_idle  <= 1'b1;
    end
    else if(ap_done) begin
      ap_ready <= 1'b0;
      ap_idle  <= 1'b0;
    end
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < DRIVE INPUT READS >

  always_comb
  begin
    r_reqs_TREADY = ap_start & ~(stream_r_idle | last_r_idle); 
  end

  // < DRIVE OUTPUT WRITES >

  always_comb
  begin
    w_reqs_TDATA  = r_out;
    w_reqs_TVALID = (r_out_valid) | '0; 
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // The following assertions help in getting the rules on ready & valid right.
  // They are copied from the general stream rules in hwpe_stream_interfaces.sv
  // and adapted to the internal and interface streaming signals.
  `ifndef SYNTHESIS
  `ifndef VERILATOR

    // r_reqs (interface)
    property r_reqs_change_rule;
      @(posedge ap_clk)
      ($past(r_reqs_TVALID) & ~($past(r_reqs_TVALID) & $past(r_reqs_TREADY))) |-> (r_reqs_TDATA == $past(r_reqs_TDATA));
    endproperty;
    
    property r_reqs_valid_deassert_rule;
      @(posedge ap_clk)
      ($past(r_reqs_TVALID) & ~r_reqs_TVALID) |-> $past(r_reqs_TVALID) & $past(r_reqs_TREADY);
    endproperty;

    // r_out (internal)
    property r_out_change_rule;
      @(posedge ap_clk)
      ($past(r_out_valid) & ~($past(r_out_valid) & $past(r_out_ready))) |-> (r_out == $past(r_out));
    endproperty;

    property r_out_valid_deassert_rule;
      @(posedge ap_clk)
      ($past(r_out_valid) & ~r_out_valid) |-> $past(r_out_valid) & $past(r_out_ready);
    endproperty;

    // w_reqs (interface)
    property w_reqs_change_rule;
      @(posedge ap_clk)
      ($past(w_reqs_TVALID) & ~($past(w_reqs_TVALID) & $past(w_reqs_TREADY))) |-> (w_reqs_TDATA == $past(w_reqs_TDATA));
    endproperty;
    
    property w_reqs_valid_deassert_rule;
      @(posedge ap_clk)
      ($past(w_reqs_TVALID) & ~w_reqs_TVALID) |-> $past(w_reqs_TVALID) & $past(w_reqs_TREADY);
    endproperty;

    // rule instances

    R_REQS_VALUE_CHANGE:    assert property(r_reqs_change_rule)
      else $fatal("ASSERTION FAILURE: R_REQS_VALUE_CHANGE", 1);

    R_REQS_VALID_DEASSERT:  assert property(r_reqs_valid_deassert_rule)
      else $fatal("ASSERTION FAILURE R_REQS_VALID_DEASSERT", 1);

    R_OUT_VALUE_CHANGE:    assert property(r_out_change_rule)
      else $fatal("ASSERTION FAILURE: R_OUT_VALUE_CHANGE", 1);

    R_OUT_VALID_DEASSERT:  assert property(r_out_valid_deassert_rule)
      else $fatal("ASSERTION FAILURE R_OUT_VALID_DEASSERT", 1);

    W_REQS_VALUE_CHANGE:    assert property(w_reqs_change_rule)
      else $fatal("ASSERTION FAILURE: W_REQS_VALUE_CHANGE", 1);

    W_REQS_VALID_DEASSERT:  assert property(w_reqs_valid_deassert_rule)
      else $fatal("ASSERTION FAILURE W_REQS_VALID_DEASSERT", 1);

    // R_ACC_DONE_STILL_VALUES:  assert property(r_acc_done_rule)
    //   else $fatal("ASSERTION FAILURE R_ACC_DONE_STILL_VALUES", 1);

  `endif /* VERILATOR */
  `endif /* SYNTHESIS */

endmodule // traffic_gen
