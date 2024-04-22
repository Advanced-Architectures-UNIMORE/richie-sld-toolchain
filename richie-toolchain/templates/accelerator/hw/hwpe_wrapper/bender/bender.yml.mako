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

# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia
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
# Project:        Richie
#
# Title:          Bender.yml
#
# Description:    Manifest script intended for an use with Bender, the
#                 dependency management tool employed to define dependencies
#                 among the many IPs coexisting inside the platform.
#                 More information is available under:
#
#                     ==> https://github.com/pulp-platform/bender
#
# Date:           11.6.2021
#
# Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

package:
  name: ${acc_wr_target}

dependencies:
  hwpe-ctrl: { git: "git@github.com:gbellocchi/hwpe-ctrl.git", rev: master }
  hwpe-stream: { git: "git@github.com:gbellocchi/hwpe-stream.git", rev: master }

workspace:
  checkout_dir: "./deps"

sources:
  % for i in range (acc_wr_num_kernel_modules):
  - rtl/datapath/${acc_wr_kernel_modules[i]}
  % endfor
  - rtl/${acc_wr_target}_package.sv
  - rtl/${acc_wr_target}_fsm.sv
  - rtl/${acc_wr_target}_ctrl.sv
  - rtl/${acc_wr_target}_streamer.sv
  - rtl/${acc_wr_target}_kernel_adapter.sv
  - rtl/${acc_wr_target}_engine.sv
  - rtl/${acc_wr_target}_top.sv
  - rtl/${acc_wr_target}_top_wrapper.sv
  - rtl/${acc_wr_target}_cluster_intf.sv
