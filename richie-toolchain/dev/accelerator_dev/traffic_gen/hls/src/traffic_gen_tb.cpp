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

#include <iostream>
#include <fstream>
#include <cstdlib>

#include "traffic_gen.h"

using namespace std;

int main(void)
{
    data_t * const ref = new data_t[TEST_TRNCT];

    hls::stream<data_t> stream_in("stream_in");
    hls::stream<data_t> stream_out("stream_out");

    int err_cnt = 0;
    int ret_val = 20;

    // Nreqs - number of requests
    const unsigned n_reqs = TEST_TRNCT;

    // DutyCycle (%) - Values: 1-100 ~ 1-100%
    const unsigned  duty_cycle = 100;

    // Ttotal - Overall time interval of operations
    const unsigned  t_total = n_reqs*(100/duty_cycle);

    // Ton - activation during a period
    const unsigned  t_on = n_reqs*(duty_cycle/100);

    // Toff - deactivation during a period
    const unsigned  t_off = n_reqs*(1-duty_cycle/100);

    // Generate the source image with a fixed test pattern - checker-board
    for (int i = 0; i < TEST_TRNCT; i++) {
        ref[i] = i;
        stream_in << i;
    }

    // Generate DUT convolution image
    // traffic_gen(stream_in, stream_out, t_total, t_on, t_off);
    traffic_gen(stream_in, stream_out, n_reqs, duty_cycle);

    // Check DUT vs reference result

    for (int i = 0; i < n_reqs; i++) {
            data_t dut_val = stream_out.read();
            data_t ref_val = ref[i];
            // error check
            if (dut_val != ref_val) {
                err_cnt++;
#if 0
                cout << "!!! ERROR: Mismatch detected at coord(" << i;
                cout << ", " << j << " ) !!!";
                cout << endl;
#endif
        }
    }
    cout << endl;

    if (err_cnt == 0) {
        cout << "\n\n*** TEST PASSED ***\n\n" << endl;
        ret_val = 0;
    } else {
        cout << "\n\n!!! TEST FAILED - " << err_cnt << " mismatches detected !!!\n\n";
        cout << endl;
        ret_val = -1;
    }

    return ret_val;
}