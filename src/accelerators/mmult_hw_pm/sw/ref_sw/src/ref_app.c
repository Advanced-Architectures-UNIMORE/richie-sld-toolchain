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

void ref_app(uint32_t* in1, uint32_t* in2, uint32_t* out, uint32_t width, uint32_t height)
{
  for (unsigned i = 0; i < width; i++){
    for (unsigned j = 0; j < height; j++){
      for (unsigned k = 0; k < width; k++){
        out[i * height + j] += in1[i * height + k] * in2[j * width  + k];
      }
    }
  }
}