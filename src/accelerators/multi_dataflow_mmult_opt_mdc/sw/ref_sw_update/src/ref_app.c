/* =====================================================================
 * Project:      Verification dataset generator.
 * Title:        ref_app.c
 * Description:  Reference application to generate golden results. Its
 *               functionality is the same as the integrated hardware
 *               accelerator.
 * 
 * Algorithm:    Matrix Multiplication.
 * 
 * $Date:        14.11.2021
 * ===================================================================== */
/*
 * Copyright (C) 2021 University of Modena and Reggio Emilia..
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */

#include "ref_app.h"

void ref_app(uint32_t* in1, uint32_t* in2, uint32_t* out, uint32_t width, uint32_t height, uint32_t stripe_height)
{
//   for (unsigned i = 0; i < width; i++){
//     for (unsigned j = 0; j < stripe_height; j++){
//       for (unsigned k = 0; k < width; k++){
//         out[i * width + j] += in1[j * width + k] * in2[i * width  + k];
//       }
//     }
//   }
// }

  // uint32_t in1_buffer[stripe_height * width];
  // uint32_t in2_buffer[width * stripe_height];

  uint32_t res=0;

  // for(int jj = 0; jj < width; jj += stripe_height){
  //   for(int kk = 0; kk < height; kk += stripe_height){

      // /* Software prefetching. */
      // for(int iter=0, i=0, j=0; iter<width*stripe_height; iter++,j++){
      //   if( j== width){ j = 0; i++; }  
      //   in1_buffer[i*width+j] = in1[iter + jj*width];
      //   in2_buffer[j*stripe_height+i] = in2[j*width + i + kk];
      // }

      for (int i = 0 ; i < stripe_height ; i++){
        for(int j = 0 ; j < stripe_height ; j++){       
          int res = 0;
          for(int k = 0; k < width; k++){
            res += in1[i * stripe_height + k] * in2[k * stripe_height + j];
          }

          /* Write results. */
          out[i*stripe_height+j] = res; 
        }
      }
  //   }
  // }
}

      

