********************
The Richie Toolchain
********************

.. figure:: img/richie_toolchain.png
  :figwidth: 90%
  :width: 90%
  :align: center

The *Richie Toolchain* is a System-Level Design (SLD) Toolchain that automates and simplifies the HW/SW assembling and specialization of *Accelerator-Rich Heterogeneous Systems-on-Chip (HeSoCs)*.
The Toolchain comprises a set of Python-based tools, which enables the seamless and rapid composition of accelerators into full-fledged Accelerator-Rich HeSoCs, from a *high-level description*.
Indeed, the Toolchain supports various *accelerator design flows*, e.g., leveraging High-Level Synthesis (HLS).
Generated HeSoCs are based on the `Parallel Ultra Low Power (PULP) Platform <https://pulp-platform.org/index.html>`_, an open-source research and development platform targeting highly parallel architectures for ultra-low-power processing based on the RISC-V Instruction Set Architecture (ISA).
The *Richie Toolchain* was formerly named *GenOv*.

.. include_after_this_label

===============
Getting Started
===============

--------------------
Clone the Repository
--------------------
Clone the repository with its Git submodules using :code:`git clone --recursive <url>` or fetch the submodules afterwards with :code:`git submodule update --init --recursive`.

---------------------------------------
Integration within the Richie Framework
---------------------------------------
This toolchain is employed as part of the *Richie framework*, which includes the HW/SW components to design, build, and deploy a full-fledged accelerator-rich HeSoC.
This ecosystem leverages the *Richie Toolchain* to generate the necessary HW/SW sources to drive the specialization of the target HeSoC platform.
To safely let the framework parts interact, the root of the Richie hardware subsystem (:code:`RICHIE_HW`) must be defined accordingly:

.. code-block:: console

  export RICHIE_HW=<global-path-to-richie>/richie/hardware

--------------------------
Python Virtual Environment
--------------------------
The toolchain leverages a Python virtual environment to manage the tool dependencies.
The toolchain has been tested with :code:`Python 3.8.10`, so we recommend sticking with this version.
To create the environment and install the required packages (listed inside :code:`requirements.txt`), simply run:

.. code-block:: console

    make py_env_init

Then, the environment can be activated by :code:`source richie-py-env/bin/activate`.
If new packages are added, the environment can be updated with the following command:

.. code-block:: console

    make py_env_update_reqs

Note that the :code:`py_env_init` command should be run again to install newly added packages and/or update old ones.

--------------------------
Third-Party Git Submodules
--------------------------
Third-party submodules can be pulled with the following command:

.. code-block:: console

    make richie_gen_init

-----------------
Third-Party Tools
-----------------
More information under :code:`tools`.

===================
System-Level Design
===================

.. only:: richie_docs

    .. figure:: ../img/richie_toolchain.*
        :figwidth: 90%
        :width: 90%
        :align: center

        The Richie toolchain.

The *Richie Toolchain* facilitates three SLD phases concerning the assembling of Accelerator-Rich HeSoCs:

#. **Accelerator design**;
#. **System integration**;
#. **System optimization**.

------------------
Accelerator Design
------------------
.. _richie_toolchain_root_sld_acc_design:

This phase produces the accelerator datapaths. The *Richie Toolchain* supports various design flows to accommodate a wide range of users and application needs, including:

* High-Level Synthesis:

  * `AMD-Xilinx Vitis HLS <https://www.xilinx.com/products/design-tools/vitis/vitis-hls.html>`_
  * `Coarse-Grain Reconfigurable (CGR) Hardware Accelerators <https://mdc-suite.github.io/>`_

* Manual RTL Design:

  * `HWPE-based Accelerators <https://hwpe-doc.readthedocs.io/en/latest/index.html>`_

The IP interface is expected to attain the following requirements:

