# <span style="font-variant:small-caps;">Richie SLD Toolchain</span>

<figure>
  <p align="center">
  <img
  src="https://richie-docs.readthedocs.io/en/latest/_images/richie_sld_toolchain.png"
  width="750px"
  </p>
</figure>

## About this project
This <span style="font-variant:small-caps;">**SLD toolchain**</span> automates and facilitates the hardware-software co-design of HeSoCs, based on the accelerator-rich and many-core compute paradigms.
The [**SLD flow**](https://richie-docs.readthedocs.io/en/latest/richie-sld-toolchain/index.html#system-level-design) is totally automated and goes through the *design and integration* of application-specific accelerators into an HeSoC platform.
The hardware and software components of the HeSoC platform are *specialized*, on top of the application requirements, and finally *generated*, including the scripts to build and deploy it on commercially off-the-shelf FPGA fabrics.

<a href="https://pulp-platform.org">
<img src="https://richie-docs.readthedocs.io/en/latest/_images/pulp_logo_icon.svg" alt="Logo" width="100" align="right">
</a>

This <span style="font-variant:small-caps;">SLD toolchain</span> is part of the [<span style="font-variant:small-caps;">Richie framework</span>](https://github.com/Advanced-Architectures-UNIMORE/richie), an open-source research project developed by the University of Modena and Reggio Emilia (UNIMORE) and the [PULP (Parallel Ultra-Low Power) Platform group](https://pulp-platform.org/index.html), from ETH Zürich and the University of Bologna.

## About this repository
This repository comprises hardware, software and support utilities to support the generation of a full-fledged HeSoC platform.
The toolchain components are leveraged as part of the <span style="font-variant:small-caps;">Richie framework</span>, but are easily reusable for other projects and HeSoC architectures.

The repository is organized as follows:

- `src`: *Specification sources*, i.e., sets of design-time knobs, which are collected in distinct platform and accelerator specification libraries;
- `sld-toolchain`: *SLD toolchain implementation*. It also comprises the `templates` (hardware, software, utilities, etc.), divided into platform and accelerator template libraries;
- `tools`: Collection of various *tools*, e.g., for code checking;
- `scripts`: *Scripts* for Python virtual environment, HWPE standalone verification, code checks and the export of generated artefacts;
- `verif`: *Verification environment and tools*, including the HWPE standalone verification from the PULP platform;
- <span style="font-variant:small-caps;">[build]</span> `richie-py-env`: Build directory of the *Python virtual environment*;
- <span style="font-variant:small-caps;">[build]</span> `output`: Build directory of the *generated HeSoCs*.

## Documentation
The project includes comprehensive documentation that can be accessed [online at Read the Docs](https://richie-docs.readthedocs.io/en/latest/richie-sld-toolchain/index.html).

## How to contribute
We are always enthusiastic about potential collaborations and contributions to our work!
Have a look at our [contribution guide](https://richie-docs.readthedocs.io/en/latest/general/contributing.html) in order to learn how to contribute code to this repository.

## License
[Have a look at our guidelines for licensing](https://richie-docs.readthedocs.io/en/latest/general/license.html), or take a look at the full text:
- see [LICENSE-SHL](LICENSE-SHL) for the Solderpad Hardware License, Version 0.51;
- see [LICENSE-APACHE](LICENSE-APACHE) for the Apache License, Version 2.0.

## Contacts
Do not hesitate to reach us in case of questions using [our contact page](https://richie-docs.readthedocs.io/en/latest/general/team.html).
