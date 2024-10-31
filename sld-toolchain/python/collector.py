'''
    =====================================================================

    Copyright (C) 2020 University of Modena and Reggio Emilia

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

    Title:          Collector

    Description:    The Collector class is responsible of collecting the
                    template files from the template library for the generator.

                    Templates are divided in three categories:

                        - Top ~ A top template is the entry point of the rendering operation,
                        which comprise parametrized components and template APIs to recall
                        template modules (or template blocks, using the Mako syntax).
                        Rhe Mako runtime environment is heavily leveraged to facilitate
                        the instantiation of different template components and modules
                        within the top template itself. The Python interpreter can thus
                        be invoked within the body of the template to define parameters,
                        use conditional statements and for loops. A top template comes with
                        a Python support file (same of the top template) that permits to
                        collect all the template components needed during the rendering phase.

                        - Modules ~ A module is a template block and its content can be
                        recalled in a top template. Modularity allows for an easier combination
                        of template components. These can be recalled via template APIs and
                        re-targeted exploting conditional assignements. Further, input design
                        knobs are leveraged at generation-time to retrieve the proper template
                        modules to attain a certain functionality. It is worth to know that
                        design knobs have not to be specified as input API arguments since
                        these are globally applied to the components, as well as recall other
                        modules. The latter can happen both at the same hierarchy level,
                        or at lower thus possibly making it a top template for other template
                        modules.

                        - Common ~ Common template components shared by all templates on the
                        basis of their nature (HW, SW).

                    The '__init__' method imports information about the templates to be collected:

                        - temp_type ~ relative path from 'templates/' to the top directory of
                        the target template type;

                        - temp_top ~ name (with template extension) of top template;

                        - temp_modules ~ list of names (with template extension) of template modules;

                        - path_common ~ relative path from 'templates/' to the top directory of
                        the common templates.

    Date:           17.10.2020

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

# Packages
from os import listdir
from os.path import isfile, join, basename, abspath

'''
    Collector class
    ===============
'''

class Collector:

    def __init__(self, temp_type, temp_top, temp_modules, path_common):
        # input
        self.temp_type      = temp_type
        self.temp_top       = temp_top
        self.temp_modules   = temp_modules
        self.path_common    = path_common

    """
    Get path for all template components (top, modules, common)
    """
    def get_path_all(self):
        # merge paths
        path_all = self.get_path_t_common() + self.get_path_t_modules()
        path_all += self.get_path_t_top()
        return path_all

    """
    Get path for top template.
    """
    def get_path_t_top(self):
        # calculate path ~ template top
        path_top            = [self.temp_type + self.temp_top]
        return path_top

    """
    Get path for template modules.
    """
    def get_path_t_modules(self):
        # calculate path ~ template modules
        path_modules        = []
        for mods in self.temp_modules:
            path_modules.append(self.temp_type + mods)
        return path_modules

    """
    Get path for common template components.
    """
    def get_path_t_common(self):
        # calculate path ~ template common
        path_common         = self.path_common
        # search for templates at the common path
        temp_common = []
        try:
            for f in listdir(self.path_common):
                if isfile(join(self.path_common, f)):
                    if ".mako" in f:
                        temp_common.append(f)
            # construct paths to common templates
            tmp = [path_common + t for t in temp_common]
            path_common = tmp
        except:
            path_common = []
        return path_common

    """
    Given the paths collected using the 'get_path_all' method,
    read the content of all templates. This method is used by
    the python support file comprised in the same directory of
    a top template.
    """
    def get_template(self):
        s = ''
        for paths in self.get_path_all():
            # print('Rendering template "%s" (path: %s)' % (basename(paths), abspath(paths)))
            with open(paths, 'r') as f:
                s += f.read()
                f.close()
        return s
