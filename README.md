Setup a cross compiler and XLW build environment on Ubuntu 14.04LTS
-------------------------------------------------------------------

1) Install the mingw-w64 package:
sudo apt-get install mingw-w64

It is about 100mb of downloads.  While it is downloading, do the following.

2) Download and extract a zip/tarball of the xlw repository from:
http://sourceforge.net/p/xlw/code/

3) Correct the directory paths in xlw/make/make.targets, near the end.  

4) Build the interface generator by going to xlw/build/gcc-make: 
make -f InterfaceGenerator.mak BUILD=RELEASE

This will give InterfaceGenerator.exe in xlw/build/gcc-make/RELEASE/BIN

Note that the file is a Linux executable, despite the .exe ending.

I emphasise, you will be running this file on Linux.  Use your standard GCC 
compiler at this step.

5) Check the interface generator works OK with the example provided.

cd xlw/examples/Start Here - Example/common_source
../../../build/gcc-make/RELEASE/BIN/InterfaceGenerator.exe Test.h xlwTest.cpp

This should generate a xlwTest.cpp, which calls all the XLW specific code to
interface your functions.

5) By now, the download and install of mingw-w64 will have finished.  

The compiler executable is x86_64-w64-mingw32-g++.

6) The file NCmatrices.* sometimes has an uppercase 'm', sometimes not. 
Linux is case sensitive, of course.  I went for uppercase.  Thus I changed

* The filename in include/xlw directory
* The filename in the src directory.  
* Within the XLW.mak makefile.
* Within NCmatrices.cpp.

Similarly,
IXlfOperShared.h has inconsistent case for the 'O'.
xlfFuncDesc.h (and a few others) have inconsistent case for the 'X' in XlFunctionRegistration.cpp

Possibly it is easiest to fix these by repeatedly trying to recompile until you get them all (see step below).

7) Go back to the XLW build directory.  The cross compiler prefix 
'x86_64-w64-mingw32-' is already set in the makefiles, you just 
need PLATFORM=x64.  I.e. type:

make -f XLW.mak BUILD=RELEASE PLATFORM=x64

I also made a 32 bit target plaform:
make -f XLW.mak BUILD=RELEASE PLATFORM=x32

This will make a file libxlw-gcc-s-5_0_2f0.a in the lib/x64 directory.
Possibly there are some bad filename lower/upper case problems that I missed.

8) Now you have the interface file and the library.  Build the example 
Excel plugin as follows:


make PLATFORM=x64 BUILD=RELEASE XLW=../../../..
make PLATFORM=x32 BUILD=RELEASE XLW=../../../..


9) For my own plugin, I do
(When the interface changes):
./xlw/xlw/build/gcc-make/RELEASE/BIN/InterfaceGenerator.exe Excel.h Excel.cpp

then:
make -f XLL.mak PLATFORM=x32 BUILD=RELEASE XLW=xlw




# XLW-linux-cross-compile
