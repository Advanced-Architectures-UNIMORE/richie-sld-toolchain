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

    Title:          Device accelerator middleware

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
 * Description:     Device accelerator middleware.
 *
 * Date:            15.7.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

/* HWPE */

// Library

#include <libhwpe/hwpe_cl${cl_id}_lic${accelerator_id}.h>

// Hardware abstraction layer

#include <libhwpe/archi/hwpe_cl${cl_id}_lic${accelerator_id}.h>
#include <libhwpe/hal/hwpe_cl${cl_id}_lic${accelerator_id}.h>

/* PULP peripherals */

#include <archi/eu/eu_v3.h>
#include <hal/eu/eu_v3.h>

/* ==================================================================================== */

/* Initialization */

void richie_cl${cl_id}_lic${accelerator_id}_init(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *wrapper) {

    // Set type ID -- Accelerator nature
    wrapper->id.type   = ${cl_lic_acc_names[accelerator_id].upper()};

    // Set cluster ID -- About the cluster where the accelerator is integrated
    wrapper->id.cid    = ${cl_id};

    // Set accelerator ID -- About the position of the accelerator in the LIC/HCI accelerator region
    wrapper->id.aid    = ${accelerator_id};
};

/* Activation */

int richie_cl${cl_id}_lic${accelerator_id}_activate() {

    // Activate wrapper
    int offload_id;
    hwpe_cg_enable();
    while((offload_id = hwpe_acquire_job()) < 0);
    return offload_id;
};

/* Programming */

void richie_cl${cl_id}_lic${accelerator_id}_program(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *wrapper) {

    // Extract streams

% for i in range (acc_wr_n_sink):
    // ${cl_lic_acc_names[accelerator_id]}_stream_struct stream_${acc_wr_stream_in[i]}   = wrapper->${acc_wr_stream_in[i]}; \
% endfor

% for j in range (acc_wr_n_source):
    // ${cl_lic_acc_names[accelerator_id]}_stream_struct stream_${acc_wr_stream_out[j]}  = wrapper->${acc_wr_stream_out[j]}; \
% endfor


    // Extract controller

    // ${cl_lic_acc_names[accelerator_id]}_ctrl_struct ctrl          = wrapper->ctrl;

    /*
     * STANDARD REGISTERS
     */

% if acc_wr_is_hls_stream is True:
    // Packet size - only for hls::stream object (refer to AMBA 4 AXI4-Stream Protocol)

    // Necessary to drive the last signal for sink (input) streams

  % for i in range (acc_wr_n_sink):
    hwpe_packet_size_set_${acc_wr_stream_in[i]}(wrapper->ctrl.engine.packet_size_${acc_wr_stream_in[i]} - 1);
  % endfor
% endif

    // Iteration length

    // Number of engine computations before an event is generated

% for j in range (acc_wr_n_source):
    hwpe_len_iter_set_${acc_wr_stream_out[j]}(wrapper->ctrl.fsm.n_engine_runs - 1);
% endfor

    // Address generator programming

% for i in range (acc_wr_n_sink):
    % if (acc_wr_addr_gen_in_isprogr[i]):
        % if (acc_wr_is_parallel_in[i]):
    hwpe_addr_gen_${acc_wr_stream_in[i]}(
        wrapper->${acc_wr_stream_in[i]}.addr_gen.trans_size,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.line_stride,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.line_length,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.feat_stride,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.feat_length,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.feat_roll,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.loop_outer,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.realign_type,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.port_offset,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.step
    );
      % else:
    hwpe_addr_gen_${acc_wr_stream_in[i]}(
        wrapper->${acc_wr_stream_in[i]}.addr_gen.trans_size,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.line_stride,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.line_length,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.feat_stride,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.feat_length,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.feat_roll,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.loop_outer,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.realign_type,
        wrapper->${acc_wr_stream_in[i]}.addr_gen.step
    );
        % endif
    % endif
% endfor

% for j in range (acc_wr_n_source):
    % if (acc_wr_addr_gen_out_isprogr[j]):
        % if (acc_wr_is_parallel_out[j]):
    hwpe_addr_gen_${acc_wr_stream_out[j]}(
        wrapper->${acc_wr_stream_out[j]}.addr_gen.trans_size,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.line_stride,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.line_length,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.feat_stride,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.feat_length,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.feat_roll,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.loop_outer,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.realign_type,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.port_offset,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.step
    );
        % else:
    hwpe_addr_gen_${acc_wr_stream_out[j]}(
        wrapper->${acc_wr_stream_out[j]}.addr_gen.trans_size,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.line_stride,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.line_length,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.feat_stride,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.feat_length,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.feat_roll,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.loop_outer,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.realign_type,
        wrapper->${acc_wr_stream_out[j]}.addr_gen.step
    );
        % endif
    % endif
% endfor

    /*
     * CUSTOM REGISTERS
     */

    // Set user custom registers

% if acc_wr_custom_reg_num>0:
    % for i in range (acc_wr_custom_reg_num):
    hwpe_${acc_wr_custom_reg_name[i]}_set( wrapper->ctrl.custom_regs.${acc_wr_custom_reg_name[i]} );
    % endfor
% endif

    /*
     * TCDM REGISTERS
     */

    // Program controller with L1 buffer address

% for i in range (acc_wr_n_sink):
    hwpe_${acc_wr_stream_in[i]}_addr_set((int32_t)wrapper->${acc_wr_stream_in[i]}.tcdm.ptr);
% endfor

% for j in range (acc_wr_n_source):
    hwpe_${acc_wr_stream_out[j]}_addr_set((int32_t)wrapper->${acc_wr_stream_out[j]}.tcdm.ptr);
% endfor
};

