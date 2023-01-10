import shutil
import os
import sys
import ctypes
import sysconfig

try:
    import setuptools
    from setuptools import setup, Extension
    from setuptools.command.build_ext import build_ext as _build_ext
    from setuptools.command.install import install as _install
    have_setuptools = True
except ImportError:
    import distutils
    from distutils.core import setup, Extension
    from distutils.command.build_ext import build_ext as _build_ext
    from distutils.command.install import install as _install
    have_setuptools = False

from distutils.errors import DistutilsPlatformError
from distutils import log
from io import open

class build_ext(_build_ext):
    _py_limited_api = False

    def _doesload(self, ext):
        src = os.path.join('ext', self.get_ext_filename(ext.name))
        try:
            dll = ctypes.pydll.LoadLibrary(src)
            del dll
        except:
            log.info('hdbcli: Test load of %s failed (library missing? wrong platform? wrong bitness?)' % self.get_ext_filename(ext.name))
            return False
        log.info('hdbcli: Test load of %s was successful' % self.get_ext_filename(ext.name))
        return True

    def _copy_ext(self, ext):
        src = os.path.join('ext', self.get_ext_filename(ext.name))
        tgt = self.get_ext_fullpath(ext.name)
        if self._py_limited_api and os.name == 'nt' and tgt.endswith('.abi3.pyd'):
            tgt = tgt[:-len('.abi3.pyd')]
            tgt += '.pyd'
        log.info('hdbcli: Installing %s as %s' % (os.path.basename(src), os.path.basename(tgt)))
        shutil.copyfile(src, tgt)

    def _have_compiled_ext(self, ext):
        src = os.path.join('ext', self.get_ext_filename(ext.name))
        log.info('hdbcli: Searching for %s' % os.path.basename(src))
        if src.endswith('pyhdbcli.pyd') and os.name == 'nt' and sys.version_info[0] == 3:
            log.info('hdbcli: Skipping search for %s because Python 3 was used' % os.path.basename(src))
            return False
        if os.path.isfile(src):
            log.info('hdbcli: %s found' % os.path.basename(src))
            return True
        else:
            log.info('hdbcli: %s not found' % os.path.basename(src))
            return False

    def get_ext_filename(self, fullname):
        if sys.version_info[0] == 2:
            return _build_ext.get_ext_filename(self, fullname)
        fullname = super(build_ext, self).get_ext_filename(fullname)
        if self._py_limited_api and '.abi3' not in fullname:
            so_ext = sysconfig.get_config_var('EXT_SUFFIX')
            fullname = fullname[:-len(so_ext)]
            fullname += '.abi3' + (sysconfig.get_config_var('SHLIB_SUFFIX') if not os.name == 'nt' else '.pyd')
        return fullname

    def build_extension(self, ext):
        if sys.maxsize < 2**32 and not (os.name == 'nt' and sys.version_info[0] == 3):
            raise DistutilsPlatformError("hdbcli does not support 32-bit (x86) python")
        self._py_limited_api = False
        if self._have_compiled_ext(ext) and self._doesload(ext):
            self._copy_ext(ext)
        elif sys.version_info[0] == 3:
            # Fallback to installing the abi3.so driver on 3.4+
            if sys.version_info[1] < 4:
                raise DistutilsPlatformError("hdbcli requires Python 3.4 or greater")
            if not have_setuptools:
                raise DistutilsPlatformError("hdbcli requires pip/setuptools")
            ext.py_limited_api = True
            self._py_limited_api = True
            if self._have_compiled_ext(ext) and self._doesload(ext):
                self._copy_ext(ext)
            else:
                raise DistutilsPlatformError("This hdbcli installer is not compatible with your Python interpreter")
        else:
            raise DistutilsPlatformError("This hdbcli installer is not compatible with your Python interpreter")

try:
    with open(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'README'), encoding='utf-8') as f:
        long_description = f.read()
except OSError:
    long_description = 'See README'

setupargs = dict(
    name = 'hdbcli',
    version = '2.11.14',
    description = 'SAP HANA Python Client',
    long_description = long_description,
    long_description_content_type = 'text/x-rst',
    url = 'https://www.sap.com/',
    author = 'SAP SE',
    license = 'SAP DEVELOPER LICENSE AGREEMENT',
    project_urls = { 'Documentation': 'https://help.sap.com/viewer/f1b440ded6144a54ada97ff95dac7adf/latest/en-US/f3b8fabf34324302b123297cdbe710f0.html',
                   },
    classifiers=[ 'Development Status :: 5 - Production/Stable',
                  'Intended Audience :: Developers',
                  'Intended Audience :: End Users/Desktop',
                  'Intended Audience :: Financial and Insurance Industry',
                  'Intended Audience :: Healthcare Industry',
                  'Intended Audience :: Information Technology',
                  'Intended Audience :: Legal Industry',
                  'Intended Audience :: Manufacturing',
                  'Intended Audience :: Science/Research',
                  'License :: Other/Proprietary License',
                  'Operating System :: MacOS :: MacOS X',
                  'Operating System :: Microsoft :: Windows :: Windows 10',
                  'Operating System :: Microsoft :: Windows :: Windows 7',
                  'Operating System :: Microsoft :: Windows :: Windows 8',
                  'Operating System :: Microsoft :: Windows :: Windows 8.1',
                  'Operating System :: Microsoft :: Windows :: Windows Server 2008',
                  'Operating System :: POSIX :: Linux',
                  'Programming Language :: Python',
                  'Programming Language :: Python :: 2.7',
                  'Programming Language :: Python :: 3',
                  'Programming Language :: Python :: 3.4',
                  'Programming Language :: Python :: 3.5',
                  'Programming Language :: Python :: 3.6',
                  'Programming Language :: Python :: 3.7',
                  'Programming Language :: Python :: 3.8',
                  'Programming Language :: Python :: 3.9',
                  'Topic :: Database',
                  'Topic :: Software Development :: Libraries :: Python Modules',
               ],
    keywords = 'SAP HANA client in-memory database SQL business application intelligent enterprise cloud analytics experience',
    packages = ['hdbcli'],
    ext_modules = [Extension('pyhdbcli', [])],
    cmdclass = {'build_ext':build_ext}
)

setup(**setupargs)
