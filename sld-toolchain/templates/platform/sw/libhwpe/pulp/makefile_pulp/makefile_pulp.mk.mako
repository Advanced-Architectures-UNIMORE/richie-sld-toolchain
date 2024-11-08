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

    Title:          Device Makefile.

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

    Date:           13.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

# =====================================================================
#
# Copyright (C) 2018 ETH Zurich and University of Bologna
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# =====================================================================
#
# Title:           		Makefile
#
# Description:     		Device Makefile.
#
# Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# ===================================================================== */

<%
  # Accelerator interface dependencies
  accelerator_id = extra_param_0
%>

PULP_PROPERTIES += pulp_chip
include $(PULP_SDK_HOME)/install/rules/pulp_properties.mk

PULP_LIBS                  = hwpe_cl${cl_id}_lic${accelerator_id}
PULP_LIB_CL_SRCS_hwpe_cl${cl_id}_lic${accelerator_id} += hwpe_cl${cl_id}_lic${accelerator_id}.c
PULP_CL_CFLAGS_hwpe_cl${cl_id}_lic${accelerator_id}    = -Wall -O3 -g3 -I./ -I$(HERO_PULP_INC_DIR)

-include $(PULP_SDK_HOME)/install/rules/pulp.mk

header::
	mkdir -p $(PULP_SDK_HOME)/install/include/libhwpe/archi
	mkdir -p $(PULP_SDK_HOME)/install/include/libhwpe/hal
	cp ../inc/hwpe_cl${cl_id}_lic${accelerator_id}.h $(PULP_SDK_HOME)/install/include/libhwpe
	cp ../inc/archi_hwpe.h $(PULP_SDK_HOME)/install/include/libhwpe/archi/hwpe_cl${cl_id}_lic${accelerator_id}.h
	cp ../inc/hal_hwpe.h $(PULP_SDK_HOME)/install/include/libhwpe/hal/hwpe_cl${cl_id}_lic${accelerator_id}.h
