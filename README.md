VTK ITK Python Homebrew tap
===========================

This page provides binaries (Homebrew bottles) of VTK and ITK for OS X (10.7, 10.8 and 10.9) with python wrapping.

They are compiled against Homebrew's python (2.7.6).

The VTK and ITK binaries were compiled without specific options, like fftw, freetype, opencv, etc ... but this could still be added if needed.

The files are provided "as is" without warranty or support of any kind.

## Current versions

  - VTK 6.0.0
  - ITK 4.5.0

You will need to have Homebrews Python (2.7.6) installed.

## How to use

  - brew install python
  - brew tap iMichka/homebrew-MacVTKITKPythonBottles
  - brew install iMichka/MacVTKITKPythonBottles/vtk
  - brew install iMichka/MacVTKITKPythonBottles/insighttoolkit

## Why unofficial binaries ?

For VTK, the advantage is that you don't have to wait for the compilation to finish.

The main problem this project tries to tackle is to get ITK to install on OS X with Python wrappings.
Because of incompatibilities between GCCXML and Clang (GCCXML is converting the highly templated ITK C++ code to XML files, which are then converted for the Python wrapping), it is very tedious to install ITK on OS X.
Incidentally, the compilation time can be very long (up to 2 hours for ITK on slow computers), so a fast installation through binaries is always welcome.

I found a way to trick GCCXML into finding the right include headers to be able to compile ITK with Python wrappers on OS 10.7. For OS 10.8 and 10.9, the same binary is used as the one compiled under 10.7. This "just works" for the python bindings.(It's no more possible to compile ITK 4.5 under 10.8 and 10.9).

My trick to get ITK to compile with Python wrappings under OS 10.7.5:

  - Rename /usr/include to /usr/_include
  - brew install insighttoolkit --with-python
  - Rename back /usr/_include to /usr/include

This is quite a dirty hack, if somebody has an explanation of why it works, feel free to enlight me. The used formulas to built the binaries are the one in this github repository. The VTK formula should be the same as the one in the official homebrew-science repository, the ITK formula is adapted for compilation under OS 10.7.5.

## Possible problems and Warnings

 - I did not try to use this ITK binaries to build a C++ app with it. Just tell me whether it does not work.
 - The WrapITK.pth file is manually created in /usr/local/lib/python2.7/site-packages. ITK does not have the same folder structure as VTK. I will try to see whether I can submit a patch for this soon. The problem here is that if you *brew uninstall insighttoolkit*, the WrapITK.pth will stay there ...
 - While tapping this repository you can get the following message :
   
   - Warning: Could not tap imichka/macvtkitkpythonbottles/insighttoolkit over homebrew/science/insighttoolkit
   - Warning: Could not tap imichka/macvtkitkpythonbottles/vtk over homebrew/science/vtk
   
   Don't worry thats normal, you can ignore it.

## Future of this project

There are some discussions continuing to provide better support for Python wrapping. This is only a temporary solution I provide so that we can still use ITK on OS 10.9, which leaves some time to fix the wrapping problem.
