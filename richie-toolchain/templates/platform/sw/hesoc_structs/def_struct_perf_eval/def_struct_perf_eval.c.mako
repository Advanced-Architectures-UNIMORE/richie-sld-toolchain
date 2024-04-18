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

    Title:          C structures for HeSoC performance evaluation

    Description:    This class collects the templates which comply with
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by
                    the generation scripts under:

                        ==> 'richie-toolchain/richie-toolchain/generate_*.py'

                    - The object is then passed to a generator, which
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-toolchain/richie-toolchain/python/generator.py'

    Date:           15.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
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
 * Title:           def_struct_hesoc_perf_eval.h
 *
 * Description:     C structures for HeSoC performance evaluation.
 *
 * Date:            13.7.2022
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

#ifndef __HESOC_STRUCTS_PERF_EVAL_H__
#define __HESOC_STRUCTS_PERF_EVAL_H__

/* Libraries */

#include <stdint.h>
#include <stdbool.h>
#include <time.h>

/* System. */

#include <hero-target.h>

// Structs - Performance evaluation

typedef struct host_timer_struct        host_timer_struct;
typedef struct pulp_clk_struct          pulp_clk_struct;

struct host_timer_struct {
    struct timespec t0;
    struct timespec t1;
    float t_meas;
};

struct pulp_clk_struct {
    uint32_t cnt_0;
    uint32_t cnt_1;
    uint32_t cnt_2;
};

// Structs - PULP

typedef struct pulp_dma_struct        pulp_dma_struct;

struct pulp_dma_struct {
    hero_dma_job_t job;
    pulp_clk_struct clk;
};

#endif
