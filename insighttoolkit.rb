require 'formula'

class Insighttoolkit < Formula
  homepage 'http://www.itk.org'
  url 'http://downloads.sourceforge.net/project/itk/itk/4.5/InsightToolkit-4.5.0.tar.gz'
  sha1 '64a01e9464b6bd298ec218420967301590501dc2'

  head 'git://itk.org/ITK.git'
  
  bottle do
    root_url 'http://download.sf.net/project/macvtkitkpythonbottles/itk'
    revision 1
    sha1 '01da44da2b222ab57695d63edf930f9714c69a86' => :mavericks
    sha1 '01da44da2b222ab57695d63edf930f9714c69a86' => :mountain_lion
    sha1 '01da44da2b222ab57695d63edf930f9714c69a86' => :lion
  end

  depends_on 'cmake' => :build
  depends_on 'vtk' => :build
  depends_on :python => :optional

  option 'examples', 'Compile and install various examples'
  option 'with-opencv-bridge', 'Include OpenCV bridge'
  option 'with-itkv3-compatibility', 'Include ITKv3 compatibility'
  
  def patches
    # Add a patch for ITK 4.5 which fixes the install path for the .pth file
    DATA unless build.head?
  end

  def install
    args = std_cmake_args + %W[
      -DBUILD_TESTING=OFF
      -DBUILD_SHARED_LIBS=ON
    ]
    
    args << ".."
    args << '-DBUILD_EXAMPLES=' + ((build.include? 'examples') ? 'ON' : 'OFF')
    args << '-DModule_ITKVideoBridgeOpenCV=' + ((build.include? 'with-opencv-bridge') ? 'ON' : 'OFF')
    args << '-DITKV3_COMPATIBILITY:BOOL=' + ((build.include? 'with-itkv3-compatibility') ? 'ON' : 'OFF')

    mkdir 'itk-build' do
      python do
        args = args + %W[
          -DITK_WRAP_PYTHON=ON
          -DModule_ITKVtkGlue=ON
          -DITK_USE_SYSTEM_GCCXML=OFF
        ]
        # Do not use the system's gccxml. ITK will download a more recent one.
        # Cmake picks up the system's python dylib, even if we have a brewed one.
        args << "-DPYTHON_LIBRARY='#{python.libdir}/lib#{python.xy}.dylib'"
        # The make and make install have to be inside the python do loop
        # because the PYTHONPATH is defined by this block (and not outside)
        system "cmake", *args
        system "make install"
      end
      if not python then  # no python bindings
        system "cmake", *args
        system "make install"
      end
    end
  end

  def post_install
    # Put manually the pth file in the site-packages folder
    # Waiting for modification of the ITK install script to have the following structure :
    # /Cellar/insighttoolkit/4.5.0/lib/python/site-packages
    if pour_bottle? and Formula.factory('python').installed?
      File.open("#{HOMEBREW_PREFIX}/lib/python2.7/site-packages/WrapITK.pth", 'w') {|f| f.write("#{HOMEBREW_PREFIX}/Cellar/insighttoolkit/4.5.0/lib/ITK-4.5/Python") }
    end
  end

end


__END__
diff --git a/Wrapping/Generators/Python/CMakeLists.txt b/Wrapping/Generators/Python/CMakeLists.txt
index a0c13a4..7c5f5e2 100644
--- a/Wrapping/Generators/Python/CMakeLists.txt
+++ b/Wrapping/Generators/Python/CMakeLists.txt
@@ -234,7 +233,8 @@ if(PYTHON_EXECUTABLE)
   )
 endif()
 
-string(REGEX REPLACE "\\\\" "/" py_spp_nobackslashes "${py_spp}")
+string(REGEX REPLACE "\n" "" py_spp_no_newline "${py_spp}")
+string(REGEX REPLACE "\\\\" "/" py_spp_nobackslashes "${py_spp_no_newline}")
 set(PY_SITE_PACKAGES_PATH "${py_spp_nobackslashes}" CACHE PATH "Python site-packages directory to install a .pth file pointing at WrapITK Python modules.")
 mark_as_advanced(PY_SITE_PACKAGES_PATH)
 if(PY_SITE_PACKAGES_PATH)
--