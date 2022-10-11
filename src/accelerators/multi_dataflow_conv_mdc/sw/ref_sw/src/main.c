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

  unsigned width          = IM_UAV_ROWS;
  unsigned height         = IM_UAV_COLS;
  unsigned stripe_height  = IM_BLOCK_ROWS;

  /* Allocate I/O arrays. */

  uint32_t* src_V = (uint32_t*)malloc(width*height*sizeof(uint32_t));
  uint32_t* dst_V = (uint32_t*)malloc(width*height*sizeof(uint32_t)); 

  /* Additional parameters. */

  const unsigned stripe_len        = width*stripe_height;

  /* Generate synthetic stimuli. */

  gen_stim(src_V, width, height);

  /* Generate golden results. */

  ref_app(src_V, dst_V, width, height);

  /* Create output header files. */

  gen_Hfile("src_V", src_V, width, height);
  gen_Hfile("dst_V", dst_V, width, height);

  /* Cleanup. */  

  free(src_V);
  free(dst_V);

  return 0;
}
