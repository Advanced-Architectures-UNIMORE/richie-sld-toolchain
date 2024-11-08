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

    Description:    Wrapper of the PULP cluster for OOC synthesis.

    Date:           13.1.2022

    Author: 	      Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

/*
 * Copyright (c) 2019 ETH Zurich, University of Bologna.
 * All rights reserved.
 *
 * This code is under development and not yet released to the public.
 * Until it is released, the code is under the copyright of ETH Zurich and
 * the University of Bologna, and may contain confidential and/or unpublished
 * work. Any reuse/redistribution is strictly forbidden without written
 * permission from ETH Zurich.
 *
 * Description: Wrapper of the PULP cluster for OOC synthesis.
 *
 * Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: pulp_cluster_ooc.sv
 *
 */

module pulp_cluster_ooc (
  input  logic                              clk_i,
  input  logic                              rst_ni,
  input  logic                              ref_clk_i,
  input  hesoc_cfg_pkg::cluster_id_t cluster_id_i,
  input  logic                              fetch_en_i,
  output logic                              eoc_o,
  output logic                              busy_o,

  // Slave Port
  // AW
  input  hesoc_cfg_pkg::addr_t                slv_aw_addr_i,
  input  axi_pkg::prot_t                    slv_aw_prot_i,
  input  axi_pkg::region_t                  slv_aw_region_i,
  input  axi_pkg::len_t                     slv_aw_len_i,
  input  axi_pkg::size_t                    slv_aw_size_i,
  input  axi_pkg::burst_t                   slv_aw_burst_i,
  input  logic                              slv_aw_lock_i,
  input  axi_pkg::atop_t                    slv_aw_atop_i,
  input  axi_pkg::cache_t                   slv_aw_cache_i,
  input  axi_pkg::qos_t                     slv_aw_qos_i,
  input  hesoc_cfg_pkg::id_slv_t              slv_aw_id_i,
  input  hesoc_cfg_pkg::user_t                slv_aw_user_i,
  // used if ASYNC_INTF
  input  hesoc_cfg_pkg::dc_buf_t              slv_aw_writetoken_i,
  output hesoc_cfg_pkg::dc_buf_t              slv_aw_readpointer_o,
  // used if !ASYNC_INTF
  input  logic                              slv_aw_valid_i,
  output logic                              slv_aw_ready_o,
  // AR
  input  hesoc_cfg_pkg::addr_t                slv_ar_addr_i,
  input  axi_pkg::prot_t                    slv_ar_prot_i,
  input  axi_pkg::region_t                  slv_ar_region_i,
  input  axi_pkg::len_t                     slv_ar_len_i,
  input  axi_pkg::size_t                    slv_ar_size_i,
  input  axi_pkg::burst_t                   slv_ar_burst_i,
  input  logic                              slv_ar_lock_i,
  input  axi_pkg::cache_t                   slv_ar_cache_i,
  input  axi_pkg::qos_t                     slv_ar_qos_i,
  input  hesoc_cfg_pkg::id_slv_t              slv_ar_id_i,
  input  hesoc_cfg_pkg::user_t                slv_ar_user_i,
  // used if ASYNC_INTF
  input  hesoc_cfg_pkg::dc_buf_t              slv_ar_writetoken_i,
  output hesoc_cfg_pkg::dc_buf_t              slv_ar_readpointer_o,
  // used if !ASYNC_INTF
  input  logic                              slv_ar_valid_i,
  output logic                              slv_ar_ready_o,
  // W
  input  hesoc_cfg_pkg::data_t                slv_w_data_i,
  input  hesoc_cfg_pkg::strb_t                slv_w_strb_i,
  input  hesoc_cfg_pkg::user_t                slv_w_user_i,
  input  logic                              slv_w_last_i,
  // used if ASYNC_INTF
  input  hesoc_cfg_pkg::dc_buf_t              slv_w_writetoken_i,
  output hesoc_cfg_pkg::dc_buf_t              slv_w_readpointer_o,
  // used if !ASYNC_INTF
  input  logic                              slv_w_valid_i,
  output logic                              slv_w_ready_o,
  // R
  output hesoc_cfg_pkg::data_t                slv_r_data_o,
  output axi_pkg::resp_t                    slv_r_resp_o,
  output logic                              slv_r_last_o,
  output hesoc_cfg_pkg::id_slv_t              slv_r_id_o,
  output hesoc_cfg_pkg::user_t                slv_r_user_o,
  // used if ASYNC_INTF
  output hesoc_cfg_pkg::dc_buf_t              slv_r_writetoken_o,
  input  hesoc_cfg_pkg::dc_buf_t              slv_r_readpointer_i,
  // used if !ASYNC_INTF
  output logic                              slv_r_valid_o,
  input  logic                              slv_r_ready_i,
  // B
  output axi_pkg::resp_t                    slv_b_resp_o,
  output hesoc_cfg_pkg::id_slv_t              slv_b_id_o,
  output hesoc_cfg_pkg::user_t                slv_b_user_o,
  // used if ASYNC_INTF
  output hesoc_cfg_pkg::dc_buf_t              slv_b_writetoken_o,
  input  hesoc_cfg_pkg::dc_buf_t              slv_b_readpointer_i,
  // used if !ASYNC_INTF
  output logic                              slv_b_valid_o,
  input  logic                              slv_b_ready_i,

  // Master Port
  // AW
  output hesoc_cfg_pkg::addr_t                mst_aw_addr_o,
  output axi_pkg::prot_t                    mst_aw_prot_o,
  output axi_pkg::region_t                  mst_aw_region_o,
  output axi_pkg::len_t                     mst_aw_len_o,
  output axi_pkg::size_t                    mst_aw_size_o,
  output axi_pkg::burst_t                   mst_aw_burst_o,
  output logic                              mst_aw_lock_o,
  output axi_pkg::atop_t                    mst_aw_atop_o,
  output axi_pkg::cache_t                   mst_aw_cache_o,
  output axi_pkg::qos_t                     mst_aw_qos_o,
  output hesoc_cfg_pkg::id_mst_t              mst_aw_id_o,
  output hesoc_cfg_pkg::user_t                mst_aw_user_o,
  // used if ASYNC_INTF
  output hesoc_cfg_pkg::dc_buf_t              mst_aw_writetoken_o,
  input  hesoc_cfg_pkg::dc_buf_t              mst_aw_readpointer_i,
  // used if !ASYNC_INTF
  output logic                              mst_aw_valid_o,
  input  logic                              mst_aw_ready_i,
  // AR
  output hesoc_cfg_pkg::addr_t                mst_ar_addr_o,
  output axi_pkg::prot_t                    mst_ar_prot_o,
  output axi_pkg::region_t                  mst_ar_region_o,
  output axi_pkg::len_t                     mst_ar_len_o,
  output axi_pkg::size_t                    mst_ar_size_o,
  output axi_pkg::burst_t                   mst_ar_burst_o,
  output logic                              mst_ar_lock_o,
  output axi_pkg::cache_t                   mst_ar_cache_o,
  output axi_pkg::qos_t                     mst_ar_qos_o,
  output hesoc_cfg_pkg::id_mst_t              mst_ar_id_o,
  output hesoc_cfg_pkg::user_t                mst_ar_user_o,
  // used if ASYNC_INTF
  output hesoc_cfg_pkg::dc_buf_t              mst_ar_writetoken_o,
  input  hesoc_cfg_pkg::dc_buf_t              mst_ar_readpointer_i,
  // used if !ASYNC_INTF
  output logic                              mst_ar_valid_o,
  input  logic                              mst_ar_ready_i,
  // W
  output hesoc_cfg_pkg::data_t                mst_w_data_o,
  output hesoc_cfg_pkg::strb_t                mst_w_strb_o,
  output hesoc_cfg_pkg::user_t                mst_w_user_o,
  output logic                              mst_w_last_o,
  // used if ASYNC_INTF
  output hesoc_cfg_pkg::dc_buf_t              mst_w_writetoken_o,
  input  hesoc_cfg_pkg::dc_buf_t              mst_w_readpointer_i,
  // used if !ASYNC_INTF
  output logic                              mst_w_valid_o,
  input  logic                              mst_w_ready_i,
  // R
  input  hesoc_cfg_pkg::data_t                mst_r_data_i,
  input  axi_pkg::resp_t                    mst_r_resp_i,
  input  logic                              mst_r_last_i,
  input  hesoc_cfg_pkg::id_mst_t              mst_r_id_i,
  input  hesoc_cfg_pkg::user_t                mst_r_user_i,
  // used if ASYNC_INTF
  input  hesoc_cfg_pkg::dc_buf_t              mst_r_writetoken_i,
  output hesoc_cfg_pkg::dc_buf_t              mst_r_readpointer_o,
  // used if !ASYNC_INTF
  input  logic                              mst_r_valid_i,
  output logic                              mst_r_ready_o,
  // B
  input  axi_pkg::resp_t                    mst_b_resp_i,
  input  hesoc_cfg_pkg::id_mst_t              mst_b_id_i,
  input  hesoc_cfg_pkg::user_t                mst_b_user_i,
  // used if ASYNC_INTF
  input  hesoc_cfg_pkg::dc_buf_t              mst_b_writetoken_i,
  output hesoc_cfg_pkg::dc_buf_t              mst_b_readpointer_o,
  // used if !ASYNC_INTF
  input  logic                              mst_b_valid_i,
  output logic                              mst_b_ready_o
);

  pulp_cluster #(
    .ASYNC_INTF               (hesoc_cfg_pkg::ASYNC),
    .NB_CORES                 (pulp_cluster_${cl_id}_cfg_pkg::N_CORES),
    .NB_DMAS                  (pulp_cluster_${cl_id}_cfg_pkg::N_DMAS),
    .CLUSTER_ALIAS            (1'b1),
    .CLUSTER_ALIAS_BASE       (12'h1B0),
    .TCDM_SIZE                (pulp_cluster_${cl_id}_cfg_pkg::TCDM_SIZE),
    .NB_TCDM_BANKS            (pulp_cluster_${cl_id}_cfg_pkg::N_TCDM_BANKS),
    // HWPE - LIC interconnect
    ${inst_param_hwpe_lic_region()}\
    ${inst_param_hwpe_lic_interface()}\
    // HWPE - HCI interconnect
    ${inst_param_hwpe_hci_region()}\
    ${inst_param_hwpe_hci_interface()}\
    // I$ Parameters
    .NB_CACHE_BANKS           (4),
    .CACHE_SIZE               (pulp_cluster_${cl_id}_cfg_pkg::ICACHE_SIZE),
    .L2_SIZE                  (hesoc_cfg_pkg::L2_SIZE),
    // Core Parameters
    .DEM_PER_BEFORE_TCDM_TS   (1'b0),
    .ROM_BOOT_ADDR            (32'h1A00_0000),
    .BOOT_ADDR                (32'h1C00_0080),
    // AXI Parameters
    .AXI_ADDR_WIDTH           (hesoc_cfg_pkg::AXI_AW),
    .AXI_DATA_C2S_WIDTH       (hesoc_cfg_pkg::AXI_DW),
    .AXI_DATA_S2C_WIDTH       (hesoc_cfg_pkg::AXI_DW),
    .AXI_USER_WIDTH           (hesoc_cfg_pkg::AXI_UW),
    .AXI_ID_IN_WIDTH          (hesoc_cfg_pkg::AXI_IW_SLV),
    .AXI_ID_OUT_WIDTH         (hesoc_cfg_pkg::AXI_IW_MST),
    .DC_SLICE_BUFFER_WIDTH    (hesoc_cfg_pkg::DC_BUF_W),
    // TCDM and Interconnect Parameters
    .DATA_WIDTH               (32),
    .ADDR_WIDTH               (32),
    .TEST_SET_BIT             (20),
    .L1_AMO_PRESENT           (pulp_cluster_${cl_id}_cfg_pkg::L1_AMO_PRESENT),
    // DMA Parameters
    .NB_OUTSND_BURSTS         (pulp_cluster_${cl_id}_cfg_pkg::DMA_MAX_N_TXNS),
    .NB_DMA_STREAMS           (pulp_cluster_${cl_id}_cfg_pkg::DMA_STREAMS),
    .FIFO_DEPTH_DMA_REQ       (pulp_cluster_${cl_id}_cfg_pkg::DMA_FIFO_DEPTH_REQ),
    // peripheral and periph interconnect parameters
    .NB_SPERIPHS              (pulp_cluster_${cl_id}_cfg_pkg::N_SPERIPHS),
    .NB_SPERIPHS_HWPE         (pulp_cluster_${cl_id}_cfg_pkg::N_SPERIPHS_HWPE)
  ) i_bound (
    .clk_i,
    .rst_ni,
    .ref_clk_i,

    .pmu_mem_pwdn_i               (1'b0),
    .base_addr_i                  ('0),
    .test_mode_i                  ('0),
    .en_sa_boot_i                 ('0),

    .cluster_id_i,

    .fetch_en_i,
    .eoc_o,
    .busy_o,

    .ext_events_writetoken_i      ('0),
    .ext_events_readpointer_o     (),
    .ext_events_dataasync_i       ('0),
    .dma_pe_evt_ack_i             ('0),
    .dma_pe_evt_valid_o           (),
    .dma_pe_irq_ack_i             ('0),
    .dma_pe_irq_valid_o           (),
    .pf_evt_ack_i                 ('0),
    .pf_evt_valid_o               (),

    .data_slave_aw_addr_i         (slv_aw_addr_i),
    .data_slave_aw_prot_i         (slv_aw_prot_i),
    .data_slave_aw_region_i       (slv_aw_region_i),
    .data_slave_aw_len_i          (slv_aw_len_i),
    .data_slave_aw_size_i         (slv_aw_size_i),
    .data_slave_aw_burst_i        (slv_aw_burst_i),
    .data_slave_aw_lock_i         (slv_aw_lock_i),
    .data_slave_aw_atop_i         (slv_aw_atop_i),
    .data_slave_aw_cache_i        (slv_aw_cache_i),
    .data_slave_aw_qos_i          (slv_aw_qos_i),
    .data_slave_aw_id_i           (slv_aw_id_i),
    .data_slave_aw_user_i         (slv_aw_user_i),
    .data_slave_aw_writetoken_i   (slv_aw_writetoken_i),
    .data_slave_aw_readpointer_o  (slv_aw_readpointer_o),
    .data_slave_aw_valid_i        (slv_aw_valid_i),
    .data_slave_aw_ready_o        (slv_aw_ready_o),
    .data_slave_ar_addr_i         (slv_ar_addr_i),
    .data_slave_ar_prot_i         (slv_ar_prot_i),
    .data_slave_ar_region_i       (slv_ar_region_i),
    .data_slave_ar_len_i          (slv_ar_len_i),
    .data_slave_ar_size_i         (slv_ar_size_i),
    .data_slave_ar_burst_i        (slv_ar_burst_i),
    .data_slave_ar_lock_i         (slv_ar_lock_i),
    .data_slave_ar_cache_i        (slv_ar_cache_i),
    .data_slave_ar_qos_i          (slv_ar_qos_i),
    .data_slave_ar_id_i           (slv_ar_id_i),
    .data_slave_ar_user_i         (slv_ar_user_i),
    .data_slave_ar_writetoken_i   (slv_ar_writetoken_i),
    .data_slave_ar_readpointer_o  (slv_ar_readpointer_o),
    .data_slave_ar_valid_i        (slv_ar_valid_i),
    .data_slave_ar_ready_o        (slv_ar_ready_o),
    .data_slave_w_data_i          (slv_w_data_i),
    .data_slave_w_strb_i          (slv_w_strb_i),
    .data_slave_w_user_i          (slv_w_user_i),
    .data_slave_w_last_i          (slv_w_last_i),
    .data_slave_w_writetoken_i    (slv_w_writetoken_i),
    .data_slave_w_readpointer_o   (slv_w_readpointer_o),
    .data_slave_w_valid_i         (slv_w_valid_i),
    .data_slave_w_ready_o         (slv_w_ready_o),
    .data_slave_r_data_o          (slv_r_data_o),
    .data_slave_r_resp_o          (slv_r_resp_o),
    .data_slave_r_last_o          (slv_r_last_o),
    .data_slave_r_id_o            (slv_r_id_o),
    .data_slave_r_user_o          (slv_r_user_o),
    .data_slave_r_writetoken_o    (slv_r_writetoken_o),
    .data_slave_r_readpointer_i   (slv_r_readpointer_i),
    .data_slave_r_valid_o         (slv_r_valid_o),
    .data_slave_r_ready_i         (slv_r_ready_i),
    .data_slave_b_resp_o          (slv_b_resp_o),
    .data_slave_b_id_o            (slv_b_id_o),
    .data_slave_b_user_o          (slv_b_user_o),
    .data_slave_b_writetoken_o    (slv_b_writetoken_o),
    .data_slave_b_readpointer_i   (slv_b_readpointer_i),
    .data_slave_b_valid_o         (slv_b_valid_o),
    .data_slave_b_ready_i         (slv_b_ready_i),

    .data_master_aw_addr_o        (mst_aw_addr_o),
    .data_master_aw_prot_o        (mst_aw_prot_o),
    .data_master_aw_region_o      (mst_aw_region_o),
    .data_master_aw_len_o         (mst_aw_len_o),
    .data_master_aw_size_o        (mst_aw_size_o),
    .data_master_aw_burst_o       (mst_aw_burst_o),
    .data_master_aw_lock_o        (mst_aw_lock_o),
    .data_master_aw_atop_o        (mst_aw_atop_o),
    .data_master_aw_cache_o       (),
    .data_master_aw_qos_o         (mst_aw_qos_o),
    .data_master_aw_id_o          (mst_aw_id_o),
    .data_master_aw_user_o        (mst_aw_user_o),
    .data_master_aw_writetoken_o  (mst_aw_writetoken_o),
    .data_master_aw_readpointer_i (mst_aw_readpointer_i),
    .data_master_aw_valid_o       (mst_aw_valid_o),
    .data_master_aw_ready_i       (mst_aw_ready_i),
    .data_master_ar_addr_o        (mst_ar_addr_o),
    .data_master_ar_prot_o        (mst_ar_prot_o),
    .data_master_ar_region_o      (mst_ar_region_o),
    .data_master_ar_len_o         (mst_ar_len_o),
    .data_master_ar_size_o        (mst_ar_size_o),
    .data_master_ar_burst_o       (mst_ar_burst_o),
    .data_master_ar_lock_o        (mst_ar_lock_o),
    .data_master_ar_cache_o       (),
    .data_master_ar_qos_o         (mst_ar_qos_o),
    .data_master_ar_id_o          (mst_ar_id_o),
    .data_master_ar_user_o        (mst_ar_user_o),
    .data_master_ar_writetoken_o  (mst_ar_writetoken_o),
    .data_master_ar_readpointer_i (mst_ar_readpointer_i),
    .data_master_ar_valid_o       (mst_ar_valid_o),
    .data_master_ar_ready_i       (mst_ar_ready_i),
    .data_master_w_data_o         (mst_w_data_o),
    .data_master_w_strb_o         (mst_w_strb_o),
    .data_master_w_user_o         (mst_w_user_o),
    .data_master_w_last_o         (mst_w_last_o),
    .data_master_w_writetoken_o   (mst_w_writetoken_o),
    .data_master_w_readpointer_i  (mst_w_readpointer_i),
    .data_master_w_valid_o        (mst_w_valid_o),
    .data_master_w_ready_i        (mst_w_ready_i),
    .data_master_r_data_i         (mst_r_data_i),
    .data_master_r_resp_i         (mst_r_resp_i),
    .data_master_r_last_i         (mst_r_last_i),
    .data_master_r_id_i           (mst_r_id_i),
    .data_master_r_user_i         (mst_r_user_i),
    .data_master_r_writetoken_i   (mst_r_writetoken_i),
    .data_master_r_readpointer_o  (mst_r_readpointer_o),
    .data_master_r_valid_i        (mst_r_valid_i),
    .data_master_r_ready_o        (mst_r_ready_o),
    .data_master_b_resp_i         (mst_b_resp_i),
    .data_master_b_id_i           (mst_b_id_i),
    .data_master_b_user_i         (mst_b_user_i),
    .data_master_b_writetoken_i   (mst_b_writetoken_i),
    .data_master_b_readpointer_o  (mst_b_readpointer_o),
    .data_master_b_valid_i        (mst_b_valid_i),
    .data_master_b_ready_o        (mst_b_ready_o)
  );
  // Make all reads and writes from cluster modifiable.
  // TODO: This might be undesired for transactions from cores to peripherals, better modify the
  // DMA and I$ to issue modifiable transactions.
  assign mst_ar_cache_o = 4'b0010;
  assign mst_aw_cache_o = 4'b0010;

endmodule

// Interface wrapper for OOC-synthesized synchronous PULP cluster
module pulp_cluster_sync (
  input  logic                              clk_i,
  input  logic                              rst_ni,
  input  logic                              ref_clk_i,
  input  hesoc_cfg_pkg::cluster_id_t          cluster_id_i,
  input  logic                              fetch_en_i,
  output logic                              eoc_o,
  output logic                              busy_o,
  AXI_BUS.Slave                             slv,
  AXI_BUS.Master                            mst
);

  pulp_cluster_ooc i_ooc (
    .clk_i,
    .rst_ni,
    .ref_clk_i,
    .cluster_id_i,
    .fetch_en_i,
    .eoc_o,
    .busy_o,

    .slv_aw_addr_i        (slv.aw_addr),
    .slv_aw_prot_i        (slv.aw_prot),
    .slv_aw_region_i      (slv.aw_region),
    .slv_aw_len_i         (slv.aw_len),
    .slv_aw_size_i        (slv.aw_size),
    .slv_aw_burst_i       (slv.aw_burst),
    .slv_aw_lock_i        (slv.aw_lock),
    .slv_aw_atop_i        (slv.aw_atop),
    .slv_aw_cache_i       (slv.aw_cache),
    .slv_aw_qos_i         (slv.aw_qos),
    .slv_aw_id_i          (slv.aw_id),
    .slv_aw_user_i        (slv.aw_user),
    .slv_aw_valid_i       (slv.aw_valid),
    .slv_aw_ready_o       (slv.aw_ready),
    .slv_aw_writetoken_i  (),
    .slv_aw_readpointer_o (),
    .slv_ar_addr_i        (slv.ar_addr),
    .slv_ar_prot_i        (slv.ar_prot),
    .slv_ar_region_i      (slv.ar_region),
    .slv_ar_len_i         (slv.ar_len),
    .slv_ar_size_i        (slv.ar_size),
    .slv_ar_burst_i       (slv.ar_burst),
    .slv_ar_lock_i        (slv.ar_lock),
    .slv_ar_cache_i       (slv.ar_cache),
    .slv_ar_qos_i         (slv.ar_qos),
    .slv_ar_id_i          (slv.ar_id),
    .slv_ar_user_i        (slv.ar_user),
    .slv_ar_valid_i       (slv.ar_valid),
    .slv_ar_ready_o       (slv.ar_ready),
    .slv_ar_writetoken_i  (),
    .slv_ar_readpointer_o (),
    .slv_w_data_i         (slv.w_data),
    .slv_w_strb_i         (slv.w_strb),
    .slv_w_user_i         (slv.w_user),
    .slv_w_last_i         (slv.w_last),
    .slv_w_valid_i        (slv.w_valid),
    .slv_w_ready_o        (slv.w_ready),
    .slv_w_writetoken_i   (),
    .slv_w_readpointer_o  (),
    .slv_r_data_o         (slv.r_data),
    .slv_r_resp_o         (slv.r_resp),
    .slv_r_last_o         (slv.r_last),
    .slv_r_id_o           (slv.r_id),
    .slv_r_user_o         (slv.r_user),
    .slv_r_valid_o        (slv.r_valid),
    .slv_r_ready_i        (slv.r_ready),
    .slv_r_writetoken_o   (),
    .slv_r_readpointer_i  (),
    .slv_b_resp_o         (slv.b_resp),
    .slv_b_id_o           (slv.b_id),
    .slv_b_user_o         (slv.b_user),
    .slv_b_valid_o        (slv.b_valid),
    .slv_b_ready_i        (slv.b_ready),
    .slv_b_writetoken_o   (),
    .slv_b_readpointer_i  (),

    .mst_aw_addr_o        (mst.aw_addr),
    .mst_aw_prot_o        (mst.aw_prot),
    .mst_aw_region_o      (mst.aw_region),
    .mst_aw_len_o         (mst.aw_len),
    .mst_aw_size_o        (mst.aw_size),
    .mst_aw_burst_o       (mst.aw_burst),
    .mst_aw_lock_o        (mst.aw_lock),
    .mst_aw_atop_o        (mst.aw_atop),
    .mst_aw_cache_o       (mst.aw_cache),
    .mst_aw_qos_o         (mst.aw_qos),
    .mst_aw_id_o          (mst.aw_id),
    .mst_aw_user_o        (mst.aw_user),
    .mst_aw_valid_o       (mst.aw_valid),
    .mst_aw_ready_i       (mst.aw_ready),
    .mst_aw_writetoken_o  (),
    .mst_aw_readpointer_i (),
    .mst_ar_addr_o        (mst.ar_addr),
    .mst_ar_prot_o        (mst.ar_prot),
    .mst_ar_region_o      (mst.ar_region),
    .mst_ar_len_o         (mst.ar_len),
    .mst_ar_size_o        (mst.ar_size),
    .mst_ar_burst_o       (mst.ar_burst),
    .mst_ar_lock_o        (mst.ar_lock),
    .mst_ar_cache_o       (mst.ar_cache),
    .mst_ar_qos_o         (mst.ar_qos),
    .mst_ar_id_o          (mst.ar_id),
    .mst_ar_user_o        (mst.ar_user),
    .mst_ar_valid_o       (mst.ar_valid),
    .mst_ar_ready_i       (mst.ar_ready),
    .mst_ar_writetoken_o  (),
    .mst_ar_readpointer_i (),
    .mst_w_data_o         (mst.w_data),
    .mst_w_strb_o         (mst.w_strb),
    .mst_w_user_o         (mst.w_user),
    .mst_w_last_o         (mst.w_last),
    .mst_w_valid_o        (mst.w_valid),
    .mst_w_ready_i        (mst.w_ready),
    .mst_w_writetoken_o   (),
    .mst_w_readpointer_i  (),
    .mst_r_data_i         (mst.r_data),
    .mst_r_resp_i         (mst.r_resp),
    .mst_r_last_i         (mst.r_last),
    .mst_r_id_i           (mst.r_id),
    .mst_r_user_i         (mst.r_user),
    .mst_r_valid_i        (mst.r_valid),
    .mst_r_ready_o        (mst.r_ready),
    .mst_r_writetoken_i   (),
    .mst_r_readpointer_o  (),
    .mst_b_resp_i         (mst.b_resp),
    .mst_b_id_i           (mst.b_id),
    .mst_b_user_i         (mst.b_user),
    .mst_b_valid_i        (mst.b_valid),
    .mst_b_ready_o        (mst.b_ready),
    .mst_b_writetoken_i   (),
    .mst_b_readpointer_o  ()
  );
endmodule

// Interface wrapper for OOC-synthesized asynchronous PULP cluster
module pulp_cluster_async (
  input  logic                              clk_i,
  input  logic                              rst_ni,
  input  logic                              ref_clk_i,
  input  hesoc_cfg_pkg::cluster_id_t          cluster_id_i,
  input  logic                              fetch_en_i,
  output logic                              eoc_o,
  output logic                              busy_o,
  AXI_BUS_ASYNC.Slave                       slv,
  AXI_BUS_ASYNC.Master                      mst
);

  pulp_cluster_ooc i_ooc (
    .clk_i,
    .rst_ni,
    .ref_clk_i,
    .cluster_id_i,
    .fetch_en_i,
    .eoc_o,
    .busy_o,

    .slv_aw_addr_i        (slv.aw_addr),
    .slv_aw_prot_i        (slv.aw_prot),
    .slv_aw_region_i      (slv.aw_region),
    .slv_aw_len_i         (slv.aw_len),
    .slv_aw_size_i        (slv.aw_size),
    .slv_aw_burst_i       (slv.aw_burst),
    .slv_aw_lock_i        (slv.aw_lock),
    .slv_aw_atop_i        (slv.aw_atop),
    .slv_aw_cache_i       (slv.aw_cache),
    .slv_aw_qos_i         (slv.aw_qos),
    .slv_aw_id_i          (slv.aw_id),
    .slv_aw_user_i        (slv.aw_user),
    .slv_aw_valid_i       (),
    .slv_aw_ready_o       (),
    .slv_aw_writetoken_i  (slv.aw_writetoken),
    .slv_aw_readpointer_o (slv.aw_readpointer),
    .slv_ar_addr_i        (slv.ar_addr),
    .slv_ar_prot_i        (slv.ar_prot),
    .slv_ar_region_i      (slv.ar_region),
    .slv_ar_len_i         (slv.ar_len),
    .slv_ar_size_i        (slv.ar_size),
    .slv_ar_burst_i       (slv.ar_burst),
    .slv_ar_lock_i        (slv.ar_lock),
    .slv_ar_cache_i       (slv.ar_cache),
    .slv_ar_qos_i         (slv.ar_qos),
    .slv_ar_id_i          (slv.ar_id),
    .slv_ar_user_i        (slv.ar_user),
    .slv_ar_valid_i       (),
    .slv_ar_ready_o       (),
    .slv_ar_writetoken_i  (slv.ar_writetoken),
    .slv_ar_readpointer_o (slv.ar_readpointer),
    .slv_w_data_i         (slv.w_data),
    .slv_w_strb_i         (slv.w_strb),
    .slv_w_user_i         (slv.w_user),
    .slv_w_last_i         (slv.w_last),
    .slv_w_valid_i        (),
    .slv_w_ready_o        (),
    .slv_w_writetoken_i   (slv.w_writetoken),
    .slv_w_readpointer_o  (slv.w_readpointer),
    .slv_r_data_o         (slv.r_data),
    .slv_r_resp_o         (slv.r_resp),
    .slv_r_last_o         (slv.r_last),
    .slv_r_id_o           (slv.r_id),
    .slv_r_user_o         (slv.r_user),
    .slv_r_valid_o        (),
    .slv_r_ready_i        (),
    .slv_r_writetoken_o   (slv.r_writetoken),
    .slv_r_readpointer_i  (slv.r_readpointer),
    .slv_b_resp_o         (slv.b_resp),
    .slv_b_id_o           (slv.b_id),
    .slv_b_user_o         (slv.b_user),
    .slv_b_valid_o        (),
    .slv_b_ready_i        (),
    .slv_b_writetoken_o   (slv.b_writetoken),
    .slv_b_readpointer_i  (slv.b_readpointer),

    .mst_aw_addr_o        (mst.aw_addr),
    .mst_aw_prot_o        (mst.aw_prot),
    .mst_aw_region_o      (mst.aw_region),
    .mst_aw_len_o         (mst.aw_len),
    .mst_aw_size_o        (mst.aw_size),
    .mst_aw_burst_o       (mst.aw_burst),
    .mst_aw_lock_o        (mst.aw_lock),
    .mst_aw_atop_o        (mst.aw_atop),
    .mst_aw_cache_o       (mst.aw_cache),
    .mst_aw_qos_o         (mst.aw_qos),
    .mst_aw_id_o          (mst.aw_id),
    .mst_aw_user_o        (mst.aw_user),
    .mst_aw_valid_o       (),
    .mst_aw_ready_i       (),
    .mst_aw_writetoken_o  (mst.aw_writetoken),
    .mst_aw_readpointer_i (mst.aw_readpointer),
    .mst_ar_addr_o        (mst.ar_addr),
    .mst_ar_prot_o        (mst.ar_prot),
    .mst_ar_region_o      (mst.ar_region),
    .mst_ar_len_o         (mst.ar_len),
    .mst_ar_size_o        (mst.ar_size),
    .mst_ar_burst_o       (mst.ar_burst),
    .mst_ar_lock_o        (mst.ar_lock),
    .mst_ar_cache_o       (mst.ar_cache),
    .mst_ar_qos_o         (mst.ar_qos),
    .mst_ar_id_o          (mst.ar_id),
    .mst_ar_user_o        (mst.ar_user),
    .mst_ar_valid_o       (),
    .mst_ar_ready_i       (),
    .mst_ar_writetoken_o  (mst.ar_writetoken),
    .mst_ar_readpointer_i (mst.ar_readpointer),
    .mst_w_data_o         (mst.w_data),
    .mst_w_strb_o         (mst.w_strb),
    .mst_w_user_o         (mst.w_user),
    .mst_w_last_o         (mst.w_last),
    .mst_w_valid_o        (),
    .mst_w_ready_i        (),
    .mst_w_writetoken_o   (mst.w_writetoken),
    .mst_w_readpointer_i  (mst.w_readpointer),
    .mst_r_data_i         (mst.r_data),
    .mst_r_resp_i         (mst.r_resp),
    .mst_r_last_i         (mst.r_last),
    .mst_r_id_i           (mst.r_id),
    .mst_r_user_i         (mst.r_user),
    .mst_r_valid_i        (),
    .mst_r_ready_o        (),
    .mst_r_writetoken_i   (mst.r_writetoken),
    .mst_r_readpointer_o  (mst.r_readpointer),
    .mst_b_resp_i         (mst.b_resp),
    .mst_b_id_i           (mst.b_id),
    .mst_b_user_i         (mst.b_user),
    .mst_b_valid_i        (),
    .mst_b_ready_o        (),
    .mst_b_writetoken_i   (mst.b_writetoken),
    .mst_b_readpointer_o  (mst.b_readpointer)
  );
endmodule
