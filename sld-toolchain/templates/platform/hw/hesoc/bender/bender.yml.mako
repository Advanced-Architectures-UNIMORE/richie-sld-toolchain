<%
'''
    =====================================================================

    Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia

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

    Date:           29.12.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

# =====================================================================
#
# Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia
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
# Project:              Richie
#
# Title:                Bender.yml
#
# Description:          Manifest script intended for an use with Bender, the
#                       dependency management tool employed to define dependencies
#                       among the many IPs coexisting inside the platform.
#                       More information is available under:
#
#                           ==> https://github.com/pulp-platform/bender
#
# Date:                 29.12.2021
#
# Author: 	            Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

package:
  name: hesoc
  authors: [ "Gianluca Bellocchi <gianluca.bellocchi@unimore.it>", "Andreas Kurth <akurth@iis.ee.ethz.ch>" ]

dependencies:
  axi2apb: { git: "https://github.com/pulp-platform/axi2apb.git", rev: atop }
  axi: { git: "https://github.com/pulp-platform/axi.git", rev: axi_dwc_akurth }
  axi2mem: { git: "https://github.com/pulp-platform/axi2mem.git", rev: undefined } # TODO: upstream
  axi_riscv_atomics: { git: "https://github.com/pulp-platform/axi_riscv_atomics.git", rev: fix-ordering }
  axi_slice_dc: { git: "https://github.com/pulp-platform/axi_slice_dc.git", rev: atomics }
  common_verification: { git: "https://github.com/pulp-platform/common_verification.git", rev: release-0.2 }
  pulp_cluster: { git: "git@git.hipert.unimore.it:comp4drones/HERO/pulp_cluster.git", rev: acc_rich_ov }

workspace:
  checkout_dir: "./deps"

export_include_dirs:
  - rtl/apb/include # TODO: move to APB repository
  - packages

sources:
  # generic APB modules; to be moved to APB repository
  - rtl/apb/apb_bus.sv
  - rtl/apb/apb_ro_regs.sv
  - rtl/apb/apb_rw_regs.sv
  - rtl/apb/apb_bus_wrap.sv
  # Level 0
  - packages/hesoc_cfg_pkg.sv
  # Level 1
  - rtl/hero_axi_mailbox.sv
  - rtl/hesoc_interconnect.sv
  - rtl/hesoc_ctrl_regs.sv
  - rtl/out-of-context/dmac_wrap_ooc.sv
  # Level 2
  - rtl/l2_mem.sv
  % for i in range(n_clusters):
  - rtl/out-of-context/pulp_cluster_${i}_ooc.sv
  % endfor
  - rtl/hesoc_peripherals.sv
  # Level 3
  - rtl/pulp.sv
  # Level 4
  - rtl/out-of-context/pulp_ooc.sv

  - target: test
    files:
      # Level 0
      - rtl/apb/apb_stdout.sv
