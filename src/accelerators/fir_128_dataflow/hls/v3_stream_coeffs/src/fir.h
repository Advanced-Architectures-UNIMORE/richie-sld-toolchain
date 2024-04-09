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
#include <iomanip>
#include <cstdlib>

using namespace std;

#if 0
typedef int data_t;
typedef int coeff_t;
typedef int sum_t;
#else
#include "ap_int.h"
typedef ap_int<32> data_t;
typedef ap_int<32> coeff_t;
typedef ap_int<32> sum_t;
#endif

#define N_SAMPLES 512*8
#define TAP 128

void fir(data_t &x, coeff_t coeff[TAP], sum_t &y);

// firing unit cell class
template <typename T0, typename T1, typename T2>
class systolic
{
private:
  T0 x,  x1;
  T2 y0, y1;

public:
  // Based on systolic fir description in Xilinx UG073
  void exec(T0 &x_in, T1 &h, T2 &y_in, T0 &x_out, T2 &y)
  {
    x_out = x1;
    x1    = x;
    x     = x_in;
    y     = y1;
    y1    = y0 + y_in;
    y0    = x_out * h;
  }
};

// void fir(data_t &x, sum_t &y)
// {
// #pragma HLS INTERFACE axis port=x
// #pragma HLS INTERFACE axis port=y

// // #pragma HLS INTERFACE ap_ctrl_none port=coeff
// // #pragma HLS ARRAY_PARTITION variable=coeff complete dim=1 

// #pragma HLS INTERFACE ap_ctrl_none port=return

//   // const int n_taps = TAP;

//   #pragma HLS PIPELINE II=4

//   sum_t tmp = 0;

//   static systolic<data_t, coeff_t, sum_t> s[TAP];
//   #pragma HLS ARRAY_PARTITION variable=s complete dim=1

//   data_t x_int[TAP];
//   #pragma HLS ARRAY_PARTITION variable=x_int complete dim=1

//   coeff_t h[TAP];
//   #pragma HLS ARRAY_PARTITION variable=h complete dim = 1

//   data_t y_int[TAP];
//   #pragma HLS ARRAY_PARTITION variable=y_int complete dim=1

//   // read coefficients
//   for (int i = 0; i < TAP; i++) {
//     h[i] = 10; //coeff[i];
//   }

//   // Connect the fir execution blocks to implement the systolic
//   // fir chain.
// loop_connect: for (int i = 0; i < TAP; i++)
//   {
//     // s[i].exec(x_int[i], h[i], y_int[i], x_int[i], y_int[i]);
//     if(i==0)
//       s[0].exec(x, h[i], tmp, x_int[i], y_int[i]);
//     else
//       s[i].exec(x_int[i - 1], h[i], y_int[i - 1], x_int[i], y_int[i]);
//   }
//   y = y_int[TAP - 1];
// }
