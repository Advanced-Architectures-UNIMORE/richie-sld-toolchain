# Verification

## Standalone Accelerator Wrapper Testbench

### Introduction
This documentation aims at exlaining how to setup a standalone testbench for a generated accelerator wrapper. Other than this documentation, the user can find additional information in the README.md of the original testbench repository [1].

### Clone the Repository
The root of the standalone testbench is under `genov/genov/verif/hwpe-tb`. The TB is a submodule that can be cloned from the top directory of *genov* using:
```bash
make acc_gen_init
``` 
or with 
```bash
git submodule update --init --recursive
```

### Import Generated Components
Once the accelerator wrapper has been generated and deployed to Git (see README.md to get more information about these steps), the next step is to setup the verification environment and import the generated TB components:
```bash
make acc_verif
```

### Initial Setup
Then, the source management tool has to be informed about the Git-deployed accelerator, so to fetch the branch of the target accelerator. The latter will be the device-under-test (DUT).  Recall that the name of the branch is the same as the name of the target accelerator (see README.md). The information of the corresponding Git repository are comprised in the configuration file under `genov/tools/common_sh/local.cfg`. Move to `genov/genov/verif/hwpe-tb` .

If this is the first setup of the verification environment, move to `hw/ips/` and clone the repository of the target accelerator. The `git add` the cloned folder and commit locally.

### Source DUT from Git
Now you can open `hw/ips_list.yml`. Here you will find a list of IPs that will be cloned from external repositories. Add your deployment repository as well, as in the example below:
```yml
hwpe-gen-app:
	commit: b713b9ecb5932e1c74ae681276570cbf51c09856 # commit tag
	domain: [master] # branch name
```
Note that the commit tag and the branch name will have to be updated everytime a new accelerator needs validation.

At this point, to update the external IP sources, return to the top root of the standalone TB (`genov/genov/verif/hwpe-tb`) and run:

```bash
make update-ips
```
### Build the Hardware Testbench
It is now time to build the hardware testbench. First, set the QuestaSim environment variable to the simulation directory:
```bash
export VSIM_PATH=<genov_path>/genov/verif/hwpe-tb/hw/sim
```
**N.B.** - <genov_path> is the absolute path to the top root directory of `genov` (typically something like $HOME/workspace_user/genov).

Then run:

```bash
make build-hw
```

### PULP SDK
There are several possibilities regarding the installation of the PULP SDK [1]. 