* Adopt a *streaming-based interface* for data communication, e.g. the AMBA® 4 AXI4-Stream Protocol.
* Adopt *simple data ports* or wires for control parameters, thus with no associated I/O protocol and handshaking signal.

------------------
System Integration
------------------
.. _richie_toolchain_root_sld_integration:

This phase generates the accelerator interfaces which facilitate the integration inside the Accelerator-Rich HeSoC.
These include HW interfaces for data communication and control, as well as SW drivers.
The user is asked to provide an *accelerator specification file* describing the characteristics of the accelerator interface, as shown in the example below:

.. code-block:: python

    class accelerator_specs:

		def engine(self):
			self.name = Accelerator datapath
			self.flow = HLS, RTL
			self.protocol = HWPE
			return self

		def streamer(self):
			self.inputs = [[Name, DataType], ...]
			self.outputs = [[Name, DataType], ...]
			return self

		def controller(self):
			self.regs = [[Name, DataType], ...]
			return self

Specifications are collected in the accelerator library (:code:`src/accelerators/`), including the following sections:

* :code:`specs/`: This location contains the accelerator specification file :code:`accelerator_specs.py`, which embodies the required information
  to specialize the HW/SW interface between the application-specific accelerators and the outer platform.

-------------------
System Optimization
-------------------
.. _richie_toolchain_root_sld_optimization:

This phase performs the specialization of the platform parts to meet the requirements of the integrated workload.
The outcome consists of a specialized and optimized *Accelerator-Rich HeSoC*.
Similarly, this phase mandates a *platform specification file* with the HeSoC characteristics,

.. code-block:: python

    class platform_specs:

            def hesoc(self):
                self.name = Accelerator-Rich HeSoC
                self.target = FPGA fabric
                self.l2_mem = [Number of ports, Size]
                return self

            def cluster_0(self):
                self.acc = [Accelerator name, ...]
                self.proxy = [IP, Number of cores, ...]
                self.dma = [IP, Job queue size, ...]
                self.l1_mem = [Number of ports, Size]
                return self

            ...

            def cluster_N(self)
                ...

Specifications are collected in the platform library (:code:`src/platforms/`), including the following sections:

* :code:`specs/`: This location contains the platform specification file :code:`platform_specs.py`, which guides the Richie Toolchain on how
  to specialize the Accelerator-Rich HeSoC.

========================================
Generation of the Accelerator-Rich HeSoC
========================================
.. _richie_toolchain_root_generation:

-------------------
The Generation Flow
-------------------
The *Richie Toolchain* adopts a design automation approach, which can be defined as *template-based*.
Basically:

#. *Platform* and *accelerator specification files* consist of user-defined design knobs, which are meant to specialize the HeSoC components;
#. *Templates* consist of marked-up text, which can be *rendered* into various output formats, e.g. HW/SW components, scripts, documentation, etc.
#. The *generation flow* provides parameters to a *rendering engine*, which parses and renders the toolchain templates.
   In particular, the latter leverages the `Mako Template Library <https://www.makotemplates.org/>`_.
#. The result consists of a *full-fledged Accelerator-Rich HeSoC*, including both HW/SW components and ready-to-go simulation and synthesis scripts.

----------
How to Run
----------
The generation flow is triggered with the following command:

.. code-block:: console

  make clean all TARGET_PLATFORM=<TARGET_PLATFORM>

Additionally, add the following arguments:

* **TARGET_PLATFORM**: This is to specify the target platform, where the device-under-test (DUT) is integrated.
  This should match the name declared in the corresponding :ref:`platform specification file <richie_toolchain_root_sld_optimization>`.
  For example, :code:`make clean all TARGET_PLATFORM=richie_example` is run to generate the target platform :code:`richie_example`, which
  specification is kept under :code:`src/platforms/richie_example/specs`.

The generated components will then be available under :code:`output`.

=======
License
=======
The *Richie Toolchain* is released under permissive open-source licenses:

