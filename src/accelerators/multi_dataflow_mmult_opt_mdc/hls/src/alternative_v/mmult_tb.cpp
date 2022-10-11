/**********
Copyright (c) 2018, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**********/

/*****
* Changes from Lab 04:
To achieve better performance on the matrix multiplication the 
input and output arrays are partitioned in the hardware function.
*****/

#include "mmult.h"

#ifndef NUM_TIMES
#define NUM_TIMES 2  
#endif

int main(int argc, char** argv)
{   
    data_t mat_dim =  DATA_SIZE;
    data_t block_dim =  BLOCK_SIZE;

    size_t square_matrix_size_bytes = sizeof(data_t) * mat_dim * mat_dim;
    size_t rect_matrix_size_bytes = sizeof(data_t) * mat_dim * block_dim;
    size_t little_square_matrix_size_bytes = sizeof(data_t) * block_dim * block_dim;

    // DRAM arrays
    data_t *in1 = (data_t *) malloc(square_matrix_size_bytes);
    data_t *in2 = (data_t *) malloc(square_matrix_size_bytes);
    data_t *hw_result = (data_t *) malloc(square_matrix_size_bytes);
    data_t *sw_result = (data_t *) malloc(square_matrix_size_bytes);

    // Accelerator buffers
    hls::stream<data_t> in1_buffer("in1_buffer");
    hls::stream<data_t> in2_buffer("in2_buffer");
    hls::stream<data_t> out_buffer("out_buffer");

    bool match = true;

    //Create test data
    for (int i = 0; i < mat_dim * mat_dim; i++) {
        in1[i] = rand() % mat_dim;
        in2[i] = rand() % mat_dim;
        sw_result[i] = 0;
        hw_result[i] = 0;
    }
         
    //Launch the software solution
    mmult_sw( in1, in2, sw_result, mat_dim);

    //Launch the hardware solution
    for(int jj = 0; jj < mat_dim; jj += block_dim){
        for(int kk = 0; kk < mat_dim; kk += block_dim){

            for (int i = 0; i < mat_dim * block_dim; i++) {
                in1_buffer << in1[jj*mat_dim + i];
                in2_buffer << in2[kk + i*block_dim];
            }

            mmult_mdc(in1_buffer, in2_buffer, out_buffer, mat_dim, mat_dim, block_dim);

            for (int i = 0; i < block_dim ; i++) {
                for (int j = 0; j < block_dim; j++) {
                    hw_result[kk + jj*mat_dim + j + i*block_dim] = out_buffer.read();
                }
            }
            
        }
    }

    //Compare the results of hardware to the software 
    for(int i=0; i< mat_dim * mat_dim; i++)
    {
        data_t dut_val = hw_result[i];
        data_t ref_val = sw_result[i];
        if( ref_val != dut_val )
        {
            std::cout << "Results Mismatch on " << "Row:" << i/mat_dim << "Col:" << i - (i/mat_dim)*mat_dim << std::endl;
            std::cout << "CPU output:" << ref_val <<"\t Hardware output:" << dut_val << std::endl;
            match = false;
            break;
        }
    }

    free(sw_result);

    std::cout << "\n\nTEST " << (match? "PASSED\n\n": "FAILED\n\n") << std::endl;
    return(match? EXIT_SUCCESS: EXIT_FAILURE);
}



