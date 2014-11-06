VTK ITK SimpleITK Python Homebrew tap
=====================================

This page provides binaries (Homebrew bottles) of VTK, ITK and SimpleITK for OS X (10.8, 10.9 and 10.10). They are compiled against Homebrew's python (2.7.8).

The different binaries were compiled with some specific options, look at the formulas to know which ones. (HDF5, FFTW, ...). Note that the formula's names are **imichka-package**, so that they do not conflict with the formulas in homebrew science. This ensures that the brew upgrade command will update your packages if there are updates here.

## Current versions

  - imichka-vtk : VTK 6.1.0, C++ and Python
  - imichka-insighttoolkit : ITK 4.6.1, C++ only
  - imichka-insighttoolkit-wrapitk : ITK 4.6.1, Python only
  - imichka-simpleitk : SimpleITK 0.8.0, Python

## How to install SimpleITK

**Important note: VTK and ITK need to be installed for SimpleITK to work. Please install all the packages manually following the order given here:**

  - brew tap iMichka/MacVTKITKPythonBottles
  - brew install iMichka/MacVTKITKPythonBottles/imichka-vtk
  - brew install iMichka/MacVTKITKPythonBottles/imichka-insighttoolkit
  - brew install iMichka/MacVTKITKPythonBottles/imichka-simpleitk

## Important note

The imichka-insighttoolkit-wrapitk binaries can not be used to compile c++ code. You can use the imichka-insighttoolkit binaries for this. Though; you can not have two ITK's installed at the same time. Use the brew link/unlink command to manually switch from one to another.

## Possible problems and Warnings

 - The WrapITK.pth file is manually created in /usr/local/lib/python2.7/site-packages. The problem here is that if you *brew uninstall imichka-insighttoolkit-wrapitk*, the WrapITK.pth will stay there ...
 - On OS X 10.9 and 10.0 you will get the following warning, just ignore it.
```
Warning: imichka-insighttoolkit dependency boost was built with a different C++ standard
library (libc++ from clang). This could cause problems at runtime.
```

## Why unofficial binaries ?

The advantage is that you don't have to wait for the compilation to finish.

This project was initially setup to provide ITK on OS X with Python wrappings; which is difficult. Because of incompatibilities between GCCXML and Clang (GCCXML is converting the highly templated ITK C++ code to XML files, which are then converted for the Python wrapping), it is very tedious to install ITK on OS X.
Incidentally, the compilation time can be very long (up to 2 hours for ITK on slow computers), so a fast installation through binaries is always welcome.

I found a way to trick GCCXML into finding the right include headers to be able to compile ITK with Python wrappers on OS 10.7. For OS 10.9, the same binary is used as the one compiled under 10.8. This "just works" for the python bindings.(It's no more possible to compile ITK 4.5 under 10.9).

My trick to get ITK to compile with Python wrappings under OS 10.8:

  - Rename /usr/include to /usr/_include
  - See notes below for the formula setup
  - Build bottles
  - Rename back /usr/_include to /usr/include
  - Reset the xcode.rb file back

Go back to commit 5d79541 (19 mai 2014).
Homebrew fixed their env after this commit, so my hack will no more work. Bottling from the old homebrew version is still possible.
You also need to disable the hdf5 installation; and manually copy-paste formulas to be up to date (like libpng).

Build commands:

- brew install imichka-vtk --with-python --with-qt --build-bottle
- brew install imichka-insighttoolkit --with-review --build-bottle
- brew install imichka-insighttoolkit-wrapitk --with-python --build-bottle
- brew install imichka-insighttoolkit-simpleitk --build-bottle

## Future of this project

There are some discussions continuing to provide better support for Python wrapping for ITK. This is only a temporary solution I provide so that we can still use ITK on OS 10.9, which leaves some time to fix the wrapping problem.

