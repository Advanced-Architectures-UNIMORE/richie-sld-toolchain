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

packages:
  common_verification:
    revision: 9c07fa860593b2caabd9b5681740c25fac04b878
    version: 0.2.3
    source:
      Git: https://github.com/pulp-platform/common_verification.git
    dependencies: []
  hwpe-ctrl:
    revision: b53f7a408746c51ef5430f4da8974cec26f28a1c
    version: null
    source:
      Git: git@github.com:gbellocchi/hwpe-ctrl.git
    dependencies:
    - tech_cells_generic
  hwpe-stream:
    revision: 772da7969f31c435993273e1a6b49402dc35e3d8
    version: null
    source:
      Git: git@github.com:gbellocchi/hwpe-stream.git
    dependencies:
    - tech_cells_generic
  scm:
    revision: 998466d2a3c2d7d572e43d2666d93c4f767d8d60
    version: 1.1.1
    source:
      Git: https://github.com/pulp-platform/scm.git
    dependencies: []
  tech_cells_generic:
    revision: 7968dd6e6180df2c644636bc6d2908a49f2190cf
    version: 0.2.13
    source:
      Git: https://github.com/pulp-platform/tech_cells_generic.git
    dependencies:
    - common_verification
  ${acc_wr_target}:
    revision: null
    version: null
    source:
      Path: ips/${acc_wr_target}
    dependencies:
    - hwpe-ctrl
    - hwpe-stream
  zeroriscy:
    revision: 030b03da470c355176f23c0a50479414323fa8e3
    version: null
    source:
      Git: https://github.com/FrancescoConti/ibex.git
    dependencies: []
