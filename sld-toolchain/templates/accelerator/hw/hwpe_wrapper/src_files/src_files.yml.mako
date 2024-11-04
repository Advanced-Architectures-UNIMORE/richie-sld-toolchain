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

    Description:    Manifest script intended for an use with iptools.

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
# Title:          src_files.yml
#
# Description:    Manifest script intended for an use with iptools.
#
# Date:           11.6.2021
#
# Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

hwpe_wrapper:
  incdirs : [
    rtl
  ]
  files: [

    <%
    # HLS typically generates .dat files. These are used to initialize IPs
    # with pre-defined values. Since the standalone TB and its source management
    # tool fatigue to process these files, they are not sourced together with the
    # other accelerator datapath modules. To succesfully make ModelSim process these
    # files, they should be placed in the top ModelSim working directory.
    %>

    % for i in range (acc_wr_num_datapath_modules):
      % if ".dat" not in acc_wr_datapath_modules[i]:
    rtl/datapath/${acc_wr_datapath_modules[i]},
      % endif
    % endfor
    rtl/${acc_wr_target}_package.sv,
    rtl/${acc_wr_target}_fsm.sv,
    rtl/${acc_wr_target}_ctrl.sv,
    rtl/${acc_wr_target}_streamer.sv,
    rtl/${acc_wr_target}_datapath_adapter.sv,
    rtl/${acc_wr_target}_engine.sv,
    rtl/${acc_wr_target}_top.sv,
    rtl/${acc_wr_target}_top_wrapper.sv,
    rtl/${acc_wr_target}_cluster_intf.sv,
  ]
  vlog_opts : [
    "-L hwpe_ctrl_lib",
    "-L hwpe_stream_lib"
  ]
