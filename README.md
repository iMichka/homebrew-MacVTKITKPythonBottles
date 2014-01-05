homebrew-kitware
================

## The unofficial Kitware Homebrew tap

This page provides binaries (Homebrew bottles) of VTK and ITK for OS X (10.7, 10.8 and 10.9).

They are compiled against Homebrew's python.

The files are provided "as is" without warranty or support of any kind. These packages are unofficial, which means they are compiled and distributed without official kitware support.

## Current versions

  - VTK 6.0.0
  - ITK 4.5.0

You will need to have Homebrews python (2.7.6) installed.

## How to use

  - brew install python
  - brew tap iMichka/homebrew-MacVTKITKPythonBottles
  - brew install iMichka/MacVTKITKPythonBottles/vtk
  - brew install iMichka/MacVTKITKPythonBottles/insighttoolkit

## Why unofficial binaries ?

For VTK, the sole advantage is that you don't have to wait for the compilation.

The problem this project tries to tackle is to get ITK to install on OS X with python wrappings.
Due to incompatibilities between gccxml and clang (gccxml is converting the highly templated ITK c++ code to xml files, which are then converted for the python wrapping), it is very tedious to install ITK on OS X.
By the way, the compilation time can be very long (up to 2 hours for ITK), so a fast installation through binaries is always welcome.

I found a way to trick gccxml into finding the right include headers to be able to compile ITK with python wrappers on OS 10.7. 
For OS 10.9 and 10.8, the same binary is used as the one compiled under 10.7. This "just works" for the python bindings. Note that I did not try to use this ITK binaries to build a C++ app with it (feel free to contac me if you tried, input is always welcome).

My trick to get ITK to compile with python wrappings under OS 10.7.5:

  - Rename /usr/include to /usr/_include
  - brew install insighttoolkit --with-python
  - Rename back /usr/_include to /usr/include

This is quite a dirty hack, if somebody has an explanation of why it works, feel free to enlight me.
