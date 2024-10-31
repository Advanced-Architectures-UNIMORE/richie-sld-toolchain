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

    Description:    Questasim waves.

    Date:           19.1.2022

    Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

% for cluster_offset in range(n_clusters):

${vsim_waves_hesoc_cluster_axi_inputs(cluster_offset)}
${vsim_waves_hesoc_cluster_axi_outputs(cluster_offset)}

% endfor

${vsim_waves_hesoc_interconnect()}
${vsim_waves_hesoc_l2_mem()}
${vsim_waves_hesoc_periph_mst()}
${vsim_waves_hesoc_periph()}
${vsim_waves_hesoc_ctrl_regs()}

<%
# =====================================================================
# Description:  Overlay testbench I/O signals.
# =====================================================================
%>

add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/dut/clk_i
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/dut/rst_ni
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/dut/cl_fetch_en_i
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/dut/cl_busy_o
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/dut/cl_eoc_o
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/from_pulp_req
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/from_pulp_resp
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/to_pulp_req
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/to_pulp_resp
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/rab_conf_req
add wave -noupdate -group {richie_tb} -group {I/O} /richie_tb/rab_conf_resp

<%
# =====================================================================
# Description:  Configuration knobs.
# =====================================================================
%>

quietly wave cursor active 1
configure wave -namecolwidth 271
configure wave -valuecolwidth 483
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {530958 ps}
