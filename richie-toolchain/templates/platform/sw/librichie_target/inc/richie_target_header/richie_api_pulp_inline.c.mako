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

    Title:          Host/Device API definitions.

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
# =====================================================================
# Title:        def_hwpe_includes_inline
# Type:         Template API
# Description:  Define needed includes for inlined RICHIE APIs.
# =====================================================================
%>

<%def name="def_hwpe_includes_inline()">\

<%
    # Extra parameters
    list_cl_lic = extra_param_0
    list_cl_hci = extra_param_1
%>

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
#include <libhwpe/hwpe_cl${cluster_id}_lic${accelerator_id}.h> \
    % endfor
% endfor

</%def>

<%
# =====================================================================
# Title:        def_richie_api_pulp_inline
# Type:         Template API
# Description:  Definition of inlined RICHIE APIs.
# =====================================================================
%>

<%def name="def_richie_api_pulp_inline()">\

<%
    # Extra parameters
    list_cl_lic = extra_param_0
    list_cl_hci = extra_param_1
%>

static inline void richie_init(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to initialize */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_init(&(richie->${cl_lic_acc_names[accelerator_id]}_${cluster_id}_${accelerator_id})); break; \
    % endfor

            default: printf("Error: No matching case for <richie_init>\n");
        }
    }
% endfor

};

static inline int richie_activate(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to activate */

    int offload_id;

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: offload_id = richie_cl${cluster_id}_lic${accelerator_id}_activate(); break; \
    % endfor

            default: printf("Error: No matching case for <richie_activate>\n");
        }
    }
% endfor

    return offload_id;
};

static inline void richie_program(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to program */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_program(&(richie->${cl_lic_acc_names[accelerator_id]}_${cluster_id}_${accelerator_id})); break; \
    % endfor

            default: printf("Error: No matching case for <richie_program>\n");
        }
    }
% endfor

};

static inline void richie_update_buffer_addr(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to update with new buffer addresses */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_update_buffer_addr(&(richie->${cl_lic_acc_names[accelerator_id]}_${cluster_id}_${accelerator_id})); break; \
    % endfor

            default: printf("Error: No matching case for <richie_update_buffer_addr>\n");
        }
    }
% endfor

};

static inline void richie_compute(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to execute */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_compute(); break; \
    % endfor

            default: printf("Error: No matching case for <richie_compute>\n");
        }
    }
% endfor

    // Use the following low-level implementation only if:
	// - HWPE peripheral ports start at 0x1b202000
	// - HWPE peripheral address range equals 0x200
	// Check the cluster interconnect design for more information.

	// uint32_t add = 0x1b202000 + accelerator_id * 0x200;
	// pulp_write32(add, 0);

};

static inline void richie_wait_eu(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to wait for */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_wait_eu(); break; \
    % endfor

            default: printf("Error: No matching case for <richie_wait_eu>\n");
        }
    }
% endfor

};

static inline void richie_wait_polling(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to wait for */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_wait_polling(); break; \
    % endfor

            default: printf("Error: No matching case for <richie_wait_polling>\n");
        }
    }
% endfor

};

static inline int richie_is_finished(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to check for termination */

    int is_finished;

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: is_finished = richie_cl${cluster_id}_lic${accelerator_id}_is_finished(); break; \
    % endfor

            default: printf("Error: No matching case for <richie_is_finished>\n");
        }
    }
% endfor

    return is_finished;
};

static inline void richie_free(RICHIE_DEVICE_PTR richie, const int cluster_id, const int accelerator_id){

    /* Decide which hardware accelerator to disable */

% for i in range(n_clusters):
    <%
        # Determine cluster ID

        cluster_id = i

        # List of accelerator names
        cl_lic_acc_names = list_cl_lic[i][1]
        cl_hci_acc_names = list_cl_hci[i][1]

        # Count number of wrappers

        n_acc_cl = len(cl_lic_acc_names) + len(cl_hci_acc_names)
    %>
    if(cluster_id == ${cluster_id}){
        switch (accelerator_id){
    % for j in range(n_acc_cl):
        <%
            # Determine accelerator ID

            accelerator_id = j
        %>
	        case ${accelerator_id}: richie_cl${cluster_id}_lic${accelerator_id}_free(); break; \
    % endfor

            default: printf("Error: No matching case for <richie_free>\n");
        }
    }
% endfor

};

</%def>
