# GenOv

## Introduction
### Description
GenOv is a set of Python-based tools to simplify the design of accelerator-rich heterogeneous embedded architectures [1]. GenOv generates both system components and accelerator wrappers, based on the HWPE protocol. To learn more about HWPE, take a look at [2] and [3].

## Getting Started

### Clone the Repository
GenOv can be be cloned from:
```
https://github.com/gbellocchi/genov.git
```

### AROV Environment
Be sure that `HERO_OV_HW_EXPORT` is set to the root of AROV (e.g. `/home/user-name/workspace_user/arov`).

### Python Virtual Environment
To manage the tool dependencies, a Python virtual environment is employed. To initialize it and download the required packages (see 'requirements.txt'), run:

```
make py_env_init
```

This command manages the installation of the required Python packages, including the Mako template library [6] that is employed for the templating operation.

In case of an update of the package requirements run:

```
make py_env_update_reqs
```

### External Sources
The tool uses Git submodules that have to be initialized. To pull the required Git submodules, run:

```
make ov_gen_init
```

## Specification Source Files

### Accelerator Specification Source Files

User-defined source files are to be inserted in the accelerator library (`src/accelerators/`). There exist exemplary library items to guide the user in the phase of integration of new wrapper specifications.
To extend the content of the library, the best practice is to create a new library folder comprising the following sections:

1.  `specs/` - This location contains the Python specification file `acc_specs.py`. The latter embodies the required information to specialize the interface between the accelerator wrapper and the integrated engine, as well as additional features.
2.  `rtl/` - This location contains the RTL components of the engine the user wants to wrap. To this end, the flow does not mandate any specific design methodology for the target accelerator engines.
3.  `sw/` - This location contains additional software components for the testing phase.
  
An `__init__.py` is always required to properly propagate information from the accelerator library throughout the template library. The content of the former has to be interpretable and accessible by Python as part of the tool package.

### Overlay Specification Source Files
Similarly, the user-defined source files to guide system generation are to be inserted in the overlay library (`src/overlays/`). To extend the content of the library, the best practice is to create a new library folder comprising the following sections:

1.  `specs/` - The Python specification file is named `ov_specs.py`. This specification tells the tool how to connect accelerator wrappers at system-level and how to tailor HW resources to the application requirements. At the moment, only a minimal subset of the possible HW customizations are exposed to the user. Examples are inserted to guide the user during the first system specifications.

## System Generation
To generate the system, you can run the command `make clean all`. 

Additionally, add the following arguments:

- **TARGET_OV**: This is to specify the path to the target system to be generated. For the generation to succeed, an overlay specification should exist in the library (comprised under: `src/overlays/`) with the very same name of the target system. For example, you can run the command `make vsim TARGET_OV=ex-gen-1` only when It exists a specification for `ex-gen-1` under `src/overlays/ex-gen-1/specs`.

The generated components will then be available under `output`.

To export the generated system to AROV, run `make ov_deploy`.

## References
1) "A RISC-V-based FPGA Overlay to Simplify Embedded Accelerator Deployment" - G. Bellocchi et al. (2021)
2) "XNOR Neural Engine: A Hardware Accelerator IP for 21.6-fJ/op Binary Neural Network Inference" - F. Conti et al. (2018)
3) Hardware Processing Engines Documentation: https://hwpe-doc.readthedocs.io/en/latest/index.html
  
## Useful Repositories
1) Hardware Processing Engine - Streamer: https://github.com/pulp-platform/hwpe-stream
2) Hardware Processing Engine - Controller: https://github.com/pulp-platform/hwpe-ctrl
3) Hardware Processing Engine - MAC engine example: https://github.com/pulp-platform/hwpe-mac-engine
4) Hardware Processing Engine - Standalone testbench: https://github.com/pulp-platform/hwpe-tb
5) PULP platform - https://github.com/pulp-platform
6) Mako Templates for Python - https://www.makotemplates.org/

## Contacts
**Gianluca Bellocchi**
* E-mail: <gianluca.bellocchi@unimore.it>