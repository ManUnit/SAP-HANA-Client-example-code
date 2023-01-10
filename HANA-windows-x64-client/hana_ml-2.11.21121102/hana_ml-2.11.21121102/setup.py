from setuptools import setup, find_packages
import unittest
try:
    import configparser
except ImportError:
    import ConfigParser as configparser

# read the contents of your README file
import os
from os import path
import io

this_directory = path.abspath(path.dirname(__file__))
with io.open(path.join(this_directory, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

def test_suite():
    config = configparser.ConfigParser()
    config.read('nutest/testscripts/config/e2edata.ini')

    loader = unittest.TestLoader()
    test_dir = 'nutest/testscripts/'
    test_dir_core = 'nutest/testscripts/core/'
    test_dir_pal = 'nutest/testscripts/pal/'
    test_dir_apl = 'nutest/testscripts/apl/'
    test_dir_artifacts = 'nutest/testscripts/artifacts'
    test_dir_graph = 'nutest/testscripts/graph'
    test_dir_spatial = 'nutest/testscripts/spatial'
    test_dir_docstore = 'nutest/testscripts/docstore'

    suite = loader.discover(
        start_dir=test_dir,
        pattern='unit*.py',
        top_level_dir=test_dir
    )

    if config.getboolean('testsuite_core', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_core,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_pal', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_pal,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_pal', 'run_notebooks'):
        suite.addTest(loader.discover(
            start_dir=test_dir_pal,
            pattern='run_notebooks.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_apl', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_apl,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_artifacts', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_artifacts,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_graph', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_graph,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_spatial', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_spatial,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    if config.getboolean('testsuite_docstore', 'integration_tests'):
        suite.addTest(loader.discover(
            start_dir=test_dir_docstore,
            pattern='test*.py',
            top_level_dir=test_dir
        ))

    return suite

def get_version():
    with open('version.txt') as ver_file:
        version_str = ver_file.readline().rstrip()
    return version_str

tests_require_pkgs = [
    'mock',
    'selenium'
]

install_requires = [
        'hdbcli>=2.4.194',
        'numpy>=1.16.4;python_version>="3.4"',
        'numpy<1.16.4;python_version<"3.4"',
        'pandas>=0.24.2;python_version>="3.4"',
        'pandas<0.24.2;python_version<"3.4"',
        'matplotlib;python_version>="3"',
        'pydot',
        'Deprecated',
        'htmlmin>=0.1.12',
        'tqdm>=4.43.0',
        'schedule'
]

setup(
    name='hana_ml',
    version=get_version(),
    author='SAP SE',
    license='SAP DEVELOPER LICENSE AGREEMENT',
    url='https://www.sap.com/',
    project_urls={
    'Documentation': 'https://help.sap.com/doc/1d0ebfe5e8dd44d09606814d83308d4b/2.0.05/en-US/html/index.html'
    },
    keywords='SAP HANA machine learning intelligent enterprise cloud PAL APL client',
    description='Python Machine Learning Client for SAP HANA',
    long_description=long_description,
    long_description_content_type='text/markdown',
    classifiers=[
        'Programming Language :: Python :: 3.1',
        'Programming Language :: Python :: 3.2',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Operating System :: Microsoft',
        'Operating System :: Other OS'
    ],

    packages=find_packages(where='src'),
    package_dir={'': 'src'},

    install_requires=install_requires,

    include_package_data=True,

    test_suite='__main__.test_suite',

    python_requires='>=3.0',

    tests_require=tests_require_pkgs,
)
