require "formula"

class ImichkaSimpleitk < Formula
  homepage "http://www.simpleitk.org"
  url "https://downloads.sourceforge.net/project/simpleitk/SimpleITK/0.8.0/Source/SimpleITK-0.8.0.tar.gz"
  sha1 "7f62f397d0b85dfe52bf2fd66155e5b3cdc95af9"
  head "https://github.com/SimpleITK/SimpleITK.git"

  bottle do
    root_url 'http://download.sf.net/project/macvtkitkpythonbottles/simpleitk'
    revision 1
    sha1 'daa8937d8d87e10a8a95329a4bd5e3f63ab86f50' => :yosemite
    sha1 'ac9a465ff2dd4082a9d5f58b8339b6df5ae88cf2' => :mavericks
    sha1 'f6b922db51acdbb147195f14107c2b5a60377287' => :mountain_lion
  end

  depends_on "cmake" => :build
  depends_on "iMichka/MacVTKITKPythonBottles/imichka-insighttoolkit" => [:build, "with-review"]
  depends_on "swig" => :build
  depends_on :python

  option "examples", "Compile and install various examples"

  def install

    # Define the .git folder as simpleitk relies on it at build.
    ENV["GIT_DIR"] = cached_download/".git" if build.head?

    args = std_cmake_args + %W[
      -DBUILD_TESTING=OFF
    ]
    args << "-DBUILD_EXAMPLES=" + ((build.include? "examples") ? "ON" : "OFF")

    # CMake picks up the system's python dylib, even if we have a brewed one.
    args << "-DPYTHON_LIBRARY='#{%x(python-config --prefix).chomp}/lib/libpython2.7.dylib'"

    system "cmake", ".", *args
    system "make", "install"

    ENV.prepend_create_path "PYTHONPATH", lib+"python2.7/site-packages"
    system "python", "Wrapping/PythonPackage/setup.py", "install", "--prefix=#{prefix}", "--record=installed.txt", "--single-version-externally-managed"
  end

  test do
    system "python", "-c", "import SimpleITK"
  end

end
