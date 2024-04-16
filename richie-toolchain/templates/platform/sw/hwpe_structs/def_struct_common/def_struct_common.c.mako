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

    Title:          Template

    Description:    Default C structures for HWPE accelerators.

    Date:           15.7.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
  # Wrapper dependencies 
  list_acc_types = extra_param_0
  list_acc_integrated = extra_param_1
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
 * Title:           def_struct_hwpe_common.h
 *
 * Description:     Default C structures for HWPE accelerators.
 *
 * Date:            15.7.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

#ifndef __HWPE_STRUCTS_COMMON_H__
#define __HWPE_STRUCTS_COMMON_H__

#include <hero-target.h>

/* Definition - Type ID */

<%
    acc = list_acc_types[0]
%>
\
% for i in range(len(list_acc_types)):
    <%
        acc = list_acc_types[i]
    %>
#define ${acc.upper()} ${i} \
% endfor


/* Definition - Connection ID */

<%
    acc = list_acc_integrated[0]
%>
\

/* Definition - Types */

typedef struct hwpe_id                      hwpe_id;
typedef struct hwpe_l1_ptr_struct           hwpe_l1_ptr_struct;
typedef struct hwpe_dma_struct              hwpe_dma_struct;
typedef struct hwpe_addr_gen_struct         hwpe_addr_gen_struct;
typedef struct hwpe_dataset_params_struct   hwpe_dataset_params_struct;
typedef struct hwpe_stream_struct           hwpe_stream_struct;
typedef struct hwpe_sw_states               hwpe_sw_states;
typedef struct hwpe_engine_struct           hwpe_engine_struct;
typedef struct hwpe_fsm_struct              hwpe_fsm_struct;

/* Definition - Structs */

struct hwpe_id {
    int type;
    int cid;
    int aid;
};

struct hwpe_l1_ptr_struct {
    DEVICE_PTR ptr;
    uint32_t dim_buffer;
};

struct hwpe_dma_struct {
    uint32_t cnt_tx;
    uint32_t num_tx;
};

struct hwpe_addr_gen_struct {
    unsigned port_offset; 
    unsigned trans_size; 
    unsigned line_stride; 
    unsigned line_length; 
    unsigned feat_stride; 
    unsigned feat_length; 
    unsigned feat_roll; 
    unsigned loop_outer; 
    unsigned realign_type; 
    unsigned step;
};

struct hwpe_dataset_params_struct {
    uint32_t width;
    uint32_t height;
    uint32_t stim_dim;
    uint32_t stripe_height;
    uint32_t stripe_length;
    uint32_t buffer_dim;
    uint32_t buffer_stride;     // buffer allocation
    uint32_t data_stride;       // data memory access
};

struct hwpe_stream_struct {
    hwpe_l1_ptr_struct tcdm;
    // hwpe_dma_struct dma;
    hwpe_addr_gen_struct addr_gen;
    hwpe_dataset_params_struct params;
};

struct hwpe_engine_struct {
% if acc_wr_is_hls_stream is True:
    % for i in range (acc_wr_n_sink):
    uint32_t packet_size_${acc_wr_stream_in[i]};
    % endfor
% endif
};

struct hwpe_fsm_struct {
    uint32_t n_engine_runs;
};

#endif