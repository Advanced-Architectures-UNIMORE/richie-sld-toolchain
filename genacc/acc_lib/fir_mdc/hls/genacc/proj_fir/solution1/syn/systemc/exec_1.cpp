// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

#include "exec_1.h"
#include "AESL_pkg.h"

using namespace std;

namespace ap_rtl {

const sc_logic exec_1::ap_const_logic_1 = sc_dt::Log_1;
const sc_logic exec_1::ap_const_logic_0 = sc_dt::Log_0;
const sc_lv<2> exec_1::ap_ST_fsm_state1 = "1";
const sc_lv<2> exec_1::ap_ST_fsm_state2 = "10";
const sc_lv<32> exec_1::ap_const_lv32_0 = "00000000000000000000000000000000";
const sc_lv<32> exec_1::ap_const_lv32_1 = "1";
const bool exec_1::ap_const_boolean_1 = true;

exec_1::exec_1(sc_module_name name) : sc_module(name), mVcdFile(0) {
    fir_mul_32s_32s_3bkb_U1 = new fir_mul_32s_32s_3bkb<1,2,32,32,32>("fir_mul_32s_32s_3bkb_U1");
    fir_mul_32s_32s_3bkb_U1->clk(ap_clk);
    fir_mul_32s_32s_3bkb_U1->reset(ap_rst);
    fir_mul_32s_32s_3bkb_U1->din0(s_x1_V_0);
    fir_mul_32s_32s_3bkb_U1->din1(h_0_V_read);
    fir_mul_32s_32s_3bkb_U1->ce(grp_fu_44_ce);
    fir_mul_32s_32s_3bkb_U1->dout(grp_fu_44_p2);

    SC_METHOD(thread_ap_clk_no_reset_);
    dont_initialize();
    sensitive << ( ap_clk.pos() );

    SC_METHOD(thread_ap_CS_fsm_state1);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_CS_fsm_state2);
    sensitive << ( ap_CS_fsm );

    SC_METHOD(thread_ap_done);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm_state1 );
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );

    SC_METHOD(thread_ap_idle);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm_state1 );

    SC_METHOD(thread_ap_ready);
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );

    SC_METHOD(thread_ap_return_0);
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );
    sensitive << ( s_x1_V_0_load_reg_102 );

    SC_METHOD(thread_ap_return_1);
    sensitive << ( x_in_V_TVALID );
    sensitive << ( s_y1_V_0 );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );

    SC_METHOD(thread_grp_fu_44_ce);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm_state1 );
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );

    SC_METHOD(thread_x_in_V_TDATA_blk_n);
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );

    SC_METHOD(thread_x_in_V_TREADY);
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );

    SC_METHOD(thread_ap_NS_fsm);
    sensitive << ( ap_start );
    sensitive << ( ap_CS_fsm );
    sensitive << ( ap_CS_fsm_state1 );
    sensitive << ( x_in_V_TVALID );
    sensitive << ( ap_CS_fsm_state2 );
    sensitive << ( ap_ce );

    ap_CS_fsm = "01";
    s_x1_V_0 = "00000000000000000000000000000000";
    s_x_V_0 = "00000000000000000000000000000000";
    s_y1_V_0 = "00000000000000000000000000000000";
    s_y0_V_0 = "00000000000000000000000000000000";
    static int apTFileNum = 0;
    stringstream apTFilenSS;
    apTFilenSS << "exec_1_sc_trace_" << apTFileNum ++;
    string apTFn = apTFilenSS.str();
    mVcdFile = sc_create_vcd_trace_file(apTFn.c_str());
    mVcdFile->set_time_unit(1, SC_PS);
    if (1) {
#ifdef __HLS_TRACE_LEVEL_PORT_HIER__
    sc_trace(mVcdFile, ap_clk, "(port)ap_clk");
    sc_trace(mVcdFile, ap_rst, "(port)ap_rst");
    sc_trace(mVcdFile, ap_start, "(port)ap_start");
    sc_trace(mVcdFile, ap_done, "(port)ap_done");
    sc_trace(mVcdFile, ap_idle, "(port)ap_idle");
    sc_trace(mVcdFile, ap_ready, "(port)ap_ready");
    sc_trace(mVcdFile, x_in_V_TDATA, "(port)x_in_V_TDATA");
    sc_trace(mVcdFile, x_in_V_TVALID, "(port)x_in_V_TVALID");
    sc_trace(mVcdFile, x_in_V_TREADY, "(port)x_in_V_TREADY");
    sc_trace(mVcdFile, h_0_V_read, "(port)h_0_V_read");
    sc_trace(mVcdFile, ap_return_0, "(port)ap_return_0");
    sc_trace(mVcdFile, ap_return_1, "(port)ap_return_1");
    sc_trace(mVcdFile, x_in_V_TDATA_blk_n, "(port)x_in_V_TDATA_blk_n");
    sc_trace(mVcdFile, ap_ce, "(port)ap_ce");
#endif
#ifdef __HLS_TRACE_LEVEL_INT__
    sc_trace(mVcdFile, ap_CS_fsm, "ap_CS_fsm");
    sc_trace(mVcdFile, ap_CS_fsm_state1, "ap_CS_fsm_state1");
    sc_trace(mVcdFile, s_x1_V_0, "s_x1_V_0");
    sc_trace(mVcdFile, s_x_V_0, "s_x_V_0");
    sc_trace(mVcdFile, s_y1_V_0, "s_y1_V_0");
    sc_trace(mVcdFile, s_y0_V_0, "s_y0_V_0");
    sc_trace(mVcdFile, ap_CS_fsm_state2, "ap_CS_fsm_state2");
    sc_trace(mVcdFile, s_x1_V_0_load_reg_102, "s_x1_V_0_load_reg_102");
    sc_trace(mVcdFile, grp_fu_44_p2, "grp_fu_44_p2");
    sc_trace(mVcdFile, grp_fu_44_ce, "grp_fu_44_ce");
    sc_trace(mVcdFile, ap_NS_fsm, "ap_NS_fsm");
#endif

    }
}

