/*
 * Copyright 2020 Xilinx, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef TR_GEN_H_
#define TR_GEN_H_

#include <assert.h>
#include <stdint.h>
#include <hls_stream.h>

#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

#define WIDTH 512
#define HEIGHT 8
#define STRIPE_HEIGHT 8

#define MAX_TRNCT WIDTH*WIDTH
#define MAX_TIME WIDTH*WIDTH
#define TEST_TRNCT 320

typedef uint32_t data_t;

/** PWM class */
template<typename T0, typename T1>
class pwm { 

    private:
        // T0 t_total, t_on, t_off; // pwm time intervals
        T0 read_on, write_on; // tokens
        T0 cnt_r_on, cnt_r_off; // read counter
        T0 cnt_w_on, cnt_w_off; // write counter
        T1 cnt_r_array, cnt_w_array; // data array counters

    /** Generate requests.
     \param   stream_in    Input stream (read).
    \param   stream_out   Output stream (write).
    \param   n_trans      Number of triggered requests.
    \param   duty_cycle   Duty cycle (%) - Values: 1-100 ~ 1-100%
    */
    public:
    void generate_reqs(hls::stream<T1> &stream_in, 
                       hls::stream<T1> &stream_out,
                       T1 n_reqs, 
                       T1 duty_cycle) {
                    //    T1 t_total, 
                    //    T1 t_on,
                    //    T1 t_off) {

        // Formulas:
        // - Ttotal = Nreqs*(100/DutyCycle)
        // - Ton = Nreqs*(DutyCycle/100)
        // - Toff = Nreqs*(1-DutyCycle/100)
        // - Tperiod = Ton + Toff

        // Ttotal - Overall time interval of operations
        T1 t_total = round(n_reqs*(100/duty_cycle));

        // Ton - activation during a period
        T1 t_on = round(n_reqs*(duty_cycle/100));

        // Toff - deactivation during a period
        T1 t_off = round(n_reqs*(1-duty_cycle/100));

        // These assertions let HLS know the upper bounds of loops
        assert(t_total < MAX_TIME);

        // Local array
        T1 local[WIDTH*HEIGHT];

        cout << "t_total: " << t_total << "\n\n";
        cout << "t_on: " << t_on << "\n\n";
        cout << "t_off: " << t_off << "\n\n";

        //
        // Reading requests
        //

        // Initialize read counters
        cnt_r_on = 0;
        cnt_r_off = 0;

        // Initialize pointer for reading array
        cnt_r_array = 0;

        // Read token
        read_on = 1;

        // Reading operation
        read_in: for(T0 ii = 0; ii < t_total; ii++){
        #pragma HLS PIPELINE
            // ON period
            if(read_on){
                local[cnt_r_array] = stream_in.read();
                cnt_r_array++;
                cnt_r_on++;
                if(cnt_r_on==t_on){
                    read_on = 0;
                    cnt_r_off = 0;
                }
            // OFF period
            } else {
                cnt_r_off++;
                if(cnt_r_off==t_off){
                    read_on = 1;
                    cnt_r_on = 0;
                }
            }
        }

        //
        // Writing requests
        //

        // Initialize write counters
        cnt_w_on = 0;
        cnt_w_off = 0;

        // Initialize pointer for writing array
        cnt_w_array = 0;

        // Write token
        write_on = 1;

        // Writing operation
        write_out: for(T0 jj = 0; jj < t_total; jj++){
        #pragma HLS PIPELINE
            // ON period
            if(write_on){
                stream_out << local[cnt_w_array];
                cnt_w_array++;
                cnt_w_on++;
                if(cnt_w_on==t_on){
                    write_on = 0;
                    cnt_w_off = 0;
                }
            // OFF period
            } else {
                cnt_w_off++;
                if(cnt_w_off==t_off){
                    write_on = 1;
                    cnt_w_on = 0;
                }
            }
        }
    } // generate_req
}; // class

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
);

#endif // TR_GEN_H_y not defined