* **Source files**, **tool scripts** and **templates** are released under the :code:`Apache 2.0 license` (`Apache-2.0 <https://www.apache.org/licenses/LICENSE-2.0>`_).
* **Generated components** are differently released depending on their specific nature:

  * *Hardware* is released under the :code:`Solderpad 0.51 license` (`SHL-0.51 <http://solderpad.org/licenses/SHL-0.51>`_).
  * *Software* and *other formats* are released under the :code:`Apache 2.0 license` (`Apache-2.0 <https://www.apache.org/licenses/LICENSE-2.0>`_).

============
Publications
============
If you use Richie in your work, you can cite us:

.. details:: A RISC-V-based FPGA overlay to simplify embedded accelerator deployment

    .. code-block:: none

        @inproceedings{bellocchi2021risc,
            title={A risc-v-based fpga overlay to simplify embedded accelerator deployment},
            author={Bellocchi, Gianluca and Capotondi, Alessandro and Conti, Francesco and Marongiu, Andrea},
            booktitle={2021 24th Euromicro Conference on Digital System Design (DSD)},
            pages={9--17},
            year={2021},
            organization={IEEE}
        }

| Other work which can be found in or contributed to this repository:

.. details:: XNOR neural engine: A hardware accelerator IP for 21.6-fJ/op binary neural network inference

    .. code-block:: none

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

.. details:: HERO: An open-source research platform for HW/SW exploration of heterogeneous manycore systems

    .. code-block:: none

        @inproceedings{kurth2018hero,
            title={HERO: An open-source research platform for HW/SW exploration of heterogeneous manycore systems},
            author={Kurth, Andreas and Capotondi, Alessandro and Vogel, Pirmin and Benini, Luca and Marongiu, Andrea},
            booktitle={Proceedings of the 2nd Workshop on AutotuniNg and aDaptivity AppRoaches for Energy efficient HPC Systems},
            pages={1--6},
            year={2018}
        }

.. details:: PULP: A parallel ultra low power platform for next generation IoT applications

    .. code-block:: none

        @inproceedings{rossi2015pulp,
            title={PULP: A parallel ultra low power platform for next generation IoT applications},
            author={Rossi, Davide and Conti, Francesco and Marongiu, Andrea and Pullini, Antonio and Loi, Igor and Gautschi, Michael and Tagliavini, Giuseppe and Capotondi, Alessandro and Flatresse, Philippe and Benini, Luca},
            booktitle={2015 IEEE Hot Chips 27 Symposium (HCS)},
            pages={1--39},
            year={2015},
            organization={IEEE Computer Society}
        }

===================
Useful Repositories
===================

-----------------------------------------
AMD-Xilinx Open Hardware Competition 2023
-----------------------------------------
*GenOv* - the former name of the *Richie toolchain* - was proposed in the 2023 edition of the AMD-Xilinx Open Hardware Competition.

.. code-block:: none

    Spoiler...
                                                                                                                                                                                    ...We have not won! :-)

Yet, we have released a `tutorial <https://github.com/gbellocchi/xil_open_hw_23>`_ to help you familiarize yourself with our work.

------------------------------
The HWPE Accelerator Interface
------------------------------
The `PULP platform <https://github.com/pulp-platform>`_ repository includes the components of the *Hardware Processing Engine* (*HWPE*) accelerator interface that Richie leverages: `Streamer <https://github.com/pulp-platform/hwpe-stream>`_ and `Controller <https://github.com/pulp-platform/hwpe-ctrl>`_.
An example design of a `HWPE-based MAC accelerator <https://github.com/pulp-platform/hwpe-mac-engine>`_ - as well as its `testbench <https://github.com/pulp-platform/hwpe-tb>`_ - are available as well. Both can be adopted as starting points to better understand the *design principles* and *functionalities* of the HWPE interface.

========
Contacts
========
* **Gianluca Bellocchi** <gianluca.bellocchi@unimore.it>
