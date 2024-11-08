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

    Description:    Lock script intended for an use with Bender, the
                    dependency management tool employed to define dependencies
                    among the many IPs coexisting inside the platform.
                    More information is available under:

                        ==> https://github.com/pulp-platform/bender

    Date:           29.12.2021

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
  # Accelerator interface dependencies
  wrapper_deps = extra_param_0

  # Count number of accelerator interfaces
  n_wrapper_deps = len(wrapper_deps)
%>

---
packages:
  apb:
    revision: d077333a7e5cc80008935dc2761440532dfdce81
    version: 0.1.0
    source:
      Git: "https://github.com/pulp-platform/apb.git"
    dependencies: []
  axi:
    revision: 88c92c17563af8644920b4ef26456b5fa8e363e2
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi.git"
    dependencies:
      - common_cells
      - common_verification
  axi2apb:
    revision: 61a07b11f7cf4b6aa96100ac1b0f3a86a780018b
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi2apb.git"
    dependencies:
      - apb
      - axi
  axi2mem:
    revision: f038968581a54cc5c5fc6fac83fa5d914f89b036
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi2mem.git"
    dependencies:
      - axi_slice
      - common_cells
  axi2per:
    revision: fa8d9137caef7bd0726b905efb0c20401f5cd70f
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi2per.git"
    dependencies:
      - axi_slice
  axi_riscv_atomics:
    revision: eafccfb892fd34cf6c89f766c2852cb52ea19b54
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi_riscv_atomics.git"
    dependencies:
      - axi
      - common_cells
      - common_verification
  axi_slice:
    revision: a6d761ababbba9ec49daf840925977b4aa529556
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi_slice.git"
    dependencies:
      - common_cells
  axi_slice_dc:
    revision: 7e5ad1bf7b517589a89f92fe99a7fa9178d5c778
    version: ~
    source:
      Git: "https://github.com/pulp-platform/axi_slice_dc.git"
    dependencies:
      - axi
      - axi_slice
  cluster_interconnect:
    revision: e3172c42789b13556dff798e5c8f640e66cc3052
    version: ~
    source:
      Git: "https://github.com/pulp-platform/cluster_interconnect.git"
    dependencies: []
  cluster_peripherals:
    revision: 56206bf50bf5c1150b14cb958ea4eed716d21278
    version: ~
    source:
      Git: "https://github.com/pulp-platform/cluster_peripherals.git"
    dependencies:
      - cluster_interconnect
  common_cells:
    revision: 53fade6f0f101a236b6280d872a73c47cf08b83b
    version: ~
    source:
      Git: "https://github.com/pulp-platform/common_cells.git"
    dependencies:
      - common_verification
      - tech_cells_generic
  common_verification:
    revision: 122a733f21027ce1098ebcc0e2a121e63d315b4d
    version: ~
    source:
      Git: "https://github.com/pulp-platform/common_verification.git"
    dependencies: []
  event_unit_flex:
    revision: d0cb7e92bd23ad28701a765d413bbeeb9e9cd514
    version: ~
    source:
      Git: "https://github.com/pulp-platform/event_unit_flex.git"
    dependencies: []
  % if (n_wrapper_deps>0):
  hwpe-ctrl:
    revision: master
    version: ~
    source:
      Git: "git@github.com:gbellocchi/hwpe-ctrl.git"
    dependencies: []
  hwpe-stream:
    revision: master
    version: ~
    source:
      Git: "git@github.com:gbellocchi/hwpe-stream.git"
    dependencies: []
  % endif
  icache-intc:
    revision: 42aee659c80b682ceb7a74ec3f8fd9ba054fea59
    version: 1.0.0
    source:
      Git: "https://github.com/pulp-platform/icache-intc.git"
    dependencies: []
  icache_mp_128_pf:
    revision: 5344c4d8d1403e8b54c5c0c3ae8e4fb7c8296567
    version: ~
    source:
      Git: "https://github.com/pulp-platform/icache_mp_128_pf.git"
    dependencies:
      - axi_slice
      - cluster_peripherals
      - common_cells
      - icache-intc
      - scm
  pulp_cluster:
    revision: acc_rich_ov
    version: ~
    source:
      Git: "git@git.hipert.unimore.it:comp4drones/HERO/pulp_cluster.git"
    dependencies:
      - axi
      - axi2mem
      - axi2per
      - axi_slice
      - axi_slice_dc
      - cluster_interconnect
      - cluster_peripherals
      - event_unit_flex
      - icache_mp_128_pf
      - per2axi
      - riscv
      - timer_unit
      - cluster
  per2axi:
    revision: 3095411ea20f8f97cb72f0febff07a74e69b5d14
    version: ~
    source:
      Git: "https://github.com/pulp-platform/per2axi.git"
    dependencies:
      - axi_slice
      - riscv
  riscv:
    revision: d84cd23a66fef580f0ee980e554432a1d2ecbea3
    version: ~
    source:
      Git: "https://github.com/pulp-platform/riscv.git"
    dependencies:
      - fpnew
      - tech_cells_generic
  scm:
    revision: afd32402ac4636ca141fc0de1ae03d7b9078c527
    version: 1.0.0
    source:
      Git: "https://github.com/pulp-platform/scm.git"
    dependencies: []
  tech_cells_generic:
    revision: e1655889cf947b0f39c3f4e95410487d3505a771
    version: ~
    source:
      Git: "https://github.com/pulp-platform/tech_cells_generic.git"
    dependencies: []
  timer_unit:
    revision: 9227dc7c9b3c3b6899dc02c12e970bf27320adb5
    version: 1.0.0
    source:
      Git: "https://github.com/pulp-platform/timer_unit.git"
    dependencies: []
  fpnew:
    revision: 4a241d48e7e16ebd146423769828fdcd7e90de61
    version: ~
    source:
      Git: "https://github.com/pulp-platform/fpnew.git"
    dependencies:
      - common_cells
      - fpu_div_sqrt_mvp
  fpu_div_sqrt_mvp:
    revision: 83a601f97934ed5e06d737b9c80d98b08867c5fa
    version: ~
    source:
      Git: "https://github.com/pulp-platform/fpu_div_sqrt_mvp.git"
    dependencies:
      - common_cells

  <%
    # Lock HeSoC package information
  %>

  hesoc:
    source:
      Path: "./src/${hesoc_name}/hesoc"
    dependencies:
      - axi2apb
      - axi
      - axi2mem
      - axi_riscv_atomics
      - axi_slice_dc
      - common_verification
      - pulp_cluster

  <%
    # Lock cluster package information
  %>

  cluster:
    source:
      Path: "./src/${hesoc_name}/cluster"
    % if (n_wrapper_deps>0):
    dependencies:
      % for i in range(n_wrapper_deps):
      - ${wrapper_deps[i]}
      % endfor
    % else:
    dependencies: []
    % endif

  <%
    # Lock accelerator wrapper packages information
  %>

% if (n_wrapper_deps>0):
  % for i in range(n_wrapper_deps):

  ${wrapper_deps[i]}:
    source:
      Path: "./src/${hesoc_name}/accelerators/${wrapper_deps[i]}"
    dependencies:
      - hwpe-stream
      - hwpe-ctrl

  % endfor
% endif
