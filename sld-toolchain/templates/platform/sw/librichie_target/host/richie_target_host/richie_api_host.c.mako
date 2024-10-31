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

    Title:          Host API.

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
# =====================================================================
# Title:        def_richie_api_host
# Type:         Template API
# Description:  Define Richie APIs.
# =====================================================================
%>

<%def name="def_richie_api_host()">\

void richie_init(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

int richie_activate(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return 0;
}

void richie_program(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

void richie_update_buffer_addr(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

void richie_compute(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

void richie_wait_eu(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

void richie_wait_polling(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

int richie_is_finished(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){
    return 0;
}

void richie_free(RICHIE_DEVICE_PTR accelerators, const int cluster_id, const int accelerator_id){
    return;
}

</%def>
