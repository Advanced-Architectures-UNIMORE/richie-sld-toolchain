<%
'''
    =====================================================================

    Copyright (C) 2021 University of Modena and Reggio Emilia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    =====================================================================

    Project:        Richie Toolchain

    Title:          Template

    Description:    HWPE architecture macros.

    Date:           11.6.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/*
 *
 * Authors:     Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 */

// Standard libs
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>

// System
#include <hero-acc_wr_target.h>

// HWPE
#include "inc/hwpe_lib/archi_hwpe.h"
#include "inc/hwpe_lib/hal_hwpe.h"

// Event unit
#include "inc/eu_lib/archi_eu_v3.h"
#include "inc/eu_lib/hal_eu_v3.h"

${include_t_libs()}

/* - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / */

/*
 *
 *     HWPE SW test.
 *
 */

int main() {

  printf("Software test application - DUT: ${acc_wr_target}\n");

  <%
  #############################
  ## Declare test parameters ##
  #############################
  %>

  ${decl_t_params()}

  <%
  ##############################################
  ## Address generator parameters declaration ##
  ##############################################
  %>

  ${hwpe_addressgen_in_memcpy_acc_mem()}
  ${hwpe_addressgen_out_memcpy_acc_mem()}

  <%
  ###############################
  ## Test stimuli - Allocation ##
  ###############################
  %>

  printf("Allocation and initialization of L1 stimuli\n");

  ${allocate_t_stims()}

  <%
  ###################################
  ## Test stimuli - Initialization ##
  ###################################
  %>

  ${init_t_stims()}

  <%
  ######################
  ## HWPE programming ##
  ######################
  %>

  ${hwpe_init()}
  ${hwpe_fsm_progr()}
  ${hwpe_addressgen_progr()}
  ${hwpe_tcdm_progr()}
  ${hwpe_custom_regs_progr()}

  <%
  ####################
  ## HWPE execution ##
  ####################
  %>

  ${hwpe_exec()}
  ${hwpe_eu_progr()}

  <%
  #######################
  ## HWPE deactivation ##
  #######################
  %>

  ${hwpe_disable()}

  <%
  #################
  ## Error check ##
  #################
  %>

  // // /* Error check on L2. */
  // printf("Results check");

  // for (i = 0; i < stripe_height; i++){
  //   for (j = 0; j < stripe_height; j++){
  //     if(y_l1[i*stripe_height+j] != y_golden[i*stripe_height+j]){
  //       printf("[%d]    L1 - y_test:    %d \n",  i*stripe_height+j, y_l1[i*stripe_height+j]);
  //       printf("[%d]    L1 - y_golden:  %d\n\n", i*stripe_height+j, y_golden[i*stripe_height+j]);
  //       errors++;
  //     }
  //   }
  // }

  // /* Return errors */
  // printf("errors: %d\n", errors);
  // printf("end\n");

  return errors;
}
