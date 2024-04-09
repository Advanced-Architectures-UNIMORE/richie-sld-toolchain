// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Network module 
// Date: 2022/01/18 18:18:04
//
// ----------------------------------------------------------------------------

module multi_dataflow_roberts_mdc (
	// Input(s)
	input [7 : 0] in_pel_data,
	input in_pel_wr,
	output in_pel_full,
	
	// Output(s)
	input [5 : 0] in_size_data,
	input in_size_wr,
	output in_size_full,
	
	// Output(s)
	output [7 : 0] out_pel_data,
	output out_pel_wr,
	input out_pel_full,
	
	// Dynamic Parameter(s)
	
	// Monitoring
	
	// Configuration ID
	
	
	// System Signal(s)		
	input clock,
	input reset
);	

// internal signals
// ----------------------------------------------------------------------------
		


// Actors Wire(s)
	
// actor roberts_x_0
wire [7 : 0] fifo_small_roberts_x_0_pel00_data;
wire fifo_small_roberts_x_0_pel00_wr;
wire fifo_small_roberts_x_0_pel00_full;
wire [7 : 0] roberts_x_0_pel00_data;
wire roberts_x_0_pel00_rd;
wire roberts_x_0_pel00_empty;
wire [7 : 0] fifo_small_roberts_x_0_pel01_data;
wire fifo_small_roberts_x_0_pel01_wr;
wire fifo_small_roberts_x_0_pel01_full;
wire [7 : 0] roberts_x_0_pel01_data;
wire roberts_x_0_pel01_rd;
wire roberts_x_0_pel01_empty;
wire [7 : 0] fifo_small_roberts_x_0_pel10_data;
wire fifo_small_roberts_x_0_pel10_wr;
wire fifo_small_roberts_x_0_pel10_full;
wire [7 : 0] roberts_x_0_pel10_data;
wire roberts_x_0_pel10_rd;
wire roberts_x_0_pel10_empty;
wire [7 : 0] fifo_small_roberts_x_0_pel11_data;
wire fifo_small_roberts_x_0_pel11_wr;
wire fifo_small_roberts_x_0_pel11_full;
wire [7 : 0] roberts_x_0_pel11_data;
wire roberts_x_0_pel11_rd;
wire roberts_x_0_pel11_empty;
wire [13 : 0] roberts_x_0_out_pel_data;
wire roberts_x_0_out_pel_wr;
wire roberts_x_0_out_pel_full;
	
// actor roberts_y_0
wire [7 : 0] fifo_small_roberts_y_0_pel00_data;
wire fifo_small_roberts_y_0_pel00_wr;
wire fifo_small_roberts_y_0_pel00_full;
wire [7 : 0] roberts_y_0_pel00_data;
wire roberts_y_0_pel00_rd;
wire roberts_y_0_pel00_empty;
wire [7 : 0] fifo_small_roberts_y_0_pel01_data;
wire fifo_small_roberts_y_0_pel01_wr;
wire fifo_small_roberts_y_0_pel01_full;
wire [7 : 0] roberts_y_0_pel01_data;
wire roberts_y_0_pel01_rd;
wire roberts_y_0_pel01_empty;
wire [7 : 0] fifo_small_roberts_y_0_pel10_data;
wire fifo_small_roberts_y_0_pel10_wr;
wire fifo_small_roberts_y_0_pel10_full;
wire [7 : 0] roberts_y_0_pel10_data;
wire roberts_y_0_pel10_rd;
wire roberts_y_0_pel10_empty;
wire [7 : 0] fifo_small_roberts_y_0_pel11_data;
wire fifo_small_roberts_y_0_pel11_wr;
wire fifo_small_roberts_y_0_pel11_full;
wire [7 : 0] roberts_y_0_pel11_data;
wire roberts_y_0_pel11_rd;
wire roberts_y_0_pel11_empty;
wire [13 : 0] roberts_y_0_out_pel_data;
wire roberts_y_0_out_pel_wr;
wire roberts_y_0_out_pel_full;
	
// actor delay_0
wire [7 : 0] fifo_small_delay_0_in_pel_data;
wire fifo_small_delay_0_in_pel_wr;
wire fifo_small_delay_0_in_pel_full;
wire [7 : 0] delay_0_in_pel_data;
wire delay_0_in_pel_rd;
wire delay_0_in_pel_empty;
wire [7 : 0] delay_0_out_pel_data;
wire delay_0_out_pel_wr;
wire delay_0_out_pel_full;
	
