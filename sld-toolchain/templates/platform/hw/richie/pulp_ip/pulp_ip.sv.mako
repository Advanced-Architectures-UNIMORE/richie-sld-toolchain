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

/*
 * Copyright (C) 2018 ETH Zurich, University of Bologna
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: pulp_t${target_fpga_hesoc}.v
 *
 */

module pulp_t${target_fpga_hesoc} (\
  ${port('clk', 1, False)},\
  ${port('rst', 1, False, True)},
  ${axi_ports('mst', True, aw_pl2ps, dw, iw_pl2ps, uw_pl2ps)},
  ${axi_ports('slv', False, aw_ps2pl, dw, iw_ps2pl, uw_ps2pl)},
  ${axi_lite_ports('rab_conf', False, aw_lite, dw_lite)},
  ${port('cl_fetch_en', n_clusters, False)},\
  ${port('cl_busy', n_clusters, True)},\
  ${port('cl_eoc', n_clusters, True)},\
  ${port('rab_from_pulp_miss_irq', n_clusters, True)},\
  ${port('rab_from_pulp_multi_irq', n_clusters, True)},\
  ${port('rab_from_pulp_prot_irq', n_clusters, True)},\
  ${port('rab_from_host_miss_irq', n_clusters, True)},\
  ${port('rab_from_host_multi_irq', n_clusters, True)},\
  ${port('rab_from_host_prot_irq', n_clusters, True)},\
  ${port('rab_miss_fifo_full_irq', n_clusters, True)},\
  ${port('mbox_irq', 1, True)}
);
  ${logic(iw)} slv_aw_id,     slv_b_id,                   slv_ar_id,        slv_r_id,
               mst_aw_id,     mst_b_id,                   mst_ar_id,        mst_r_id;\
  ${logic(aw)} slv_aw_addr,                               slv_ar_addr,
               mst_aw_addr,                               mst_ar_addr,
               mst_aw_addr_idr,                           mst_ar_addr_idr;\
  ${logic(8)} slv_aw_len,                                slv_ar_len,
               mst_aw_len,                                mst_ar_len;\
  ${logic(3)} slv_aw_size,                               slv_ar_size,
               mst_aw_size,                               mst_ar_size;\
  ${logic(2)} slv_aw_burst,                              slv_ar_burst,
               mst_aw_burst,                              mst_ar_burst;\
  ${logic(1)} slv_aw_lock,                               slv_ar_lock,
               mst_aw_lock,                               mst_ar_lock;\
  ${logic(4)} slv_aw_cache,                              slv_ar_cache,
               mst_aw_cache,                              mst_ar_cache;\
  ${logic(3)} slv_aw_prot,                               slv_ar_prot,
               mst_aw_prot,                               mst_ar_prot;\
  ${logic(4)} slv_aw_qos,                                slv_ar_qos,
               mst_aw_qos,                                mst_ar_qos;\
  ${logic(4)} slv_aw_region,                             slv_ar_region,
               mst_aw_region,                             mst_ar_region;\
  ${logic(6)} slv_aw_atop,
               mst_aw_atop;\
  ${logic(uw)} slv_aw_user,   slv_b_user,   slv_w_user,   slv_ar_user,      slv_r_user,
               mst_aw_user,   mst_b_user,   mst_w_user,   mst_ar_user,      mst_r_user,
               mst_aw_user_idr,                           mst_ar_user_idr;\
  ${logic(1)} slv_aw_valid,  slv_b_valid,  slv_w_valid,  slv_ar_valid,     slv_r_valid,
               mst_aw_valid,  mst_b_valid,  mst_w_valid,  mst_ar_valid,     mst_r_valid,
               slv_aw_ready,  slv_b_ready,  slv_w_ready,  slv_ar_ready,     slv_r_ready,
               mst_aw_ready,  mst_b_ready,  mst_w_ready,  mst_ar_ready,     mst_r_ready;\
  ${logic(dw)}                              slv_w_data,                     slv_r_data,
                                            mst_w_data,                     mst_r_data;\
  ${logic(dw/8)}                              slv_w_strb,
                                            mst_w_strb;\
  ${logic(2)}                slv_b_resp,                                   slv_r_resp,
                              mst_b_resp,                                   mst_r_resp;\
  ${logic(1)}                              slv_w_last,                     slv_r_last,
                                            mst_w_last,                     mst_r_last;\

  pulp_ooc #(
    .N_CLUSTERS     (${n_clusters}),
    .AXI_DW         (${dw}),
    .L2_N_AXI_PORTS (${n_l2_banks})
  ) i_bound (
    .clk_i            (clk_i),
    .rst_ni           (rst_ni),

    .mst_aw_id_o      (mst_aw_id),
    .mst_aw_addr_o    (mst_aw_addr),
    .mst_aw_len_o     (mst_aw_len),
    .mst_aw_size_o    (mst_aw_size),
    .mst_aw_burst_o   (mst_aw_burst),
    .mst_aw_lock_o    (mst_aw_lock),
    .mst_aw_cache_o   (mst_aw_cache),
    .mst_aw_prot_o    (mst_aw_prot),
    .mst_aw_qos_o     (mst_aw_qos),
    .mst_aw_region_o  (mst_aw_region),
    .mst_aw_atop_o    (mst_aw_atop),
    .mst_aw_user_o    (mst_aw_user),
    .mst_aw_valid_o   (mst_aw_valid),
    .mst_aw_ready_i   (mst_aw_ready),
    .mst_w_data_o     (mst_w_data),
    .mst_w_strb_o     (mst_w_strb),
    .mst_w_last_o     (mst_w_last),
    .mst_w_user_o     (mst_w_user),
    .mst_w_valid_o    (mst_w_valid),
    .mst_w_ready_i    (mst_w_ready),
    .mst_b_id_i       (mst_b_id),
    .mst_b_resp_i     (mst_b_resp),
    .mst_b_user_i     (mst_b_user),
    .mst_b_valid_i    (mst_b_valid),
    .mst_b_ready_o    (mst_b_ready),
    .mst_ar_id_o      (mst_ar_id),
    .mst_ar_addr_o    (mst_ar_addr),
    .mst_ar_len_o     (mst_ar_len),
    .mst_ar_size_o    (mst_ar_size),
    .mst_ar_burst_o   (mst_ar_burst),
    .mst_ar_lock_o    (mst_ar_lock),
    .mst_ar_cache_o   (mst_ar_cache),
    .mst_ar_prot_o    (mst_ar_prot),
    .mst_ar_qos_o     (mst_ar_qos),
    .mst_ar_region_o  (mst_ar_region),
    .mst_ar_user_o    (mst_ar_user),
    .mst_ar_valid_o   (mst_ar_valid),
    .mst_ar_ready_i   (mst_ar_ready),
    .mst_r_id_i       (mst_r_id),
    .mst_r_data_i     (mst_r_data),
    .mst_r_resp_i     (mst_r_resp),
    .mst_r_last_i     (mst_r_last),
    .mst_r_user_i     (mst_r_user),
    .mst_r_valid_i    (mst_r_valid),
    .mst_r_ready_o    (mst_r_ready),

    .slv_aw_id_i      (slv_aw_id),
    .slv_aw_addr_i    (slv_aw_addr),
    .slv_aw_len_i     (slv_aw_len),
    .slv_aw_size_i    (slv_aw_size),
    .slv_aw_burst_i   (slv_aw_burst),
    .slv_aw_lock_i    (slv_aw_lock),
    .slv_aw_cache_i   (slv_aw_cache),
    .slv_aw_prot_i    (slv_aw_prot),
    .slv_aw_qos_i     (slv_aw_qos),
    .slv_aw_region_i  (slv_aw_region),
    .slv_aw_atop_i    (slv_aw_atop),
    .slv_aw_user_i    (slv_aw_user),
    .slv_aw_valid_i   (slv_aw_valid),
    .slv_aw_ready_o   (slv_aw_ready),
    .slv_w_data_i     (slv_w_data),
    .slv_w_strb_i     (slv_w_strb),
    .slv_w_last_i     (slv_w_last),
    .slv_w_user_i     (slv_w_user),
    .slv_w_valid_i    (slv_w_valid),
    .slv_w_ready_o    (slv_w_ready),
    .slv_b_id_o       (slv_b_id),
    .slv_b_resp_o     (slv_b_resp),
    .slv_b_user_o     (slv_b_user),
    .slv_b_valid_o    (slv_b_valid),
    .slv_b_ready_i    (slv_b_ready),
    .slv_ar_id_i      (slv_ar_id),
    .slv_ar_addr_i    (slv_ar_addr),
    .slv_ar_len_i     (slv_ar_len),
    .slv_ar_size_i    (slv_ar_size),
    .slv_ar_burst_i   (slv_ar_burst),
    .slv_ar_lock_i    (slv_ar_lock),
    .slv_ar_cache_i   (slv_ar_cache),
    .slv_ar_prot_i    (slv_ar_prot),
    .slv_ar_qos_i     (slv_ar_qos),
    .slv_ar_region_i  (slv_ar_region),
    .slv_ar_user_i    (slv_ar_user),
    .slv_ar_valid_i   (slv_ar_valid),
    .slv_ar_ready_o   (slv_ar_ready),
    .slv_r_id_o       (slv_r_id),
    .slv_r_data_o     (slv_r_data),
    .slv_r_resp_o     (slv_r_resp),
    .slv_r_last_o     (slv_r_last),
    .slv_r_user_o     (slv_r_user),
    .slv_r_valid_o    (slv_r_valid),
    .slv_r_ready_i    (slv_r_ready),

    .rab_conf_aw_addr_i   ({{12{1'b0}}, rab_conf_aw_addr_i[19:0]}),
    .rab_conf_aw_prot_i   (rab_conf_aw_prot_i),
    .rab_conf_aw_valid_i  (rab_conf_aw_valid_i),
    .rab_conf_aw_ready_o  (rab_conf_aw_ready_o),
    .rab_conf_w_data_i    (rab_conf_w_data_i),
    .rab_conf_w_strb_i    (rab_conf_w_strb_i),
    .rab_conf_w_valid_i   (rab_conf_w_valid_i),
    .rab_conf_w_ready_o   (rab_conf_w_ready_o),
    .rab_conf_b_resp_o    (rab_conf_b_resp_o),
    .rab_conf_b_valid_o   (rab_conf_b_valid_o),
    .rab_conf_b_ready_i   (rab_conf_b_ready_i),
    .rab_conf_ar_addr_i   ({{12{1'b0}}, rab_conf_ar_addr_i[19:0]}),
    .rab_conf_ar_prot_i   (rab_conf_ar_prot_i),
    .rab_conf_ar_valid_i  (rab_conf_ar_valid_i),
    .rab_conf_ar_ready_o  (rab_conf_ar_ready_o),
    .rab_conf_r_data_o    (rab_conf_r_data_o),
    .rab_conf_r_resp_o    (rab_conf_r_resp_o),
    .rab_conf_r_valid_o   (rab_conf_r_valid_o),
    .rab_conf_r_ready_i   (rab_conf_r_ready_i),

    .cl_fetch_en_i  (cl_fetch_en_i),
    .cl_eoc_o       (cl_eoc_o),
    .cl_busy_o      (cl_busy_o),

    .rab_from_pulp_miss_irq_o   (rab_from_pulp_miss_irq_o),
    .rab_from_pulp_multi_irq_o  (rab_from_pulp_multi_irq_o),
    .rab_from_pulp_prot_irq_o   (rab_from_pulp_prot_irq_o),
    .rab_from_host_miss_irq_o   (rab_from_host_miss_irq_o),
    .rab_from_host_multi_irq_o  (rab_from_host_multi_irq_o),
    .rab_from_host_prot_irq_o   (rab_from_host_prot_irq_o),
    .rab_miss_fifo_full_irq_o   (rab_miss_fifo_full_irq_o),
    .mbox_irq_o                 (mbox_irq_o)
  );

  axi_iw_converter_flat #(
    .AXI_SLV_PORT_ID_WIDTH        (${iw}),
    .AXI_MST_PORT_ID_WIDTH        (${iw_pl2ps}),
    .AXI_SLV_PORT_MAX_UNIQ_IDS    (8),
    .AXI_SLV_PORT_MAX_TXNS_PER_ID (16),
    .AXI_SLV_PORT_MAX_TXNS        (64),
    .AXI_MST_PORT_MAX_UNIQ_IDS    (8),
    .AXI_MST_PORT_MAX_TXNS_PER_ID (16),
    .AXI_ADDR_WIDTH               (${aw}),
    .AXI_DATA_WIDTH               (${dw}),
    .AXI_USER_WIDTH               (${uw})
  ) i_iw_converter_mst (
    .clk_i           (clk_i),
    .rst_ni          (rst_ni),

    .slv_aw_id_i     (mst_aw_id),
    .slv_aw_addr_i   (mst_aw_addr),
    .slv_aw_len_i    (mst_aw_len),
    .slv_aw_size_i   (mst_aw_size),
    .slv_aw_burst_i  (mst_aw_burst),
    .slv_aw_lock_i   (mst_aw_lock),
    .slv_aw_cache_i  (mst_aw_cache),
    .slv_aw_prot_i   (mst_aw_prot),
    .slv_aw_qos_i    (mst_aw_qos),
    .slv_aw_region_i (mst_aw_region),
    .slv_aw_atop_i   (mst_aw_atop),
    .slv_aw_user_i   (mst_aw_user),
    .slv_aw_valid_i  (mst_aw_valid),
    .slv_aw_ready_o  (mst_aw_ready),
    .slv_w_data_i    (mst_w_data),
    .slv_w_strb_i    (mst_w_strb),
    .slv_w_last_i    (mst_w_last),
    .slv_w_user_i    (mst_w_user),
    .slv_w_valid_i   (mst_w_valid),
    .slv_w_ready_o   (mst_w_ready),
    .slv_b_id_o      (mst_b_id),
    .slv_b_resp_o    (mst_b_resp),
    .slv_b_user_o    (mst_b_user),
    .slv_b_valid_o   (mst_b_valid),
    .slv_b_ready_i   (mst_b_ready),
    .slv_ar_id_i     (mst_ar_id),
    .slv_ar_addr_i   (mst_ar_addr),
    .slv_ar_len_i    (mst_ar_len),
    .slv_ar_size_i   (mst_ar_size),
    .slv_ar_burst_i  (mst_ar_burst),
    .slv_ar_lock_i   (mst_ar_lock),
    .slv_ar_cache_i  (mst_ar_cache),
    .slv_ar_prot_i   (mst_ar_prot),
    .slv_ar_qos_i    (mst_ar_qos),
    .slv_ar_region_i (mst_ar_region),
    .slv_ar_user_i   (mst_ar_user),
    .slv_ar_valid_i  (mst_ar_valid),
    .slv_ar_ready_o  (mst_ar_ready),
    .slv_r_id_o      (mst_r_id),
    .slv_r_data_o    (mst_r_data),
    .slv_r_resp_o    (mst_r_resp),
    .slv_r_last_o    (mst_r_last),
    .slv_r_user_o    (mst_r_user),
    .slv_r_valid_o   (mst_r_valid),
    .slv_r_ready_i   (mst_r_ready),

    .mst_aw_id_o      (mst_aw_id_o),
    .mst_aw_addr_o    (mst_aw_addr_idr),
    .mst_aw_len_o     (mst_aw_len_o),
    .mst_aw_size_o    (mst_aw_size_o),
    .mst_aw_burst_o   (mst_aw_burst_o),
    .mst_aw_lock_o    (mst_aw_lock_o),
    .mst_aw_cache_o   (mst_aw_cache_o),
    .mst_aw_prot_o    (/* overridden */),
    .mst_aw_qos_o     (mst_aw_qos_o),
    .mst_aw_region_o  (/* unused */),
    .mst_aw_atop_o    (/* unused */),
    .mst_aw_user_o    (mst_aw_user_idr),
    .mst_aw_valid_o   (mst_aw_valid_o),
    .mst_aw_ready_i   (mst_aw_ready_i),
    .mst_w_data_o     (mst_w_data_o),
    .mst_w_strb_o     (mst_w_strb_o),
    .mst_w_last_o     (mst_w_last_o),
    .mst_w_user_o      (/* unused */),
    .mst_w_valid_o    (mst_w_valid_o),
    .mst_w_ready_i    (mst_w_ready_i),
    .mst_b_id_i       (mst_b_id_i),
    .mst_b_resp_i     (mst_b_resp_i),
    .mst_b_user_i     ({${uw}{1'b0}}),
    .mst_b_valid_i    (mst_b_valid_i),
    .mst_b_ready_o    (mst_b_ready_o),
    .mst_ar_id_o      (mst_ar_id_o),
    .mst_ar_addr_o    (mst_ar_addr_idr),
    .mst_ar_len_o     (mst_ar_len_o),
    .mst_ar_size_o    (mst_ar_size_o),
    .mst_ar_burst_o   (mst_ar_burst_o),
    .mst_ar_lock_o    (mst_ar_lock_o),
    .mst_ar_cache_o   (mst_ar_cache_o),
    .mst_ar_prot_o    (/* overridden */),
    .mst_ar_qos_o     (mst_ar_qos_o),
    .mst_ar_region_o  (/* unused */),
    .mst_ar_user_o    (mst_ar_user_idr),
    .mst_ar_valid_o   (mst_ar_valid_o),
    .mst_ar_ready_i   (mst_ar_ready_i),
    .mst_r_id_i       (mst_r_id_i),
    .mst_r_data_i     (mst_r_data_i),
    .mst_r_resp_i     (mst_r_resp_i),
    .mst_r_last_i     (mst_r_last_i),
    .mst_r_user_i     ({${uw}{1'b0}}),
    .mst_r_valid_i    (mst_r_valid_i),
    .mst_r_ready_o    (mst_r_ready_o)
  );
  assign mst_aw_addr_o = mst_aw_addr_idr[${aw_pl2ps-1}:0];
  assign mst_ar_addr_o = mst_ar_addr_idr[${aw_pl2ps-1}:0];
  % if uw_pl2ps > 1:
  assign mst_aw_user_o = mst_aw_user_idr[${uw_pl2ps-1}:0];
  assign mst_ar_user_o = mst_ar_user_idr[${uw_pl2ps-1}:0];
  % else:
  assign mst_aw_user_o = mst_aw_user_idr[0];
  assign mst_ar_user_o = mst_ar_user_idr[0];
  % endif
  assign mst_aw_prot_o = 3'b010;
  assign mst_ar_prot_o = 3'b010;

  axi_iw_converter_flat #(
    .AXI_SLV_PORT_ID_WIDTH        (${iw_ps2pl}),
    .AXI_MST_PORT_ID_WIDTH        (${iw}),
    .AXI_SLV_PORT_MAX_UNIQ_IDS    (4),
    .AXI_SLV_PORT_MAX_TXNS_PER_ID (1),
    .AXI_SLV_PORT_MAX_TXNS        (4),
    .AXI_MST_PORT_MAX_UNIQ_IDS    (4),
    .AXI_MST_PORT_MAX_TXNS_PER_ID (1),
    .AXI_ADDR_WIDTH               (${aw}),
    .AXI_DATA_WIDTH               (${dw}),
    .AXI_USER_WIDTH               (${uw})
  ) i_iw_converter_slv (
    .clk_i           (clk_i),
    .rst_ni          (rst_ni),

    .slv_aw_id_i     (slv_aw_id_i),
    .slv_aw_addr_i   ({{${aw-aw_ps2pl}{1'b0}}, slv_aw_addr_i}),
    .slv_aw_len_i    (slv_aw_len_i),
    .slv_aw_size_i   (slv_aw_size_i),
    .slv_aw_burst_i  (slv_aw_burst_i),
    .slv_aw_lock_i   (slv_aw_lock_i),
    .slv_aw_cache_i  (slv_aw_cache_i),
    .slv_aw_prot_i   (slv_aw_prot_i),
    .slv_aw_qos_i    (slv_aw_qos_i),
    .slv_aw_region_i ({4{1'b0}}),
    .slv_aw_atop_i   ({6{1'b0}}),
    .slv_aw_user_i   (slv_aw_user_i[${uw-1}:0]),
    .slv_aw_valid_i  (slv_aw_valid_i),
    .slv_aw_ready_o  (slv_aw_ready_o),
    .slv_w_data_i    (slv_w_data_i),
    .slv_w_strb_i    (slv_w_strb_i),
    .slv_w_last_i    (slv_w_last_i),
    .slv_w_user_i    ({${uw}{1'b0}}),
    .slv_w_valid_i   (slv_w_valid_i),
    .slv_w_ready_o   (slv_w_ready_o),
    .slv_b_id_o      (slv_b_id_o),
    .slv_b_resp_o    (slv_b_resp_o),
    .slv_b_user_o    (/* unused */),
    .slv_b_valid_o   (slv_b_valid_o),
    .slv_b_ready_i   (slv_b_ready_i),
    .slv_ar_id_i     (slv_ar_id_i),
    .slv_ar_addr_i   ({{${aw-aw_ps2pl}{1'b0}}, slv_ar_addr_i}),
    .slv_ar_len_i    (slv_ar_len_i),
    .slv_ar_size_i   (slv_ar_size_i),
    .slv_ar_burst_i  (slv_ar_burst_i),
    .slv_ar_lock_i   (slv_ar_lock_i),
    .slv_ar_cache_i  (slv_ar_cache_i),
    .slv_ar_prot_i   (slv_ar_prot_i),
    .slv_ar_qos_i    (slv_ar_qos_i),
    .slv_ar_region_i ({4{1'b0}}),
    .slv_ar_user_i   (slv_ar_user_i[${uw-1}:0]),
    .slv_ar_valid_i  (slv_ar_valid_i),
    .slv_ar_ready_o  (slv_ar_ready_o),
    .slv_r_id_o      (slv_r_id_o),
    .slv_r_data_o    (slv_r_data_o),
    .slv_r_resp_o    (slv_r_resp_o),
    .slv_r_last_o    (slv_r_last_o),
    .slv_r_user_o    (/* unused */),
    .slv_r_valid_o   (slv_r_valid_o),
    .slv_r_ready_i   (slv_r_ready_i),

    .mst_aw_id_o      (slv_aw_id),
    .mst_aw_addr_o    (slv_aw_addr),
    .mst_aw_len_o     (slv_aw_len),
    .mst_aw_size_o    (slv_aw_size),
    .mst_aw_burst_o   (slv_aw_burst),
    .mst_aw_lock_o    (slv_aw_lock),
    .mst_aw_cache_o   (slv_aw_cache),
    .mst_aw_prot_o    (slv_aw_prot),
    .mst_aw_qos_o     (slv_aw_qos),
    .mst_aw_region_o  (slv_aw_region),
    .mst_aw_atop_o    (slv_aw_atop),
    .mst_aw_user_o    (slv_aw_user),
    .mst_aw_valid_o   (slv_aw_valid),
    .mst_aw_ready_i   (slv_aw_ready),
    .mst_w_data_o     (slv_w_data),
    .mst_w_strb_o     (slv_w_strb),
    .mst_w_last_o     (slv_w_last),
    .mst_w_user_o     (slv_w_user),
    .mst_w_valid_o    (slv_w_valid),
    .mst_w_ready_i    (slv_w_ready),
    .mst_b_id_i       (slv_b_id),
    .mst_b_resp_i     (slv_b_resp),
    .mst_b_user_i     (slv_b_user),
    .mst_b_valid_i    (slv_b_valid),
    .mst_b_ready_o    (slv_b_ready),
    .mst_ar_id_o      (slv_ar_id),
    .mst_ar_addr_o    (slv_ar_addr),
    .mst_ar_len_o     (slv_ar_len),
    .mst_ar_size_o    (slv_ar_size),
    .mst_ar_burst_o   (slv_ar_burst),
    .mst_ar_lock_o    (slv_ar_lock),
    .mst_ar_cache_o   (slv_ar_cache),
    .mst_ar_prot_o    (slv_ar_prot),
    .mst_ar_qos_o     (slv_ar_qos),
    .mst_ar_region_o  (slv_ar_region),
    .mst_ar_user_o    (slv_ar_user),
    .mst_ar_valid_o   (slv_ar_valid),
    .mst_ar_ready_i   (slv_ar_ready),
    .mst_r_id_i       (slv_r_id),
    .mst_r_data_i     (slv_r_data),
    .mst_r_resp_i     (slv_r_resp),
    .mst_r_last_i     (slv_r_last),
    .mst_r_user_i     (slv_r_user),
    .mst_r_valid_i    (slv_r_valid),
    .mst_r_ready_o    (slv_r_ready)
  );

endmodule
