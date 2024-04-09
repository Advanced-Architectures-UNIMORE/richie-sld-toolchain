<%
'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

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

    Description:    PULP top.

    Date:           13.1.2022

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%
# =====================================================================
# Title:        def_param_max_txns_per_cluster
# Type:         Template API
# Description:  Definition of maximum number of transactions per cluster.
#
# =====================================================================
%>

<%def name="def_param_max_txns()">\
  % for i in range(n_clusters):
  localparam int unsigned MAX_TXNS_CLUSTER_${i} = pulp_cluster_${i}_cfg_pkg::N_CORES + pulp_cluster_${i}_cfg_pkg::DMA_MAX_N_TXNS;
  % endfor  
  localparam int unsigned MAX_TXNS_OVERALL = N_CLUSTERS * (${inst_param_max_txns_per_cluster()});
</%def>

<%
# =====================================================================
# Title:        inst_param_max_txns_per_cluster
# Type:         Template API
# Description:  Sum and instantiate maximum number of transactions per
#               cluster.
# =====================================================================
%>

<%def name="inst_param_max_txns_per_cluster()">\
% for i in range(n_clusters-1):
MAX_TXNS_CLUSTER_${i} + \
% endfor 
MAX_TXNS_CLUSTER_${n_clusters-1}\
</%def>