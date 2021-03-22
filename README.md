# HWPE Wrapper Generator Tool
The HWPE Wrapper Generator Tool consists of a set of python packages, SV templates and a Makefile that permit to speed up the 
integration and deployment of hardware accelerators in PULP-based systems. To learn more about HWPE, take a look at [1] and [2].

The integration of custom accelerators is simplified by the definition of a communication/control interface in the form of a wrapper 
to the acceleration logic that can be instantiated multiple times within a PULP-based cluster. A wrapper encapsulates the functionality 
of a HWPE streamer and controller modules. Since these modules have dependencies on the specific accelerator (engine) implementation, it 
is necessary to distinguish between their static and variable RTL components. Once the user has defined key properties of its accelerator 
design, the specialization of the wrapper is simplified via template instantiation.

Given a set of initial design rules, the designer is equipped with a high-level language (HLL) interface that allows him/her to customize 
the wrapper.This tool does not mandate any specific methodology to design theengine of accelerators. This can be accomplished with HLS tools, 
or by means of manually optimized RTL. An automated flow permits to integrate the acceleration logic within the wrapper, which is in turn integrated 
with the PULP system for validation. 

If you need further details, please contact me at <gianluca.bellocchi@unimore.it>

## Getting Started

### External sources
The tool uses Git submodules that have to be initialized. In order to fetch the submodules in the repository, run:

```
git submodule update --init --recursive
```

### Setup

#### Accelerator library
Move to the accelerator library:

```
cd acc_lib
```
 
Here are inserted examples of hardware accelerator that are wrappable and exportable to the Overlay environment. If you want to extend the content of this library, the best practice is to
create a new library folder containing RTL, SPECS and SW subfolders.

##### RTL subfolder
This folder comprises the RTL files of the hardware accelerator to be wrapped. 

##### SPECS subfolder
This folder comprises the Python specification file with the information concerning the interface between the HWPE wrapper and the hardware accelerator.

#### HWPE_TARGET
Open the Makefile in the top folder of the project. Edit the following macros according to your environment and application needs. 
Specify the name of the accelerator you want to wrap. This has to match the name of the accelerator library you have previously created in "acc_lib".

### Wrapper specialization
Run:

```
make clean gen
```

This way, the Python template libraries will process the System Verilog wrapper templates on the basis of the information you have provided in the Python specification file, permitting 
the wrapping of the specified hardware accelerator design. The generated files are exported to the output folder.

### Exporting to the Overlay
Run:

```
make overlay_deps
```

This way, the generated HW/SW will be exported to the Overlay ecosystem.

## References:

    1) Hardware Processing Engines Documentation: https://hwpe-doc.readthedocs.io/en/latest/index.html

    2) "XNOR Neural Engine: A Hardware Accelerator IP for 21.6-fJ/op Binary Neural Network Inference" - F. Conti et al. (2018)






