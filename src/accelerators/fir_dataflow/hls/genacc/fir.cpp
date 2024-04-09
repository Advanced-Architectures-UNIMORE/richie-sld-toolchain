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

void fir_dataflow(data_t &x, coeff_t coeff[TAP], sum_t &y)
{
#pragma HLS INTERFACE axis port=x
#pragma HLS INTERFACE axis port=y

#pragma HLS INTERFACE ap_ctrl_none port=coeff
#pragma HLS ARRAY_PARTITION variable=coeff complete dim=1 

#pragma HLS INTERFACE ap_ctrl_none port=return

#pragma HLS PIPELINE II=4

  static systolic<data_t, coeff_t, sum_t> s[TAP];
  coeff_t h[TAP];
  data_t x_int[TAP];
  sum_t y_int[TAP];
  sum_t tmp = 0;

  // Connect the fir execution blocks to implement the systolic
  // fir chain.
connect:
  for (int i = 0; i < TAP; i++)
  {
    if (i == 0)
      s[0].exec(x, coeff[i], tmp, x_int[i], y_int[i]);
    else
      s[i].exec(x_int[i - 1], coeff[i], y_int[i - 1], x_int[i], y_int[i]);
    y = y_int[TAP - 1];
  }
}
