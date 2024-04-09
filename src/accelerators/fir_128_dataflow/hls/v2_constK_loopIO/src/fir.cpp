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
#include "inc/taps.h"

void fir_128_dataflow(data_t x[N_SAMPLES], sum_t y[N_SAMPLES])
{
  #pragma HLS INTERFACE axis port=x
  #pragma HLS INTERFACE axis port=y
  #pragma HLS INTERFACE ap_ctrl_none port=return

  static systolic<data_t, coeff_t, sum_t> s[TAP];
  #pragma HLS ARRAY_PARTITION variable=s complete dim=1

  sum_t tmp = 0;

  data_t x_int[TAP];
  #pragma HLS ARRAY_PARTITION variable=x_int dim=1 complete

  coeff_t h[TAP];
  #pragma HLS ARRAY_PARTITION variable=h complete dim = 1

  data_t y_int[TAP];
  #pragma HLS ARRAY_PARTITION variable=y_int dim=1 complete

  for (int i = 0; i < TAP; i++) {
    h[i] = taps[i];
  }

  // Connect the fir execution blocks to implement the systolic
  // fir chain.
  loopA: for (int i = 0; i < N_SAMPLES; i++) {
  #pragma HLS PIPELINE

    data_t local_x = x[i];

    loopB: for (int j = 0; j < TAP; j++) {
      if(j==0)
        s[0].exec(local_x, h[j], tmp, x_int[j], y_int[j]);
      else
        s[j].exec(x_int[j - 1], h[j], y_int[j - 1], x_int[j], y_int[j]);
    }
    y[i] = y_int[TAP - 1];
  }
}