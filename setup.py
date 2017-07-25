#!/usr/bin/env python
# -*- encoding: utf-8

from pathlib import Path
import subprocess as sb
# import warnings

from distutils.core import setup
from distutils.command.build_py import build_py as _build_py

pwd = Path().absolute()
precc = pwd / 'lib/src/.precc'
fortran_modules = ['kind', 'constants', 'calc_module']
fortran_modules = [precc / f'{mod}.mod' for mod in fortran_modules]
lib_src = pwd / 'lib' / 'core.so'


class build_py(_build_py):
    # Override the build_py class to
    #  (1) make it also compile the f2py shared object
    #  (2) make python module at . the root module called dynlib
    def run(self):
        sb.call("./compile", shell=True)
        super(build_py, self).run()
        self.copy_file(lib_src,
                       Path(self.build_lib) / 'dummyforpy/core.so',
                       preserve_mode=True)
        return

    def finalize_options(self):
        self.set_undefined_options('build', ('build_lib', 'build_lib'))
        _build_py.finalize_options(self)
        return


setup(cmdclass={'build_py': build_py},
      name='dummyforpy',
      version='0.0.1',
      description='Dummy library with embedded Fortran code',
      author='Denis Sergeev',
      author_email='dennis.sergeev@gmail.com',
      packages=['dummyforpy'],
      package_dir={'dummyforpy': 'lib'},
      # py_modules=['test', ],
      # scripts=['bin/dynlib_init.py', ],
      data_files=[
          ('lib', ['lib/libcore.so']),
          ('include', fortran_modules),
      ]
      )