// actor line_buffer_0
wire [5 : 0] fifo_small_line_buffer_0_real_size_data;
wire fifo_small_line_buffer_0_real_size_wr;
wire fifo_small_line_buffer_0_real_size_full;
wire [5 : 0] line_buffer_0_real_size_data;
wire line_buffer_0_real_size_rd;
wire line_buffer_0_real_size_empty;
wire [5 : 0] fifo_small_line_buffer_0_ext_size_data;
wire fifo_small_line_buffer_0_ext_size_wr;
wire fifo_small_line_buffer_0_ext_size_full;
wire [5 : 0] line_buffer_0_ext_size_data;
wire line_buffer_0_ext_size_rd;
wire line_buffer_0_ext_size_empty;
wire [7 : 0] fifo_small_line_buffer_0_in_pel_data;
wire fifo_small_line_buffer_0_in_pel_wr;
wire fifo_small_line_buffer_0_in_pel_full;
wire [7 : 0] line_buffer_0_in_pel_data;
wire line_buffer_0_in_pel_rd;
wire line_buffer_0_in_pel_empty;
wire [7 : 0] line_buffer_0_out_pel_data;
wire line_buffer_0_out_pel_wr;
wire line_buffer_0_out_pel_full;
	
// actor delay_1
wire [7 : 0] fifo_small_delay_1_in_pel_data;
wire fifo_small_delay_1_in_pel_wr;
wire fifo_small_delay_1_in_pel_full;
wire [7 : 0] delay_1_in_pel_data;
wire delay_1_in_pel_rd;
wire delay_1_in_pel_empty;
wire [7 : 0] delay_1_out_pel_data;
wire delay_1_out_pel_wr;
wire delay_1_out_pel_full;
	
// actor abs_sum_0
wire [13 : 0] fifo_small_abs_sum_0_in_gx_data;
wire fifo_small_abs_sum_0_in_gx_wr;
wire fifo_small_abs_sum_0_in_gx_full;
wire [13 : 0] abs_sum_0_in_gx_data;
wire abs_sum_0_in_gx_rd;
wire abs_sum_0_in_gx_empty;
wire [13 : 0] fifo_small_abs_sum_0_in_gy_data;
wire fifo_small_abs_sum_0_in_gy_wr;
wire fifo_small_abs_sum_0_in_gy_full;
wire [13 : 0] abs_sum_0_in_gy_data;
wire abs_sum_0_in_gy_rd;
wire abs_sum_0_in_gy_empty;
wire [13 : 0] abs_sum_0_out_g_data;
wire abs_sum_0_out_g_wr;
wire abs_sum_0_out_g_full;
	
// actor thr_0
wire [13 : 0] fifo_small_thr_0_in_g_data;
wire fifo_small_thr_0_in_g_wr;
wire fifo_small_thr_0_in_g_full;
wire [13 : 0] thr_0_in_g_data;
wire thr_0_in_g_rd;
wire thr_0_in_g_empty;
wire [7 : 0] thr_0_out_pel_data;
wire thr_0_out_pel_wr;
wire thr_0_out_pel_full;
	
// actor remove_2x2_0
wire [5 : 0] fifo_small_remove_2x2_0_in_size_data;
wire fifo_small_remove_2x2_0_in_size_wr;
wire fifo_small_remove_2x2_0_in_size_full;
wire [5 : 0] remove_2x2_0_in_size_data;
wire remove_2x2_0_in_size_rd;
wire remove_2x2_0_in_size_empty;
wire [7 : 0] fifo_small_remove_2x2_0_in_pel_data;
wire fifo_small_remove_2x2_0_in_pel_wr;
wire fifo_small_remove_2x2_0_in_pel_full;
wire [7 : 0] remove_2x2_0_in_pel_data;
wire remove_2x2_0_in_pel_rd;
wire remove_2x2_0_in_pel_empty;
wire [7 : 0] remove_2x2_0_out_pel_data;
wire remove_2x2_0_out_pel_wr;
wire remove_2x2_0_out_pel_full;
// ----------------------------------------------------------------------------

// body
// ----------------------------------------------------------------------------



