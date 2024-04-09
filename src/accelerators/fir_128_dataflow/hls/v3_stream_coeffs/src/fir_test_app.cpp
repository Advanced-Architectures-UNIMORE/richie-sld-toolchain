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

#include "fir.h"

#include "inc/x_V.h"
#include "inc/y_V_ref.h"
#include "inc/taps.h"

int main()
{
  size_t n_samples = N_SAMPLES;
  size_t n_coeffs = TAP;

  data_t din[n_samples];
  data_t dout_ref[n_samples];
  data_t dout_dut = 0;

  coeff_t coeffs[n_coeffs];

  int err_cnt = 0;

  // Create test data
  for (int i = 0; i < n_samples; i++) {
    din[i] = x_V[i];
    dout_ref[i] = y_V_ref[i];
  }

  // Create filter coeffs
  for (int i = 0; i < n_coeffs; i++) {
    coeffs[i] = taps[i];
  }

  //Launch the hardware solution
  for (int i = 0; i < n_samples; i++) {
    fir(din[i], coeffs, dout_dut);
    // fir(din[i], dout_dut);

    // error check
    std::cout << "Iter #" << i << std::endl;
    std::cout << "dout_dut = " << dout_dut << std::endl;
    std::cout << "dout_ref = " << dout_ref[i] << std::endl;

    if( dout_dut != dout_ref[i] ){
      err_cnt++;
    }
  }

  int ret_val = 0;
  
  if (err_cnt == 0) {
    cout << "*** TEST PASSED ***" << endl;
    int ret_val = 0;
  } else {
    cout << "!!! TEST FAILED - " << err_cnt << " mismatches detected !!!";
    cout << endl;
    int ret_val = -1;
  }

  return ret_val;
}
