<%
'''
    =====================================================================

    Copyright (C) 2020 University of Modena and Reggio Emilia

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

    Description:    Accelerator interface testbench.

    Date:           1.9.2020

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/* 
 * 
 * Copyright (C) 2018-2019 ETH Zurich, University of Bologna
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * Author: Francesco Conti <fconti@iis.ee.ethz.ch>
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: tb_hwpe.sv
 *
 */

// Standard libs
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>

// HWPE
#include "inc/hwpe_lib/archi_hwpe.h"
#include "inc/hwpe_lib/hal_hwpe.h"

${include_t_libs()}

/* - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / */

/*
 *
 *     HWPE SW test.
 *
 */

int main() {

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
  ${hwpe_wfi()}

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

  ${error_check()}
}