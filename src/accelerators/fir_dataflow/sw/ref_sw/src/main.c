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

  unsigned n_stim = N_STIM;

  /* Allocate I/O arrays. */

  uint32_t* x = (uint32_t*)malloc(n_stim*sizeof(uint32_t));
  uint32_t* y = (uint32_t*)malloc(n_stim*sizeof(uint32_t)); 

  /* Generate synthetic stimuli. */

  gen_stim(x, n_stim);

  /* Generate golden results. */

  ref_app(x, y, n_stim);

  /* Create output header files. */

  gen_Hfile("x_V", x, n_stim, 1);
  gen_Hfile("y_V", y, n_stim, 1);

  /* Cleanup. */  

  free(x);
  free(y);

  return 0;
}
