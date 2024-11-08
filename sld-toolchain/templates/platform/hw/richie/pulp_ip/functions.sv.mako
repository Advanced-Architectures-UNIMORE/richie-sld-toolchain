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

    Description:    PULP IP interface for the Vivado® IP packager flow.

    Date:           25.1.2022

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''  
%>

<%def name="logic(width)">\
  <%
    if width == 1:
      typ = 'wire        '
    else:
      typ = "wire [%3d:0]" % (width - 1)
  %>
  ${typ}\
</%def>

<%def name="port(name, width, output, active_low=False)">\
  <%
    if output:
      direction = 'output'
      suffix = 'o'
    else:
      direction = 'input '
      suffix = 'i'
    if width == 1:
      typ = '        '
    else:
      typ = "[%3d:0] " % (width - 1)
    if active_low:
      suffix = 'n' + suffix
    name = name + '_' + suffix
  %>
  % if width > 0:
  ${direction} ${typ} ${name}\
  % endif
</%def>

<%def name="axi_ax_ports(prefix, master, aw, iw, uw)">\
  ${port(prefix + '_id', iw, master)},\
  ${port(prefix + '_addr', aw, master)},\
  ${port(prefix + '_len', 8, master)},\
  ${port(prefix + '_size', 3, master)},\
  ${port(prefix + '_burst', 2, master)},\
  ${port(prefix + '_lock', 1, master)},\
  ${port(prefix + '_cache', 4, master)},\
  ${port(prefix + '_prot', 3, master)},\
  ${port(prefix + '_qos', 4, master)},\
  ${port(prefix + '_user', uw, master)},\
  ${port(prefix + '_valid', 1, master)},\
  ${port(prefix + '_ready', 1, not master)}\
</%def>

<%def name="axi_w_ports(prefix, master, dw)">\
  ${port(prefix + '_data', dw, master)},\
  ${port(prefix + '_strb', dw/8, master)},\
  ${port(prefix + '_last', 1, master)},\
  ${port(prefix + '_valid', 1, master)},\
  ${port(prefix + '_ready', 1, not master)}\
</%def>

<%def name="axi_b_ports(prefix, master, iw)">\
  ${port(prefix + '_id', iw, not master)},\
  ${port(prefix + '_resp', 2, not master)},\
  ${port(prefix + '_valid', 1, not master)},\
  ${port(prefix + '_ready', 1, master)}\
</%def>

<%def name="axi_r_ports(prefix, master, dw, iw)">\
  ${port(prefix + '_id', iw, not master)},\
  ${port(prefix + '_data', dw, not master)},\
  ${port(prefix + '_resp', 2, not master)},\
  ${port(prefix + '_last', 1, not master)},\
  ${port(prefix + '_valid', 1, not master)},\
  ${port(prefix + '_ready', 1, master)}\
</%def>

<%def name="axi_ports(prefix, master, aw, dw, iw, uw)">\
  ${axi_ax_ports(prefix + '_aw', master, aw, iw, uw)},\
  ${axi_w_ports(prefix + '_w', master, dw)},\
  ${axi_b_ports(prefix + '_b', master, iw)},\
  ${axi_ax_ports(prefix + '_ar', master, aw, iw, uw)},\
  ${axi_r_ports(prefix + '_r', master, dw, iw)}\
</%def>

<%def name="axi_lite_ax_ports(prefix, master, aw)">\
  ${port(prefix + '_addr', aw, master)},\
  ${port(prefix + '_prot', 3, master)},\
  ${port(prefix + '_valid', 1, master)},\
  ${port(prefix + '_ready', 1, not master)}\
</%def>

<%def name="axi_lite_w_ports(prefix, master, dw)">\
  ${port(prefix + '_data', dw, master)},\
  ${port(prefix + '_strb', dw/8, master)},\
  ${port(prefix + '_valid', 1, master)},\
  ${port(prefix + '_ready', 1, not master)}\
</%def>

<%def name="axi_lite_b_ports(prefix, master)">\
  ${port(prefix + '_resp', 2, not master)},\
  ${port(prefix + '_valid', 1, not master)},\
  ${port(prefix + '_ready', 1, master)}\
</%def>

<%def name="axi_lite_r_ports(prefix, master, dw)">\
  ${port(prefix + '_data', dw, not master)},\
  ${port(prefix + '_resp', 2, not master)},\
  ${port(prefix + '_valid', 1, not master)},\
  ${port(prefix + '_ready', 1, master)}\
</%def>

<%def name="axi_lite_ports(prefix, master, aw, dw)">\
  ${axi_lite_ax_ports(prefix + '_aw', master, aw)},\
  ${axi_lite_w_ports(prefix + '_w', master, dw)},\
  ${axi_lite_b_ports(prefix + '_b', master)},\
  ${axi_lite_ax_ports(prefix + '_ar', master, aw)},\
  ${axi_lite_r_ports(prefix + '_r', master, dw)}\
</%def>