exec_1::~exec_1() {
    if (mVcdFile) 
        sc_close_vcd_trace_file(mVcdFile);

    delete fir_mul_32s_32s_3bkb_U1;
}

void exec_1::thread_ap_clk_no_reset_() {
    if ( ap_rst.read() == ap_const_logic_1) {
        ap_CS_fsm = ap_ST_fsm_state1;
    } else {
        ap_CS_fsm = ap_NS_fsm.read();
    }
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1) && esl_seteq<1,1,1>(x_in_V_TVALID.read(), ap_const_logic_1))) {
        s_x1_V_0 = s_x_V_0.read();
        s_x_V_0 = x_in_V_TDATA.read();
        s_y0_V_0 = grp_fu_44_p2.read();
        s_y1_V_0 = s_y0_V_0.read();
    }
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()) && esl_seteq<1,1,1>(ap_start.read(), ap_const_logic_1) && esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1))) {
        s_x1_V_0_load_reg_102 = s_x1_V_0.read();
    }
}

void exec_1::thread_ap_CS_fsm_state1() {
    ap_CS_fsm_state1 = ap_CS_fsm.read()[0];
}

void exec_1::thread_ap_CS_fsm_state2() {
    ap_CS_fsm_state2 = ap_CS_fsm.read()[1];
}

void exec_1::thread_ap_done() {
    if (((esl_seteq<1,1,1>(ap_const_logic_0, ap_start.read()) && 
          esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read())) || 
         (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
          esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1) && 
          esl_seteq<1,1,1>(x_in_V_TVALID.read(), ap_const_logic_1)))) {
        ap_done = ap_const_logic_1;
    } else {
        ap_done = ap_const_logic_0;
    }
}

void exec_1::thread_ap_idle() {
    if ((esl_seteq<1,1,1>(ap_const_logic_0, ap_start.read()) && 
         esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()))) {
        ap_idle = ap_const_logic_1;
    } else {
        ap_idle = ap_const_logic_0;
    }
}

void exec_1::thread_ap_ready() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
         esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1) && 
         esl_seteq<1,1,1>(x_in_V_TVALID.read(), ap_const_logic_1))) {
        ap_ready = ap_const_logic_1;
    } else {
        ap_ready = ap_const_logic_0;
    }
}

void exec_1::thread_ap_return_0() {
    ap_return_0 = s_x1_V_0_load_reg_102.read();
}

void exec_1::thread_ap_return_1() {
    ap_return_1 = s_y1_V_0.read();
}

void exec_1::thread_grp_fu_44_ce() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_ce.read()) && 
         ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()) && 
           esl_seteq<1,1,1>(ap_start.read(), ap_const_logic_1)) || 
          (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
           esl_seteq<1,1,1>(x_in_V_TVALID.read(), ap_const_logic_1))))) {
        grp_fu_44_ce = ap_const_logic_1;
    } else {
        grp_fu_44_ce = ap_const_logic_0;
    }
}

void exec_1::thread_x_in_V_TDATA_blk_n() {
    if (esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read())) {
        x_in_V_TDATA_blk_n = x_in_V_TVALID.read();
    } else {
        x_in_V_TDATA_blk_n = ap_const_logic_1;
    }
}

void exec_1::thread_x_in_V_TREADY() {
    if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && 
         esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1) && 
         esl_seteq<1,1,1>(x_in_V_TVALID.read(), ap_const_logic_1))) {
        x_in_V_TREADY = ap_const_logic_1;
    } else {
        x_in_V_TREADY = ap_const_logic_0;
    }
}

void exec_1::thread_ap_NS_fsm() {
    switch (ap_CS_fsm.read().to_uint64()) {
        case 1 : 
            if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state1.read()) && esl_seteq<1,1,1>(ap_start.read(), ap_const_logic_1) && esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1))) {
                ap_NS_fsm = ap_ST_fsm_state2;
            } else {
                ap_NS_fsm = ap_ST_fsm_state1;
            }
            break;
        case 2 : 
            if ((esl_seteq<1,1,1>(ap_const_logic_1, ap_CS_fsm_state2.read()) && esl_seteq<1,1,1>(ap_ce.read(), ap_const_logic_1) && esl_seteq<1,1,1>(x_in_V_TVALID.read(), ap_const_logic_1))) {
                ap_NS_fsm = ap_ST_fsm_state1;
            } else {
                ap_NS_fsm = ap_ST_fsm_state2;
            }
            break;
        default : 
            ap_NS_fsm = "XX";
            break;
    }
}

}