// fifo_small_roberts_x_0_pel00
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_x_0_pel00(
	.datain(fifo_small_roberts_x_0_pel00_data),
	.dataout(roberts_x_0_pel00_data),
	.enr(roberts_x_0_pel00_rd),
	.enw(fifo_small_roberts_x_0_pel00_wr),
	.empty(roberts_x_0_pel00_empty),
	.full(fifo_small_roberts_x_0_pel00_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_roberts_x_0_pel01
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_x_0_pel01(
	.datain(fifo_small_roberts_x_0_pel01_data),
	.dataout(roberts_x_0_pel01_data),
	.enr(roberts_x_0_pel01_rd),
	.enw(fifo_small_roberts_x_0_pel01_wr),
	.empty(roberts_x_0_pel01_empty),
	.full(fifo_small_roberts_x_0_pel01_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_roberts_x_0_pel10
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_x_0_pel10(
	.datain(fifo_small_roberts_x_0_pel10_data),
	.dataout(roberts_x_0_pel10_data),
	.enr(roberts_x_0_pel10_rd),
	.enw(fifo_small_roberts_x_0_pel10_wr),
	.empty(roberts_x_0_pel10_empty),
	.full(fifo_small_roberts_x_0_pel10_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_roberts_x_0_pel11
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_x_0_pel11(
	.datain(fifo_small_roberts_x_0_pel11_data),
	.dataout(roberts_x_0_pel11_data),
	.enr(roberts_x_0_pel11_rd),
	.enw(fifo_small_roberts_x_0_pel11_wr),
	.empty(roberts_x_0_pel11_empty),
	.full(fifo_small_roberts_x_0_pel11_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor roberts_x_0
roberts_x actor_roberts_x_0 (
	// Input Signal(s)
	.pel00(roberts_x_0_pel00_data),
	.pel00_rd(roberts_x_0_pel00_rd),
	.pel00_empty(roberts_x_0_pel00_empty),
	.pel01(roberts_x_0_pel01_data),
	.pel01_rd(roberts_x_0_pel01_rd),
	.pel01_empty(roberts_x_0_pel01_empty),
	.pel10(roberts_x_0_pel10_data),
	.pel10_rd(roberts_x_0_pel10_rd),
	.pel10_empty(roberts_x_0_pel10_empty),
	.pel11(roberts_x_0_pel11_data),
	.pel11_rd(roberts_x_0_pel11_rd),
	.pel11_empty(roberts_x_0_pel11_empty)
	,
	
	// Output Signal(s)
	.out_pel(roberts_x_0_out_pel_data),
	.out_pel_wr(roberts_x_0_out_pel_wr),
	.out_pel_full(roberts_x_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_roberts_y_0_pel00
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_y_0_pel00(
	.datain(fifo_small_roberts_y_0_pel00_data),
	.dataout(roberts_y_0_pel00_data),
	.enr(roberts_y_0_pel00_rd),
	.enw(fifo_small_roberts_y_0_pel00_wr),
	.empty(roberts_y_0_pel00_empty),
	.full(fifo_small_roberts_y_0_pel00_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_roberts_y_0_pel01
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_y_0_pel01(
	.datain(fifo_small_roberts_y_0_pel01_data),
	.dataout(roberts_y_0_pel01_data),
	.enr(roberts_y_0_pel01_rd),
	.enw(fifo_small_roberts_y_0_pel01_wr),
	.empty(roberts_y_0_pel01_empty),
	.full(fifo_small_roberts_y_0_pel01_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_roberts_y_0_pel10
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_y_0_pel10(
	.datain(fifo_small_roberts_y_0_pel10_data),
	.dataout(roberts_y_0_pel10_data),
	.enr(roberts_y_0_pel10_rd),
	.enw(fifo_small_roberts_y_0_pel10_wr),
	.empty(roberts_y_0_pel10_empty),
	.full(fifo_small_roberts_y_0_pel10_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_roberts_y_0_pel11
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_roberts_y_0_pel11(
	.datain(fifo_small_roberts_y_0_pel11_data),
	.dataout(roberts_y_0_pel11_data),
	.enr(roberts_y_0_pel11_rd),
	.enw(fifo_small_roberts_y_0_pel11_wr),
	.empty(roberts_y_0_pel11_empty),
	.full(fifo_small_roberts_y_0_pel11_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor roberts_y_0
roberts_y actor_roberts_y_0 (
	// Input Signal(s)
	.pel00(roberts_y_0_pel00_data),
	.pel00_rd(roberts_y_0_pel00_rd),
	.pel00_empty(roberts_y_0_pel00_empty),
	.pel01(roberts_y_0_pel01_data),
	.pel01_rd(roberts_y_0_pel01_rd),
	.pel01_empty(roberts_y_0_pel01_empty),
	.pel10(roberts_y_0_pel10_data),
	.pel10_rd(roberts_y_0_pel10_rd),
	.pel10_empty(roberts_y_0_pel10_empty),
	.pel11(roberts_y_0_pel11_data),
	.pel11_rd(roberts_y_0_pel11_rd),
	.pel11_empty(roberts_y_0_pel11_empty)
	,
	
	// Output Signal(s)
	.out_pel(roberts_y_0_out_pel_data),
	.out_pel_wr(roberts_y_0_out_pel_wr),
	.out_pel_full(roberts_y_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_delay_0_in_pel
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_delay_0_in_pel(
	.datain(fifo_small_delay_0_in_pel_data),
	.dataout(delay_0_in_pel_data),
	.enr(delay_0_in_pel_rd),
	.enw(fifo_small_delay_0_in_pel_wr),
	.empty(delay_0_in_pel_empty),
	.full(fifo_small_delay_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_0
delay actor_delay_0 (
	// Input Signal(s)
	.in_pel(delay_0_in_pel_data),
	.in_pel_rd(delay_0_in_pel_rd),
	.in_pel_empty(delay_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_0_out_pel_data),
	.out_pel_wr(delay_0_out_pel_wr),
	.out_pel_full(delay_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_line_buffer_0_real_size
fifo_small #(
	.depth(64),
	.size(6)
) fifo_small_line_buffer_0_real_size(
	.datain(fifo_small_line_buffer_0_real_size_data),
	.dataout(line_buffer_0_real_size_data),
	.enr(line_buffer_0_real_size_rd),
	.enw(fifo_small_line_buffer_0_real_size_wr),
	.empty(line_buffer_0_real_size_empty),
	.full(fifo_small_line_buffer_0_real_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_line_buffer_0_ext_size
fifo_small #(
	.depth(64),
	.size(6)
) fifo_small_line_buffer_0_ext_size(
	.datain(fifo_small_line_buffer_0_ext_size_data),
	.dataout(line_buffer_0_ext_size_data),
	.enr(line_buffer_0_ext_size_rd),
	.enw(fifo_small_line_buffer_0_ext_size_wr),
	.empty(line_buffer_0_ext_size_empty),
	.full(fifo_small_line_buffer_0_ext_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_line_buffer_0_in_pel
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_line_buffer_0_in_pel(
	.datain(fifo_small_line_buffer_0_in_pel_data),
	.dataout(line_buffer_0_in_pel_data),
	.enr(line_buffer_0_in_pel_rd),
	.enw(fifo_small_line_buffer_0_in_pel_wr),
	.empty(line_buffer_0_in_pel_empty),
	.full(fifo_small_line_buffer_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor line_buffer_0
line_buffer actor_line_buffer_0 (
	// Input Signal(s)
	.real_size(line_buffer_0_real_size_data),
	.real_size_rd(line_buffer_0_real_size_rd),
	.real_size_empty(line_buffer_0_real_size_empty),
	.ext_size(line_buffer_0_ext_size_data),
	.ext_size_rd(line_buffer_0_ext_size_rd),
	.ext_size_empty(line_buffer_0_ext_size_empty),
	.in_pel(line_buffer_0_in_pel_data),
	.in_pel_rd(line_buffer_0_in_pel_rd),
	.in_pel_empty(line_buffer_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(line_buffer_0_out_pel_data),
	.out_pel_wr(line_buffer_0_out_pel_wr),
	.out_pel_full(line_buffer_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_delay_1_in_pel
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_delay_1_in_pel(
	.datain(fifo_small_delay_1_in_pel_data),
	.dataout(delay_1_in_pel_data),
	.enr(delay_1_in_pel_rd),
	.enw(fifo_small_delay_1_in_pel_wr),
	.empty(delay_1_in_pel_empty),
	.full(fifo_small_delay_1_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor delay_1
delay actor_delay_1 (
	// Input Signal(s)
	.in_pel(delay_1_in_pel_data),
	.in_pel_rd(delay_1_in_pel_rd),
	.in_pel_empty(delay_1_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(delay_1_out_pel_data),
	.out_pel_wr(delay_1_out_pel_wr),
	.out_pel_full(delay_1_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_abs_sum_0_in_gx
fifo_small #(
	.depth(64),
	.size(14)
) fifo_small_abs_sum_0_in_gx(
	.datain(fifo_small_abs_sum_0_in_gx_data),
	.dataout(abs_sum_0_in_gx_data),
	.enr(abs_sum_0_in_gx_rd),
	.enw(fifo_small_abs_sum_0_in_gx_wr),
	.empty(abs_sum_0_in_gx_empty),
	.full(fifo_small_abs_sum_0_in_gx_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_abs_sum_0_in_gy
fifo_small #(
	.depth(64),
	.size(14)
) fifo_small_abs_sum_0_in_gy(
	.datain(fifo_small_abs_sum_0_in_gy_data),
	.dataout(abs_sum_0_in_gy_data),
	.enr(abs_sum_0_in_gy_rd),
	.enw(fifo_small_abs_sum_0_in_gy_wr),
	.empty(abs_sum_0_in_gy_empty),
	.full(fifo_small_abs_sum_0_in_gy_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor abs_sum_0
abs_sum actor_abs_sum_0 (
	// Input Signal(s)
	.in_gx(abs_sum_0_in_gx_data),
	.in_gx_rd(abs_sum_0_in_gx_rd),
	.in_gx_empty(abs_sum_0_in_gx_empty),
	.in_gy(abs_sum_0_in_gy_data),
	.in_gy_rd(abs_sum_0_in_gy_rd),
	.in_gy_empty(abs_sum_0_in_gy_empty)
	,
	
	// Output Signal(s)
	.out_g(abs_sum_0_out_g_data),
	.out_g_wr(abs_sum_0_out_g_wr),
	.out_g_full(abs_sum_0_out_g_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_thr_0_in_g
fifo_small #(
	.depth(64),
	.size(14)
) fifo_small_thr_0_in_g(
	.datain(fifo_small_thr_0_in_g_data),
	.dataout(thr_0_in_g_data),
	.enr(thr_0_in_g_rd),
	.enw(fifo_small_thr_0_in_g_wr),
	.empty(thr_0_in_g_empty),
	.full(fifo_small_thr_0_in_g_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor thr_0
thr actor_thr_0 (
	// Input Signal(s)
	.in_g(thr_0_in_g_data),
	.in_g_rd(thr_0_in_g_rd),
	.in_g_empty(thr_0_in_g_empty)
	,
	
	// Output Signal(s)
	.out_pel(thr_0_out_pel_data),
	.out_pel_wr(thr_0_out_pel_wr),
	.out_pel_full(thr_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_small_remove_2x2_0_in_size
fifo_small #(
	.depth(64),
	.size(6)
) fifo_small_remove_2x2_0_in_size(
	.datain(fifo_small_remove_2x2_0_in_size_data),
	.dataout(remove_2x2_0_in_size_data),
	.enr(remove_2x2_0_in_size_rd),
	.enw(fifo_small_remove_2x2_0_in_size_wr),
	.empty(remove_2x2_0_in_size_empty),
	.full(fifo_small_remove_2x2_0_in_size_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_small_remove_2x2_0_in_pel
fifo_small #(
	.depth(64),
	.size(8)
) fifo_small_remove_2x2_0_in_pel(
	.datain(fifo_small_remove_2x2_0_in_pel_data),
	.dataout(remove_2x2_0_in_pel_data),
	.enr(remove_2x2_0_in_pel_rd),
	.enw(fifo_small_remove_2x2_0_in_pel_wr),
	.empty(remove_2x2_0_in_pel_empty),
	.full(fifo_small_remove_2x2_0_in_pel_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor remove_2x2_0
remove_2x2 actor_remove_2x2_0 (
	// Input Signal(s)
	.in_size(remove_2x2_0_in_size_data),
	.in_size_rd(remove_2x2_0_in_size_rd),
	.in_size_empty(remove_2x2_0_in_size_empty),
	.in_pel(remove_2x2_0_in_pel_data),
	.in_pel_rd(remove_2x2_0_in_pel_rd),
	.in_pel_empty(remove_2x2_0_in_pel_empty)
	,
	
	// Output Signal(s)
	.out_pel(remove_2x2_0_out_pel_data),
	.out_pel_wr(remove_2x2_0_out_pel_wr),
	.out_pel_full(remove_2x2_0_out_pel_full)
		,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// Module(s) Assignments
assign fifo_small_roberts_x_0_pel11_data = in_pel_data;
assign fifo_small_roberts_x_0_pel11_wr = in_pel_wr;
assign in_pel_full =		
fifo_small_roberts_x_0_pel11_full || 
fifo_small_delay_0_in_pel_full || 
fifo_small_line_buffer_0_in_pel_full || 
fifo_small_roberts_y_0_pel11_full 
;

assign fifo_small_roberts_x_0_pel10_data = delay_0_out_pel_data;
assign fifo_small_roberts_x_0_pel10_wr = delay_0_out_pel_wr;
assign delay_0_out_pel_full =
fifo_small_roberts_x_0_pel10_full || 
fifo_small_roberts_y_0_pel10_full 
;

assign fifo_small_roberts_x_0_pel01_data = line_buffer_0_out_pel_data;
assign fifo_small_roberts_x_0_pel01_wr = line_buffer_0_out_pel_wr;
assign line_buffer_0_out_pel_full =
fifo_small_roberts_x_0_pel01_full || 
fifo_small_roberts_y_0_pel01_full || 
fifo_small_delay_1_in_pel_full 
;

assign fifo_small_roberts_x_0_pel00_data = delay_1_out_pel_data;
assign fifo_small_roberts_x_0_pel00_wr = delay_1_out_pel_wr;
assign delay_1_out_pel_full =
fifo_small_roberts_x_0_pel00_full || 
fifo_small_roberts_y_0_pel00_full 
;

assign fifo_small_delay_0_in_pel_data = in_pel_data;
assign fifo_small_delay_0_in_pel_wr = in_pel_wr;

assign fifo_small_line_buffer_0_ext_size_data = in_size_data;
assign fifo_small_line_buffer_0_ext_size_wr = in_size_wr;
assign in_size_full =		
fifo_small_line_buffer_0_ext_size_full || 
fifo_small_line_buffer_0_real_size_full || 
fifo_small_remove_2x2_0_in_size_full 
;

assign fifo_small_line_buffer_0_real_size_data = in_size_data;
assign fifo_small_line_buffer_0_real_size_wr = in_size_wr;

assign fifo_small_line_buffer_0_in_pel_data = in_pel_data;
assign fifo_small_line_buffer_0_in_pel_wr = in_pel_wr;

assign fifo_small_roberts_y_0_pel01_data = line_buffer_0_out_pel_data;
assign fifo_small_roberts_y_0_pel01_wr = line_buffer_0_out_pel_wr;

assign fifo_small_roberts_y_0_pel00_data = delay_1_out_pel_data;
assign fifo_small_roberts_y_0_pel00_wr = delay_1_out_pel_wr;

assign fifo_small_roberts_y_0_pel10_data = delay_0_out_pel_data;
assign fifo_small_roberts_y_0_pel10_wr = delay_0_out_pel_wr;

assign fifo_small_roberts_y_0_pel11_data = in_pel_data;
assign fifo_small_roberts_y_0_pel11_wr = in_pel_wr;

assign fifo_small_remove_2x2_0_in_pel_data = thr_0_out_pel_data;
assign fifo_small_remove_2x2_0_in_pel_wr = thr_0_out_pel_wr;
assign thr_0_out_pel_full = fifo_small_remove_2x2_0_in_pel_full;

assign fifo_small_remove_2x2_0_in_size_data = in_size_data;
assign fifo_small_remove_2x2_0_in_size_wr = in_size_wr;

assign fifo_small_abs_sum_0_in_gx_data = roberts_x_0_out_pel_data;
assign fifo_small_abs_sum_0_in_gx_wr = roberts_x_0_out_pel_wr;
assign roberts_x_0_out_pel_full = fifo_small_abs_sum_0_in_gx_full;

assign fifo_small_abs_sum_0_in_gy_data = roberts_y_0_out_pel_data;
assign fifo_small_abs_sum_0_in_gy_wr = roberts_y_0_out_pel_wr;
assign roberts_y_0_out_pel_full = fifo_small_abs_sum_0_in_gy_full;

assign fifo_small_delay_1_in_pel_data = line_buffer_0_out_pel_data;
assign fifo_small_delay_1_in_pel_wr = line_buffer_0_out_pel_wr;

assign out_pel_data = remove_2x2_0_out_pel_data;
assign out_pel_wr = remove_2x2_0_out_pel_wr;
assign remove_2x2_0_out_pel_full = out_pel_full;

assign fifo_small_thr_0_in_g_data = abs_sum_0_out_g_data;
assign fifo_small_thr_0_in_g_wr = abs_sum_0_out_g_wr;
assign abs_sum_0_out_g_full = fifo_small_thr_0_in_g_full;

endmodule
