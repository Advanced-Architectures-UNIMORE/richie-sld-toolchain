
/*
 *
 * pulp_cluster_hwpe_pkg.sv
 *
 * Author: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Configuration package for HWPE module
 * This package has to be included in the 'pulp_cluster_cfg_pkg' configuration package
 * for PULP cluster OOC stub. Here are collected the HWPE design features that need to be
 * shared with the higher-level (with respect to the HWPE module) hardware modules
 * of the PULP system.
 *
 */
package automatic pulp_cluster_hwpe_pkg;
  localparam bit          HWPE_PRESENT = 1'b1;
  localparam int unsigned N_HWPE_PORTS = 2;
endpackage