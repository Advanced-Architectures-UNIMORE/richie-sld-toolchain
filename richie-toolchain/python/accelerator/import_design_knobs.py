'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    =====================================================================

    Project:        Richie Toolchain

    Title:          Import Accelerator Design Knobs

    Description:    Import the specification comprising the necessary design
                    knobs to generate a specialized HW/SW accelerator interface.

    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

from importlib import import_module

'''
  =====================================================================
  Title:        import_accelerator_design_knobs
  Type:         Function
  Description:  Import accelerator design knobs for the generator.
  =====================================================================
'''

def import_accelerator_design_knobs(target_acc):
    module_name = "dev.accelerator_dev." + target_acc + ".specs.accelerator_specs"
    accelerator_specs = import_module(module_name)
    return accelerator_specs