Start by installing the system dependencies indicated [here](https://github.com/pulp-platform/pulp-builder/blob/master/README.md). 

We recommend to install it using through the `pulp-sdk-release` if the user has access to it.

Otherwise, the following commands are to install it through the pulp-builder:
```bash
git clone https://github.com/pulp-platform/pulp-builder.git
cd pulp-builder
git submodule update --init
source configs/pulpissimo.sh
./scripts/clean
./scripts/build-runtime
source sdk-setup.sh
source configs/rtl.sh
cd ..
```

### RISC-V Toolchain
The [RISCV toolchain](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain) has to be installed as well. 

Once the latter is installed, pick its install path and add it to the testbench path:
```bash
export PULP_RISCV_GCC_TOOLCHAIN_CI=<riscv_toolchain_path>
```

### Build the Software Testbench
In `sw/` you can find the software components to build a baremetal application running on the RISC-V core inserted in the testbench. The goal of the application is basically to program and feed the accelerator in a similar way to what would happen at system-level.

However, in this case the final goal is to assess the functionality of the generated hardware components, thus a golden moden is necessary. To this end, in `sw/ref_sw` is inserted a C-based golden model to generate input stimuli and output golden results to validate the DUT.

Among the source files are:

- `main.c` - Generation application.
- `ref_app.c` - Reference software-mapped application. It is assumed this has the same behavior of the hardware-mapped acceleration kernel.
- `ref_app.h` - Header file to support reference software-mapped application.
- `gen_stim.c` - Stimuli generator.
- `gen_Hfile.c` - Script to generate an header file values of a target array.

These components are user-defined. A `ref_sw` sub-directory can be inserted in the accelerator library under the `sw` components. This will be automatically inserted during compilation among the standalone testbench components. Take as reference the toy accelerators to see how to customize the listed source files.

To generate input stimuli and golden results, run:
```bash
make ref_sw
```

### Build the Software Testbench
Return to the top root of the standalone TB (`genov/genov/verif/hwpe-tb`) and run:

```bash
make clean all
```

### Run Simulation
To run the simulation with no GUI:

```bash
make run
```


## Standalone Overlay Testbench 

### RTL sim
GenOv supports the generation of a simple test routine for the instantiation of HWPE in a standalone overlay-based overlay system. The routine is a software test that is run in bare-metal and generated through templating (as is the RTL).
Together with the latter are generated also: 

-  `archi.h` - This C header file comprises the definition of the base address of the HWPE slave port, as well as its register offsets.
-  `hal.h` - This C header file comprises the hardware abstraction layer of HWPE, that is to say the first software layer on top of the RTL. This comprises the APIs definition to access the HWPE registers. 

To simplify the life of the verification engineer, the tool also generates a list of QuestaSim waves that are invoked before the beginning of the simulation. This obviously only works when employing the QuestaSim GUI. The list of waves include all the basic hardware components for a complete verification at system-level. The simulation components are integrated at system-level together with the aforementioned Makefile recipe (`make overlay_integration`).

 If QuestaSim is installed, the simulation infrastructure can be initialized as follows:

```bash
cd HERO_OV_HW_EXPORT
make
cd vsim
make compile
```
To compile the software applications to run the standalone overlay tests is necessary to set up the simulation environment. At first, it is necessary to set the following environment variable:

```bash
export HERO_OV_OPENMP_TESTS=<your_path> (typically something like $HERO_HOME_DIR/openmp-examples)
```

To build applications for the simulation, the dynamic environment can be loaded with `source $HERO_OV_HOME_DIR/env/esim.sh`. Then, the software can be find in the `sw` sub-directory of the exported wrapper. To compile it:
```bash
make clean all
```

Afterwards, the binary can be loaded in the simulator with:

```bash
cd $HERO_OV_HW_EXPORT/vsim
make gen_slm_hwpe HWPE_REPO=hwpe-<target_acc_name>-wrapper/sw
make sim
```
where `<target_acc_name>` is the name of the repository of the generated accelerator wrapper (e.g. *mmult_parallel*).

## Verilator
Ref: https://www.veripool.org/verilator/
## coco-tb
Ref: https://github.com/cocotb/cocotb.git
## DPI-C
Ref: https://www.doulos.com/knowhow/systemverilog/systemverilog-tutorials/systemverilog-dpi-tutorial/

# GitLab CI/CD
From WR:
*I have in mind to add up to the repository some continuous development methodologies to help with the insertion of new templating functionalities. I think this is important as our view is to expand the repository and to give other people the opportunity to modify the back-end. Discussing this point with Alessandro and Andrea, we think that It would be nice to have a regression control. To this end, something like the continuous integration (CI) runner that HERO already supports might be a nice-to-have feature to guarantee robustness. At first, a cool idea could be to take advantage of the testbench generation to “silently” run RTL tests on the accelerator library examples. This is to cover the first portion of the bugs that might manifest in the case of back-end updates.
The latter idea also overlaps with the requirement of having some verification of new user wrappers. We currently miss a way of giving feedback on the correct functionality of new wrappers at the RTL level apart from the employment of traditional RTL verification in QuestaSim. My idea is to head up to a sort of “silent” and automatic RTL simulation with minimal user intervention. I think this would be a nice addition to keep abstraction on the proposed methodology.*

## Useful Repositories
1) Hardware Processing Engine - Standalone testbench: https://github.com/pulp-platform/hwpe-tb

## Contacts
**Gianluca Bellocchi**
* Position: Researcher at University of Modena and Reggio Emilia 
* E-mail: <gianluca.bellocchi@unimore.it>