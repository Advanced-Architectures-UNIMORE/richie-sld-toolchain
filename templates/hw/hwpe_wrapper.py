########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages - Overlay
from templates.hw.ov_acc_pkg.top.ov_acc_pkg import ov_acc_pkg
from templates.hw.ov_acc_intf.top.ov_acc_intf import ov_acc_intf
# Packages - Top
from templates.hw.hwpe_top_wrapper.hwpe_top_wrapper import hwpe_top_wrapper
from templates.hw.hwpe_top.top.hwpe_top import hwpe_top
from templates.hw.hwpe_package.top.hwpe_package import hwpe_package
# Packages - Engine
from templates.hw.hwpe_engine.top.hwpe_engine import hwpe_engine
from templates.hw.hwpe_kernel_adapter.top.hwpe_kernel_adapter import hwpe_kernel_adapter
# Packages - Streamer
from templates.hw.hwpe_streamer.top.hwpe_streamer import hwpe_streamer
# Packages - Controller
from templates.hw.hwpe_ctrl.hwpe_ctrl import hwpe_ctrl
from templates.hw.hwpe_fsm.top.hwpe_fsm import hwpe_fsm

# HWPE wrapper
class hwpe_wrapper:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email

    def ov_acc_pkg(self, hwpe_specs):
        system_hwpe_pkg = ov_acc_pkg(hwpe_specs)
        return system_hwpe_pkg.gen()

    def ov_acc_intf(self, hwpe_specs):
        system_hwpe_intf = ov_acc_intf(hwpe_specs)
        return system_hwpe_intf.gen()

    def top_wrapper(self, hwpe_specs):
        top_wrapper = hwpe_top_wrapper(hwpe_specs)
        return top_wrapper.gen()

    def top(self, hwpe_specs):
        top = hwpe_top(hwpe_specs)
        return top.gen()

    def engine(self, hwpe_specs):
        engine = hwpe_engine(hwpe_specs)
        return engine.gen()

    def kernel_adapter(self, hwpe_specs):
        kernel_adapter = hwpe_kernel_adapter(hwpe_specs)
        return kernel_adapter.gen()

    def streamer(self, hwpe_specs):
        streamer = hwpe_streamer(hwpe_specs)
        return streamer.gen()

    def ctrl(self, hwpe_specs):
        ctrl = hwpe_ctrl(hwpe_specs)
        return ctrl.gen()

    def fsm(self, hwpe_specs):
        fsm = hwpe_fsm(hwpe_specs)
        return fsm.gen()

    def package(self, hwpe_specs):
        package = hwpe_package(hwpe_specs)
        return package.gen()

