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

<%
# =====================================================================
# Title:        vsim_waves_periph_mst
# Type:         Template API
# Description:  Peripheral master ports.
# =====================================================================
%>

<%def name="vsim_waves_hesoc_periph_mst()">\
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_id
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_addr
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_len
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_size
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_burst
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_lock
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_cache
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_prot
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_qos
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_region
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_atop
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_user
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_valid
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/aw_ready
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/w_data
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/w_strb
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/w_last
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/w_user
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/w_valid
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/w_ready
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/b_id
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/b_resp
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/b_user
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/b_valid
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/b_ready
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_id
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_addr
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_len
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_size
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_burst
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_lock
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_cache
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_prot
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_qos
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_region
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_user
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_valid
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/ar_ready
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_id
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_data
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_resp
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_last
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_user
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_valid
add wave -noupdate -group {HeSoC} -group {periph_mst} /richie_tb/dut/periph_mst/r_ready
</%def>

<%
# =====================================================================
# Title:        vsim_waves_hesoc_periph
# Type:         Template API
# Description:  hesoc peripheral ports.
# =====================================================================
%>

<%def name="vsim_waves_hesoc_periph()">\
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_id
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_addr
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_len
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_size
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_burst
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_lock
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_cache
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_prot
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_qos
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_region
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_atop
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_user
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_valid
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/aw_ready
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/w_data
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/w_strb
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/w_last
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/w_user
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/w_valid
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/w_ready
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/b_id
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/b_resp
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/b_user
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/b_valid
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/b_ready
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_id
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_addr
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_len
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_size
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_burst
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_lock
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_cache
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_prot
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_qos
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_region
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_user
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_valid
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/ar_ready
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_id
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_data
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_resp
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_last
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_user
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_valid
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/axi} /richie_tb/dut/i_periphs/axi/r_ready
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/paddr
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/pwdata
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/pwrite
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/psel
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/penable
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/prdata
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/pready
add wave -noupdate -group {HeSoC} -group {hesoc_periphs/apb} /richie_tb/dut/i_periphs/apb/pslverr
</%def>

<%
# =====================================================================
# Title:        vsim_waves_hesoc_ctrl_regs
# Type:         Template API
# Description:  hesoc control registers.
# =====================================================================
%>

<%def name="vsim_waves_hesoc_ctrl_regs()">\
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/paddr
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/pwdata
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/pwrite
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/psel
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/penable
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/prdata
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/pready
add wave -noupdate -group {HeSoC} -group {hesoc_ctrl_regs/apb} /richie_tb/dut/i_periphs/i_hesoc_ctrl_regs/apb/pslverr
</%def>

<%
# =====================================================================
# Title:        vsim_waves_hesoc_l2_mem
# Type:         Template API
# Description:  L2 memory.
# =====================================================================
%>

<%def name="vsim_waves_hesoc_l2_mem()">\
% for i_l2_bank in range(n_l2_banks):
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_id}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_addr}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_len}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_size}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_burst}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_lock}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_cache}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_prot}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_qos}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_region}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_atop}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_user}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_valid}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/aw_ready}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/w_data}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/w_strb}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/w_last}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/w_user}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/w_valid}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/w_ready}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/b_id}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/b_resp}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/b_user}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/b_valid}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/b_ready}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_id}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_addr}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_len}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_size}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_burst}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_lock}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_cache}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_prot}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_qos}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_region}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_user}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_valid}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/ar_ready}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_id}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_data}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_resp}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_last}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_user}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_valid}
add wave -noupdate -group {HeSoC} -group {l2_mst[${i_l2_bank}]} {/richie_tb/dut/l2_mst[${i_l2_bank}]/r_ready}
% endfor
</%def>

<%
# =====================================================================
# Title:        vsim_waves_hesoc_interconnect
# Type:         Template API
# Description:  HeSoC interconnect.
# =====================================================================
%>

<%def name="vsim_waves_hesoc_interconnect()">\

add wave -noupdate -group {HeSoC} -group {HeSoC interconnect} -group {top} {/richie_tb/dut/i_hesoc_interconnect/*}
add wave -noupdate -group {HeSoC} -group {HeSoC interconnect} -group {i_axi_xbar} {/richie_tb/dut/i_hesoc_interconnect/i_axi_xbar/*}
<%
    # N_MASTERS = N_CLUSTERS + L2_N_PORTS + 3 (RAB, MBOX_HOST, MBOX_PULP)
%>
% for i_master in range(n_clusters+n_l2_banks+3):
add wave -noupdate -group {HeSoC} -group {HeSoC interconnect} -group {masters[${i_master}]} {/richie_tb/dut/i_hesoc_interconnect/masters[${i_master}]/*}
% endfor

<%
    # N_SLAVES = N_CLUSTERS + 1 (RAB)
%>
% for i_slave in range(n_clusters+1):
add wave -noupdate -group {HeSoC} -group {HeSoC interconnect} -group {slave[${i_slave}]} {/richie_tb/dut/i_hesoc_interconnect/slaves[${i_slave}]/*}
% endfor
</%def>
