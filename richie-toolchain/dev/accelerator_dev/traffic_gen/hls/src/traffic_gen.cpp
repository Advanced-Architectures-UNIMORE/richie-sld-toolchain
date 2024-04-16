/* =====================================================================
 * Project:      Traffic Generator
 * Title:        traffic_gen.cpp
 * Description:  Implementation of a generic accelerated kernel for DSE purposes.
 *
 * $Date:        12.11.2021
 * ===================================================================== */
/*
 * Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia..
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */


#include "traffic_gen.h"

void traffic_gen(
    // Data ports
    hls::stream<data_t> &stream_in, 
    hls::stream<data_t> &stream_out,
    // Custom registers
    int n_reqs,
    int duty_cycle
    // int t_total, 
    // int t_on,
    // int t_off
) {
    #pragma HLS INTERFACE axis port=&stream_in 
    #pragma HLS INTERFACE axis port=&stream_out

    #pragma HLS INTERFACE ap_none port=n_reqs 
    #pragma HLS INTERFACE ap_none port=duty_cycle 
    // #pragma HLS INTERFACE ap_none port=t_total 
    // #pragma HLS INTERFACE ap_none port=t_on 
    // #pragma HLS INTERFACE ap_none port=t_off 

    #pragma HLS DATAFLOW
    #pragma HLS INLINE

    // pwm class
    static pwm<int, data_t> _pwm;

    // generate RW requests
    _pwm.generate_reqs(stream_in, 
                       stream_out, 
                       n_reqs, 
                       duty_cycle);
                    //    t_total, 
                    //    t_on,
                    //    t_off  );
};