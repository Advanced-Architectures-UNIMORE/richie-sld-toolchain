<%
'''
    =====================================================================

    Copyright (C) 2021 University of Modena and Reggio Emilia

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

    Description:    Manifest script intended for an use with Bender, the
                    dependency management tool employed to define dependencies
                    among the many IPs coexisting inside the platform.
                    More information is available under:

                        ==> https://github.com/pulp-platform/bender

    Date:           11.6.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

# Copyright 2023 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

package:
  name: hwpe-tb

dependencies:
  hwpe-ctrl:          { git: "git@github.com:gbellocchi/hwpe-ctrl.git", rev: master                   }
  zeroriscy:          { git: "https://github.com/FrancescoConti/ibex.git", rev: "bender"              }
  ${acc_wr_target}:   { path: "ips/${acc_wr_target}"                                                  }
  hwpe-stream:        { git: "git@github.com:gbellocchi/hwpe-stream.git", rev: master                 }
  scm:                { git: "https://github.com/pulp-platform/scm.git", rev: "master"                }
  tech_cells_generic: { git: "https://github.com/pulp-platform/tech_cells_generic.git", rev: "master" }

workspace:
  checkout_dir: "./ips"

sources:

  - target: vsim
    files:
      # Level 0
      - rtl/tb_dummy_memory.sv
      # Level 1
      - rtl/tb_hwpe.sv

  - target: verilator
    files:
      # Level 0
      - rtl/tb_dummy_memory.sv
      # Level 1
      - rtl/sim_hwpe.sv
