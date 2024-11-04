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

    Description:    C structures for HWPE accelerators.

    Date:           15.7.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

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
 * Title:           def_struct_hwpe_${cl_lic_acc_names[accelerator_id]}.h
 *
 * Description:     C structures for HWPE accelerators.
 *
 * Date:            15.7.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

#ifndef __HWPE_STRUCTS_${cl_lic_acc_names[accelerator_id].upper()}_H__
#define __HWPE_STRUCTS_${cl_lic_acc_names[accelerator_id].upper()}_H__

#include <common_structs/def_struct_hwpe_common.h>

/* Definition - Types */

typedef struct hwpe_stream_struct ${cl_lic_acc_names[accelerator_id]}_stream_struct;
typedef struct ${cl_lic_acc_names[accelerator_id]}_custom_regs_struct ${cl_lic_acc_names[accelerator_id]}_custom_regs_struct;
typedef struct ${cl_lic_acc_names[accelerator_id]}_ctrl_struct ${cl_lic_acc_names[accelerator_id]}_ctrl_struct;
typedef struct ${cl_lic_acc_names[accelerator_id]}_wrapper_struct ${cl_lic_acc_names[accelerator_id]}_wrapper_struct;

/* Definition - Functions */

typedef void (*Program_${cl_lic_acc_names[accelerator_id].title()})(${cl_lic_acc_names[accelerator_id]}_wrapper_struct *_wrapper);
typedef void (*Command_${cl_lic_acc_names[accelerator_id].title()})();

/* Definition - Structs */

struct ${cl_lic_acc_names[accelerator_id]}_custom_regs_struct {
% if acc_wr_custom_reg_num>0:
    % for i in range (acc_wr_custom_reg_num):
    unsigned ${acc_wr_custom_reg_name[i]};
    % endfor
% endif
};

struct ${cl_lic_acc_names[accelerator_id]}_ctrl_struct {
    hwpe_engine_struct engine;
    hwpe_fsm_struct fsm;
    ${cl_lic_acc_names[accelerator_id]}_custom_regs_struct custom_regs;
};

struct ${cl_lic_acc_names[accelerator_id]}_wrapper_struct {

    hwpe_id id;

% for i in range (acc_wr_n_sink):
    ${cl_lic_acc_names[accelerator_id]}_stream_struct ${acc_wr_stream_in[i]};
% endfor
% for j in range (acc_wr_n_source):
    ${cl_lic_acc_names[accelerator_id]}_stream_struct ${acc_wr_stream_out[j]};
% endfor

    ${cl_lic_acc_names[accelerator_id]}_ctrl_struct           ctrl;

    Program_${cl_lic_acc_names[accelerator_id].title()} init;
    Program_${cl_lic_acc_names[accelerator_id].title()} program;
    Program_${cl_lic_acc_names[accelerator_id].title()} update_buffer_addr;
    Command_${cl_lic_acc_names[accelerator_id].title()} compute;
    Command_${cl_lic_acc_names[accelerator_id].title()} wait;
    Command_${cl_lic_acc_names[accelerator_id].title()} clear;
};

#endif
