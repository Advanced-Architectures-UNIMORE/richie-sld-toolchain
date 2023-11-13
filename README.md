# GenOv

## Introduction
### Description
**GenOv** is a set of Python-based tools that automate and streamline the design, testing and implementation of *Accelerator-Rich Systems-on-Chip (SoCs)* leveraging clusters of *application-specific accelerators* and [RISC-V](https://riscv.org/) processors.

The SoC architecture is based on the [Parallel Ultra Low Power (PULP) Platform](https://pulp-platform.org/index.html), an open-source research and development platform targeting highly parallel architectures for ultra-low-power processing.

Both system and accelerator components are generated starting from a high-level description and making use of diverse *accelerator design flows*.

## Getting Started

### Clone the Repository
GenOv can be be cloned using the following command:
```
git clone https://github.com/gbellocchi/genov.git
```

### Richie Environment
Be sure that `HERO_OV_HW_EXPORT` is set to the root of Richie (e.g. `/home/user-name/workspace_user/richie`).

### Python Virtual Environment
GenOv leverages a Python virtual environment in order to manage the tool dependencies. 
The required packages are listed inside `requirements.txt`.
To create the environment and install the required packages, simply run:

```
make py_env_init
```

If new packages are added, the environment can be updated with the command:

```
make py_env_update_reqs
```

### External Sources
GenOv makes use of Git submodules which can be pulled with the following command:

```
make ov_gen_init
```

## System-Level Design
The generation flow initiates from high-level descriptions, which are described below.

GenOv streamlines the system-level design of accelerator-rich SoCs with the:
1) Support of various *accelerator design flows* in order to accomodate a wide range of users and application needs.
2) Generation of the *accelerator interfaces* to facilitate the integration inside the accelerator-rich SoC. These include HW interfaces for data communication and control, as well as SW libraries.
3) Generation of a specialized and optimized *accelerator-rich SoC*.

### Accelerator Design
GenOv supports various *accelerator design flows*, including:

- High-Level Synthesis ([Vitis HLS](https://www.xilinx.com/products/design-tools/vitis/vitis-hls.html))
- [Coarse-Grain Reconfigurable (CGR) Hardware Accelerators](https://mdc-suite.github.io/)
- Manual RTL Design ([PULP-based HWPE Accelerators](https://hwpe-doc.readthedocs.io/en/latest/index.html))

The accelerator interfaces are expected to attain the following requirements:

- Adopt a *streaming-based interface*, e.g. the AMBA® 4 AXI4-Stream Protocol.
- Expose SW-programmed parameters as *simple data ports* or wires, thus with no associated I/O protocol and handshaking signal.

### Definition of the Accelerator Interfaces
This phase mandates the user to provide an *accelerator specification file* describing the characteristics of the accelerator interface.

Specifications must be collected in the accelerator library (`src/accelerators/`), where are also provided preliminary examples. The best practice is to create a new library element (directory) comprising the following sections:

1.  `specs/` - This location contains the Python specification file `acc_specs.py`. The latter embodies the required information to specialize the interface between the accelerator wrapper and the integrated engine, as well as additional features.
2.  `rtl/` - This location contains the RTL components of the devised accelerator.
3.  `sw/` - This location comprises optional SW components for the testing phase, which will be included in the final project.

### Specialization of the Accelerator-Rich SoC
Similarly, this phase mandates a *platform specification file* with the SoC characteristics.

This must be collected in the platform library (`src/overlays/`), including the following sections:

1.  `specs/` - The Python specification file is named `ov_specs.py`. This specification tells the tool how to perform the system-level integration of application-specific accelerators, as well as how to specialize platform resources.

## Generation of the Accelerator-Rich SoC
Once the user has completed the previous steps, the generation is accomplished through the command `make clean all`. 

Additionally, add the following arguments:

- **TARGET_OV**: This is to specify the target platform to generate. For example,  `make clean all TARGET_OV=my-SoC` is run to generate the target `my-SoC` under `src/overlays/my-SoC/specs`.

The generated components will then be available under `output`.

## References
- ["A RISC-V-based FPGA overlay to simplify embedded accelerator deployment"](https://ieeexplore.ieee.org/abstract/document/9556494/?casa_token=eQxOEiJ9G6UAAAAA:FhXX0yJ1b-HtSKsBpagLfMpZza6tcSZEnE52bzMrW6SyI3faMhaup9YWZiw4c1UVxDIG6aw6XHA)
- ["PULP: A parallel ultra low power platform for next generation IoT applications"](https://scholar.google.it/citations?view_op=view_citation&hl=it&user=FOkQ6qMAAAAJ&authuser=1&citation_for_view=FOkQ6qMAAAAJ:Tiz5es2fbqcC)
- ["XNOR neural engine: A hardware accelerator IP for 21.6-fJ/op binary neural network inference"](https://ieeexplore.ieee.org/abstract/document/8412533/?casa_token=vEY8znrnveIAAAAA:N1QeKHrymiiwC3_nyMowazTYrn6Oar5UBZHXvM8TnaPz3GHoUsfZyCy91n0V5PIe1mhABq-Fhkg)
- ["Hardware Processing Engines Documentation"](https://hwpe-doc.readthedocs.io/en/latest/index.html)
  
## Useful Repositories
- The [PULP platform](https://github.com/pulp-platform) repository includes components that GenOv leverages to design its accelerator interfaces:
	- [Hardware Processing Engine - Streamer](https://github.com/pulp-platform/hwpe-stream)
	- [Hardware Processing Engine - Controller](https://github.com/pulp-platform/hwpe-ctrl)
	- [Hardware Processing Engine - MAC engine example](https://github.com/pulp-platform/hwpe-mac-engine)
	- [Hardware Processing Engine - Standalone testbench](https://github.com/pulp-platform/hwpe-tb)
-  The generation flow leverages the [Mako Templates](https://www.makotemplates.org/).

## Contacts
**Gianluca Bellocchi**
* E-mail: <gianluca.bellocchi@unimore.it>