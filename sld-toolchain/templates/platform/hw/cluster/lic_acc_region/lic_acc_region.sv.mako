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

    Description:    PULP cluster accelerator region.

    Date:           29.12.2021

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

/* =====================================================================
 *
 * Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * =====================================================================
 *
 * Project:         Richie
 *
 * Title:           pulp_cluster_${cl_id}_lic_acc_region.sv
 *
 * Description:     The accelerator region is connected to the cluster 
 *                  infrastructure by means of a logarithmic interconnect (LIC). 
 *                  This module also instantiates the accelerator interfaces.
 *
 * Date:            29.12.2021
 *
 * Author:          Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */


${def_ip_acc_region()}
${insert_ip_hwpe_intf()}
