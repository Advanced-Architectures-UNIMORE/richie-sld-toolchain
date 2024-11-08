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

    Title:          Host accelerator middleware

    Description:    This class collects the templates which comply with
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by
                    the generation scripts under:

                        ==> 'richie-sld-toolchain/sld-toolchain/generate_*.py'

                    - The object is then passed to a generator, which
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-sld-toolchain/sld-toolchain/python/generator.py'

    Date:           15.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
  # Accelerator interface dependencies
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
 * Title:           hwpe_cl${cl_id}_lic${accelerator_id}.c
 *
 * Description:     Host accelerator middleware.
 *
 * Date:            15.7.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

#include <libhwpe/hwpe_cl${cl_id}_lic${accelerator_id}.h>

/* Initialization */

void richie_cl${cl_id}_lic${accelerator_id}_init(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *wrapper) {
    return;
};

/* Activation */

int richie_cl${cl_id}_lic${accelerator_id}_activate() {
    return 0;
};

/* Programming */

void richie_cl${cl_id}_lic${accelerator_id}_program(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *wrapper) {
    return;
};

/* Data memory interaction */

void richie_cl${cl_id}_lic${accelerator_id}_update_buffer_addr(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *wrapper) {
    return;
};

/* Processing */

void richie_cl${cl_id}_lic${accelerator_id}_compute() {
    return;
};

/* Synchronization via Event Unit */

void richie_cl${cl_id}_lic${accelerator_id}_wait_eu() {
    return;
};

/* Synchronization via Active Core Polling */

void richie_cl${cl_id}_lic${accelerator_id}_wait_polling() {
    return;
};

/* Termination */

int richie_cl${cl_id}_lic${accelerator_id}_is_finished() {
    return 0;
};

/* Deactivation */

void richie_cl${cl_id}_lic${accelerator_id}_free() {
    return;
};