/* Data memory interaction */

void richie_cl${cl_id}_lic${accelerator_id}_update_buffer_addr(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *wrapper) {

    // Extract streams

% for i in range (acc_wr_n_sink):
    // ${cl_lic_acc_names[accelerator_id]}_stream_struct stream_${acc_wr_stream_in[i]}   = wrapper->${acc_wr_stream_in[i]};
% endfor
% for j in range (acc_wr_n_source):
    // ${cl_lic_acc_names[accelerator_id]}_stream_struct stream_${acc_wr_stream_out[j]}  = wrapper->${acc_wr_stream_out[j]};
% endfor

    /*
     * TCDM REGISTERS
     */

    // Program controller with L1 buffer address

% for i in range (acc_wr_n_sink):
    hwpe_${acc_wr_stream_in[i]}_addr_set((int32_t)wrapper->${acc_wr_stream_in[i]}.tcdm.ptr);
% endfor

% for j in range (acc_wr_n_source):
    hwpe_${acc_wr_stream_out[j]}_addr_set((int32_t)wrapper->${acc_wr_stream_out[j]}.tcdm.ptr);
% endfor
};

/* Processing */

void richie_cl${cl_id}_lic${accelerator_id}_compute() {
    hwpe_trigger_job();
};

/* Synchronization via Event Unit */

void richie_cl${cl_id}_lic${accelerator_id}_wait_eu() {

    // TODO: Accelerators share the same event line inside a cluster,
    // hence the processor needs to proactively check which accelerator
    // has terminated after an event is received.

    // Cores go to sleep and EU is programmed to wait for
    // hardware event coming from the accelerator region.

    __asm__ __volatile__ ("" : : : "memory");
    eu_evt_maskWaitAndClr(1 << ARCHI_CL_EVT_ACC0);
    __asm__ __volatile__ ("" : : : "memory");
};

/* Synchronization via Active Core Polling */

void richie_cl${cl_id}_lic${accelerator_id}_wait_polling() {

    // The core starts polling on the accelerator to verify
    // whether It has terminated its operations.

    while(!hwpe_get_finished()){
      asm volatile ("nop");
    }
};

/* Termination */

int richie_cl${cl_id}_lic${accelerator_id}_is_finished() {

    // Check if accelerator has terminated its operation
    int is_finished = hwpe_get_finished();
    return is_finished;
};

/* Deactivation */

void richie_cl${cl_id}_lic${accelerator_id}_free() {
    hwpe_soft_clear();
    hwpe_cg_disable();
};
