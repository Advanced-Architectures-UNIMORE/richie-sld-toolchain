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

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
########################################################
## Library of components - Test check functionalities ##
########################################################
%>

<%
##############################################
## Test check functionalities - Error check ##
##############################################
%>

<%def name="error_check()">\

  % for j in range (n_source):
  // error check on ${stream_out[j]}
  for(i=0; i<${stream_out[j]}_height; i++){
    for(j=0; j<${stream_out[j]}_width; j++){
      int32_t dut_val = ${stream_out[j]}_l1[i*${stream_out[j]}_width+j];
      int32_t ref_val = ${stream_out[j]}_golden_l1[i*${stream_out[j]}_width+j];
      if(dut_val != ref_val) errors++;
    }
  }
  % endfor

  // return errors
  *(int *) 0x80000000 = errors;
  return errors;

</%def>