# GenOv: Generation of Accelerator-Rich SoCs

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

### The Richie Environment
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
1) Support of various *accelerator design flows* in order to accomodate a wide range of users and application needs. This phase accomodates the design of the accelerator datapath, meaning the HW implementation of the accelerated functionality (e.g. FFT, MatMul, etc.).
2) Generation of the *accelerator interfaces* to facilitate the integration inside the accelerator-rich SoC. These include HW interfaces for data communication and control, as well as SW libraries.
3) Generation of a specialized and optimized *accelerator-rich SoC*.

### Accelerator Design
GenOv supports various *accelerator design flows*, including:

- High-Level Synthesis ([Vitis HLS](https://www.xilinx.com/products/design-tools/vitis/vitis-hls.html))
- [Coarse-Grain Reconfigurable (CGR) Hardware Accelerators](https://mdc-suite.github.io/)
- Manual RTL Design ([PULP-based HWPE Accelerators](https://hwpe-doc.readthedocs.io/en/latest/index.html))

The IP interface is expected to attain the following requirements:

- Adopt a *streaming-based interface* for data communication, e.g. the AMBA® 4 AXI4-Stream Protocol.
- Adopt *simple data ports* or wires for control parameters, thus with no associated I/O protocol and handshaking signal.

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

### The Generation Flow
GenOv adopts a design automation approach, which can be defined as *template-based*.
Basically:
1) **Platform** and **accelerator specification files** consist of *user-defined parameters*, which are meant to specialize the SoC components;
2) **Templates** consist of marked-up text, which can be potentially *rendered* into various output formats, e.g. HW/SW components, scripts, documentation, etc.
3) The **generation flow** provides parameters to a *rendering engine*, which parses and renders the templates of GenOv. In particular, the latter leverages the [Mako Template Library](https://www.makotemplates.org/).
4) The result consists of a **full-fledged accelerator-rich SoC**, including both *HW/SW components* and ready-to-go *simulation* and *synthesis scripts*.

### How to Run
The generation flow is triggered with a `make clean all`. 

Additionally, add the following arguments:

- **TARGET_OV**: This is to specify the target platform to generate. For example,  `make clean all TARGET_OV=my-SoC` is run to generate the target `my-SoC` under `src/overlays/my-SoC/specs`.

The generated components will then be available under `output`.

## License
GenOv is being made available under permissive open source licenses:
- **Source files**, **tool scripts** and **templates** are released under the `Apache 2.0 license` ([Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)).
- **Generated components** are differently released depending on their specific nature:
	- *Hardware* is released under the `Solderpad 0.51 license` ([SHL-0.51](http://solderpad.org/licenses/SHL-0.51)).
 	- *Software* and *other formats* are released under the `Apache 2.0 license` ([Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)).

## Publications

If you use GenOv in your work, you can cite us:

<details>
<summary><b>A RISC-V-based FPGA overlay to simplify embedded accelerator deployment</b></summary>
<p>

```
@inproceedings{bellocchi2021risc,
  title={A risc-v-based fpga overlay to simplify embedded accelerator deployment},
  author={Bellocchi, Gianluca and Capotondi, Alessandro and Conti, Francesco and Marongiu, Andrea},
  booktitle={2021 24th Euromicro Conference on Digital System Design (DSD)},
  pages={9--17},
  year={2021},
  organization={IEEE}
}
```

</p>
</details>

Other work which can be found in or contributed to this repository:

<details>
<summary><b>XNOR neural engine: A hardware accelerator IP for 21.6-fJ/op binary neural network inference</b></summary>
<p>

```
@article{conti2018xnor,
  title={XNOR neural engine: A hardware accelerator IP for 21.6-fJ/op binary neural network inference},
  author={Conti, Francesco and Schiavone, Pasquale Davide and Benini, Luca},
  journal={IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems},
  volume={37},
  number={11},
  pages={2940--2951},
  year={2018},
  publisher={IEEE}
}
```

</p>
</details>

<details>
<summary><b>HERO: An open-source research platform for HW/SW exploration of heterogeneous manycore systems</b></summary>
<p>

```
@inproceedings{kurth2018hero,
  title={HERO: An open-source research platform for HW/SW exploration of heterogeneous manycore systems},
  author={Kurth, Andreas and Capotondi, Alessandro and Vogel, Pirmin and Benini, Luca and Marongiu, Andrea},
  booktitle={Proceedings of the 2nd Workshop on AutotuniNg and aDaptivity AppRoaches for Energy efficient HPC Systems},
  pages={1--6},
  year={2018}
}
```

</p>
</details>

<details>
<summary><b>PULP: A parallel ultra low power platform for next generation IoT applications</b></summary>
<p>

```
@inproceedings{rossi2015pulp,
  title={PULP: A parallel ultra low power platform for next generation IoT applications},
  author={Rossi, Davide and Conti, Francesco and Marongiu, Andrea and Pullini, Antonio and Loi, Igor and Gautschi, Michael and Tagliavini, Giuseppe and Capotondi, Alessandro and Flatresse, Philippe and Benini, Luca},
  booktitle={2015 IEEE Hot Chips 27 Symposium (HCS)},
  pages={1--39},
  year={2015},
  organization={IEEE Computer Society}
}
```

</p>
</details>
  
## Useful Repositories

### AMD-Xilinx Open Hardware Competition 2023
GenOv has been proposed in the 2023 edition of the AMD-Xilinx Open Hardware Competition. 
```
Spoiler...
																																												...We have not won! :-) 
```
Yet, we have released a [tutorial](https://github.com/gbellocchi/xil_open_hw_23) to help you familiarize yourself with our work.

### The HWPE Accelerator Interface
The [PULP platform](https://github.com/pulp-platform) repository includes the components of the *Hardware Processing Engine* (*HWPE*) accelerator interface that GenOv leverages: [Streamer](https://github.com/pulp-platform/hwpe-stream) and [Controller](https://github.com/pulp-platform/hwpe-ctrl).

An example design of a [HWPE-based MAC accelerator](https://github.com/pulp-platform/hwpe-mac-engine) - as well as its [testbench](https://github.com/pulp-platform/hwpe-tb) - are available as well. Both can be adopted as starting points to better understand the *design principles* and *functionalities* of the HWPE interface.

## Contacts
- **Gianluca Bellocchi** <gianluca.bellocchi@unimore.it>