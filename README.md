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
  - brew tap iMichka/homebrew-kitware
  - brew install iMichka/homebrew-kitware/vtk
  - brew install iMichka/homebrew-kitware/insighttoolkit

## Why unofficial binaries ?

For VTK, the sole advantage is that you don't have to wait for the compilation.

The problem this project tries to tackle is to get ITK to install on OS X with python wrappings.
Due to incompatibilities between gccxml and clang (gccxml is converting the highly templated ITK c++ code to xml files, which are then converted for the python wrapping), it is very tedious to install ITK on OS X.
By the way, the compilation time can be very long (up to 2 hours for ITK), so a fast installation through binaries is always welcome.

I found a way to trick gccxml into finding the right include headers to be able to compile ITK with python wrappers on OS 10.7 and 10.8.
For OS 10.9, I use the binary compiled under 10.8.5 and rename it for 10.9 (it "just works").

My trick to get ITK to compile with python wrappings :

  - Rename /usr/include to /usr/_include
  - brew install insighttoolkit --with-python
  - Rename back /usr/_include to /usr/include

This is quite a dirty hack, if somebody has an explanation of why it works, feel free to enlight me.
