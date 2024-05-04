============
Verification
============

-----------------------------------
HWPE-based accelerator (standalone)
-----------------------------------
The Richie Toolchain supports the standalone verification of its *generated* `Hardware Processing Engine (HWPE) accelerators <https://hwpe-doc.readthedocs.io/en/latest/>`_.
Additional information concerning the adopted test suite is available in the repository of the `HWPE TestBench (TB) <https://github.com/pulp-platform/hwpe-tb>`_.

^^^^^^^^^^^^^^^^^^^^
Clone the Repository
^^^^^^^^^^^^^^^^^^^^
The HWPE TB is cloned as a Git submodule running :code:`git submodule update --init --recursive`.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Prepare the Verification Environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Once the :ref:`generation <richie_toolchain_root_generation>` of the target platform completes, the verification environment can be set by importing the generated TB components.
From the root of the Richie Toolchain, run the following command:

.. code-block:: console

  make acc_verif TARGET_PLATFORM=<TARGET_PLATFORM> TARGET_ACC_VERIF=<TARGET_ACC_VERIF>

Additionally, add the following arguments:

* **TARGET_PLATFORM**: This is to specify the target platform, where the device-under-test (DUT) is integrated.
  This should match the name declared in the corresponding :ref:`platform specification file <richie_toolchain_root_sld_optimization>`.

* **TARGET_ACC_VERIF**: The target DUT, which is assumed to be integrated into the <TARGET_PLATFORM>. This should match the name
  declared in the corresponding :ref:`accelerator specification file <richie_toolchain_root_sld_integration>`.

^^^^^^^^^^^^
Build the HW
^^^^^^^^^^^^
Move now to the root of the HWPE TB (:code:``richie-toolchain/verif/hwpe-tb``) and run the following command to update the external IP sources:

.. code-block:: console

  make update-ips

At this point, the RTL source management tool (`Bender <https://github.com/pulp-platform/bender>`_) should have compiled a :code:``hw/compile.tcl``
including the necessary build dependencies for the RTL simulator. Then, set the QuestaSim environment variable to the simulation directory and
finally build the HW:

.. code-block:: console

  export VSIM_PATH=<global-path-to-richie-toolchain>/richie-toolchain/verif/hwpe-tb/hw/sim
  make build-hw

^^^^^^^^^^^^^^^^^^^^
Prepare the PULP SDK
^^^^^^^^^^^^^^^^^^^^
There are several possibilities regarding the installation of the PULP SDK.

""""""""""""""""
SDK dependencies
""""""""""""""""
Start by installing the SDK dependencies of the
`pulp-builder <https://github.com/pulp-platform/pulp-builder/blob/master/README.md>`_.

"""""""""""""""""""""""""""""""
Install by the pulp-sdk-release
"""""""""""""""""""""""""""""""
We recommend installing the SDK using the `pulp-sdk-release <https://github.com/pulp-platform/pulp-sdk-release>`_.

Once installed, open :code:``pulp-sdk-release/env/env-sdk-2020.01.01.sh`` and modify the script
with the information concerning the user environment. Then, the build environment can be set up
as follows:

.. code-block:: console

  cd pulp-sdk-release
  source env/env-sdk-2020.01.01.sh
  source pkg/sdk/2020.01.01/configs/pulpissimo.sh
  source pkg/sdk/2020.01.01/configs/platform-rtl.sh
  cd ..

.. note::
  Our tests have been conducted with the SDK environment version :code:``2020.01.01``.

"""""""""""""""""""""""""""
Install by the pulp-builder
"""""""""""""""""""""""""""
Otherwise, the following commands are to install it through the :code:``pulp-builder``:

.. code-block:: console

  git clone https://github.com/pulp-platform/pulp-builder.git
  cd pulp-builder
  git submodule update --init
  source configs/pulpissimo.sh
  ./scripts/clean
  ./scripts/build-runtime
  source sdk-setup.sh
  source configs/rtl.sh
  cd ..

^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Prepare the RISC-V Toolchain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The `RISCV toolchain <https://github.com/pulp-platform/pulp-riscv-gnu-toolchain>`_ has to be installed, as well.
Then, after installation, add its install path to the TB path:

.. code-block:: console

  export PULP_RISCV_GCC_TOOLCHAIN_CI=<riscv-toolchain-path>

^^^^^^^^^^^^
Golden Model
^^^^^^^^^^^^
The final verification goal is to assess the functionality of the generated HW components, thus a golden model is necessary.
To this end, a C-based golden model is leveraged to generate input stimuli and output golden results, thus validating the DUT.
This is inserted under :code:``hwpe-tb/sw/ref_sw``.

Among the source files are:

* :code:``main.c`` - Generation application.
* :code:``ref_app.c`` - Reference SW-mapped application. It is assumed this has the same behavior as the accelerator datapath.
* :code:``ref_app.h`` - Header file to support reference SW-mapped application.
* :code:``gen_stim.c`` - Stimuli generator.
* :code:``gen_Hfile.c`` - Script to generate header file values of a target array.

To generate input stimuli and golden results, run:

.. code-block:: console

  make ref_sw

.. note::
  Refer to our accelerator examples to learn how to integrate a golden model in this test suite.

^^^^^^^^^^^^
Build the SW
^^^^^^^^^^^^
In :code:``hwpe-tb/sw`` you can find the SW components to build an application running bare-metal on the RISC-V core of the TB.
The goal of the application is basically to program and feed the accelerator in a similar way to what would happen in a full-fledged system.


Return to the root of the HWPE TB and run:

.. code-block:: console

  make clean all

^^^^^^^^^^^^^^^^^^^^^^
Run the RTL Simulation
^^^^^^^^^^^^^^^^^^^^^^
To run the simulation with no GUI:

.. code-block:: console

  make run
