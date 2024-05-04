=====
Tools
=====

-----
TO-DO
-----
* Create table with tools, short description, usage with richie, then below provide larger documentation.

-------
Verible
-------
`Verible <https://chipsalliance.github.io/verible/>`_ is an open-source SystemVerilog style linter and formatting tool.
The style linter is relatively mature and is used as part of our generation flow to analyze RTL components.
Linting serves as a productivity tool for designers to quickly find typos and bugs at the time when the RTL is designed.

We leverage Verible to capture different aspects of the code and detects style elements that are in violation of the `lowRISC Verilog Coding Style Guide <https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md>`_, thus reducing manual code alignment steps.

^^^^^^^^^^^^^^
How to install
^^^^^^^^^^^^^^
You can download and build Verible from scratch as explained on the `Verible GitHub page <https://github.com/google/verible/>`_.
However, since this requires the Bazel build system the recommendation is to download and install a pre-built binary as described below.

Go to `this page <https://github.com/google/verible/releases>`_ and download the correct binary archive for your machine.

The example below is for Ubuntu 20.04:

.. code-block:: console

  export VERIBLE_VERSION=v0.0-3644-g6882622d
  wget https://github.com/google/verible/releases/download/${VERIBLE_VERSION}/verible-${VERIBLE_VERSION}-Ubuntu-20.04-focal-x86_64.tar.gz
  tar -xf verible-${VERIBLE_VERSION}-Ubuntu-20.04-focal-x86_64.tar.gz

If you are using Ubuntu 18.04 then instead use:

.. code-block:: console

  export VERIBLE_VERSION=v0.0-3644-g6882622d
  wget https://github.com/google/verible/releases/download/${VERIBLE_VERSION}/verible-${VERIBLE_VERSION}-Ubuntu-18.04-bionic-x86_64.tar.gz
  tar -xf verible-${VERIBLE_VERSION}-Ubuntu-18.04-bionic-x86_64.tar.gz

Note that we currently use version v0.0-3644-g6882622d, but it is expected that this version is going to be updated frequently, since the tool is under active development.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How to use Verible with the Richie Toolchain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Once the generation flow completes, Verible can be used to analyze the generated RTL.
The tool arguments and invocations are managed in :code:`scripts/verible-format.py`.

For example, the generated RTL of the target platform :code:`richie_example` is analyzed by running the following command from the Toolchain root:

.. code-block:: console

    make check_systemverilog TARGET_PLATFORM=richie_example

------
Pylint
------
`Pylint <https://docs.pylint.org/index.html>`_ is a static code analyser for Python 2 or 3.

We leverage Pylint to detect style elements that are in violation of the `PEP8 Python Code Style Guide <https://peps.python.org/pep-0008/>`_, thus reducing manual code alignment steps.

^^^^^^^^^^^^^^
How to install
^^^^^^^^^^^^^^
Pylint is automatically installed within the Python Virtual Environment of the Richie Toolchain.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How to use Pylint with the Richie Toolchain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Run the following command from the Toolchain root:

.. code-block:: console

    make check_python

----------
ShellCheck
----------
`ShellCheck <https://www.shellcheck.net/>`_ is a shell script static analysis tool, which can detect style elements that are in violation of the `Google Shell Style Guide <https://google.github.io/styleguide/shellguide.html>`_.

^^^^^^^^^^^^^^
How to install
^^^^^^^^^^^^^^
Go to `this page <https://github.com/koalaman/shellcheck>`_ and download the correct binary archive for your machine.

The example below is for Linux x86-64 (statically linked):

.. code-block:: console

  wget https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz
  tar -xf shellcheck-stable.linux.x86_64.tar.xz

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How to use ShellCheck with the Richie Toolchain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Run the following command from the Toolchain root:

.. code-block:: console

    make check_shell
