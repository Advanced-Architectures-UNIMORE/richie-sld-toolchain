/* =====================================================================
 * Project:      Verification dataset generator.
 * Title:        main.c
 * Description:  Main function recalling components to generate 
 *               stimuli and golden results for RTL simulation.
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

int main(int argc, char *argv[])
{
  /* Stimuli dimension. */

  unsigned width = W;
  unsigned height = H;

  /* Allocate I/O arrays. */

  uint32_t* in1 = (uint32_t*)malloc(width*height*sizeof(uint32_t));
  uint32_t* in2 = (uint32_t*)malloc(width*height*sizeof(uint32_t));
  uint32_t* out = (uint32_t*)malloc(width*height*sizeof(uint32_t)); 

  /* Generate synthetic stimuli. */

  gen_stim(in1, in2, width, height);

  /* Generate golden results. */

  ref_app(in1, in2, out, width, height);

  /* Create output header files. */

  gen_Hfile("in1", in1, width, height);
  gen_Hfile("in2", in2, width, height);
  gen_Hfile("out_r", out, width, height);

  /* Cleanup. */  

  free(in1);
  free(in2);

  return 0;
}
