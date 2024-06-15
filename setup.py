from setuptools import setup, find_packages

setup(
    name='libvirt-starter',
    version='0.4',
    packages=find_packages(),
    install_requires=[
        'libvirt-python',
    ],
    entry_points={
        'console_scripts': [
            'libvirt-starter=src.main:main',
        ],
    },
)
