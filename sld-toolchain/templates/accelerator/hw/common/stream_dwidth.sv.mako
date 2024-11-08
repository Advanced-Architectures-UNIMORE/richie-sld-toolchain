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

    Description:    Common parameters and functions.

    Date:           11.6.2021

    Author: 		    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

<%
  # Assess dimension of IO data interfaces. The host system is 64b, while the accelerator-rich one is 32b.
  # However, accelerator datapaths with different data widths might be integrated for many reasons (e.g. optimziation
  # regarding data communication), hence It is important to support them accordingly.

  # IMP:
  # Right now we only supports smaller (than 32b) data widths in the datapath adapter.
  # TO-DO:
  # 1. Extend supporting for multiples of 32b.
  # 2. Support also non-multiples (use remainder).

  # Constants
  host_dwidth = 64
  pulp_dwidth = 32

  # Input variables
  remainder_words_in = []
  remainder_bytes_in = []
  n_words_in = []
  n_bytes_in = []

  # Output variables
  remainder_words_out = []
  remainder_bytes_out = []
  n_words_out = []
  n_bytes_out = []

  # Scan all input streams
  for i in range (acc_wr_n_sink):
    # Check if data with is a multiple of a word
    remainder_words_in.append(acc_wr_stream_in_dwidth[i] % pulp_dwidth)
    # Check if data with is a multiple of a byte
    remainder_bytes_in.append(acc_wr_stream_in_dwidth[i] % 8)
    # Check how many words is the interface packing
    n_words_in.append((acc_wr_stream_in_dwidth[i] - remainder_words_in[i]) // pulp_dwidth)
    # Check how many bytes is the interface packing
    n_bytes_in.append((acc_wr_stream_in_dwidth[i] - remainder_bytes_in[i]) // 8)
  endfor

  # Scan all output streams
  for j in range (acc_wr_n_source):
    # Check if data with is a multiple of a word
    remainder_words_out.append(acc_wr_stream_out_dwidth[j] % pulp_dwidth)
    # Check if data with is a multiple of a byte
    remainder_bytes_out.append(acc_wr_stream_out_dwidth[j] % 8)
    # Check how many words is the interface packing
    n_words_out.append((acc_wr_stream_out_dwidth[j] - remainder_words_out[j]) // pulp_dwidth)
    # Check how many bytes is the interface packing
    n_bytes_out.append((acc_wr_stream_out_dwidth[j] - remainder_bytes_out[j]) // 8)
  endfor
%>
