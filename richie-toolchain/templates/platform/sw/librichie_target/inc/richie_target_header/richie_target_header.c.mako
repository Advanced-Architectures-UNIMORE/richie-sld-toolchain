<%
'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

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

    Title:          Host/Device API definitions

    Description:    This class collects the templates which comply with
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by
                    the generation scripts under:

                        ==> 'richie-toolchain/richie-toolchain/generate_*.py'

                    - The object is then passed to a generator, which
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-toolchain/richie-toolchain/python/<component-libraries>/generator.py'

    Date:           22.11.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
  # Wrapper dependencies
  accelerator_id = extra_param_0
%>

/* =====================================================================
 *
 * Copyright (C) 2022 University of Modena and Reggio Emilia
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * =====================================================================
 *
 * Project:         Richie
 *
 * Title:           richie-target.h
 *
 * Description:     Host/Device API definitions.
 *
 * Date:            22.11.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

<%
    # Extra parameters
    list_cl_lic = extra_param_0
    list_cl_hci = extra_param_1

    # Get accelerator designs
    acc_design_names = []

    # Start by inspecting the accelerators
    # connected to the LIC of each cluster
    for i in range(n_clusters):
        cl_lic_acc_names = list_cl_lic[i][1]
        for n in cl_lic_acc_names:
            if n not in acc_design_names:
                acc_design_names.append(n)

    # Then check the accelerators connected
    # to the HCI of each cluster
    for i in range(n_clusters):
        cl_hci_acc_names = list_cl_hci[i][1]
        for n in cl_hci_acc_names:
            if n not in acc_design_names:
                acc_design_names.append(n)
%>

/* =====================================================================
 * Project:      LibRICHIE
 * Title:        richie-target.h
 * Description:  Definition of APIs for the accelerator-rich system.
 *
 * $Date:        13.7.2022
 * ===================================================================== */
/*
 * Copyright (C) 2022 University of Modena and Reggio Emilia.
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */

#ifndef __RICHIE_API_H__
#define __RICHIE_API_H__

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

/* Hardware accelerators */

% for i in range(len(acc_design_names)):
#include <common_structs/def_struct_hwpe_${acc_design_names[i]}.h>
% endfor

% if inline_richie_api == 1:
${def_hwpe_includes_inline()}
% endif

// If LLVM, use our address space support, otherwise fall back to bit-compatible
// data types.
#if defined(__llvm__)
#   define RICHIE_DEVICE_PTR __device richie_struct*
#else
#   define RICHIE_DEVICE_PTR richie_struct*
#endif

/* Definition - Types */

typedef struct richie_struct richie_struct;

/* Definition - Structs */

struct richie_struct {

% for i in range(n_clusters):

    <%
        # Determine cluster ID

        cluster_id = i

        # Count number of wrappers

        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>

    /* Accelerators - Cluster ${cluster_id} */

    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
    ${cl_lic_acc_names[accelerator_id]}_wrapper_struct ${cl_lic_acc_names[accelerator_id]}_${cluster_id}_${accelerator_id};
    % endfor
% endfor

};

% if inline_richie_api == 0:
/* RICHIE functions declaration  */

void richie_init(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
int richie_activate(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
void richie_program(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
void richie_update_buffer_addr(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
void richie_compute(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
void richie_wait_eu(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
void richie_wait_polling(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
int richie_is_finished(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id);
void richie_free(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id);
% else:
/* RICHIE functions definition  */

${def_richie_api_pulp_inline()}
% endif

#endif
