include ./XLWVERSION.mak

ifeq ($(BUILD),DEBUG)
LIBRARY = xlw-gcc-s-gd-$(XLWVERSION)
endif
ifeq ($(BUILD),RELEASE)
LIBRARY = xlw-gcc-s-$(XLWVERSION)
endif

ifeq ($(PLATFORM), x64)
INSTALL_DIR = ../../lib/x64
else ifeq ($(PLATFORM), x64)
INSTALL_DIR = ../../lib/x32
else
INSTALL_DIR = ../../lib
endif

LIBTYPE=STATIC

INCLUDE_DIR = ../../include

ifeq ($(PLATFORM), x64)
CXXFLAGS = -DBUILDING_DLL=1  -fexceptions -m32
else
CXXFLAGS = -DBUILDING_DLL=1  -fexceptions
endif

SRC_DIR = ../../src
LIBSRC = ArgList.cpp \
         Dispatcher.cpp \
         DoubleOrNothing.cpp \
         FileConverter.cpp \
         HiResTimer.cpp \
         MJCellMatrix.cpp \
         NCMatrices.cpp \
         PascalStringConversions.cpp \
         PathUpdater.cpp \
         TempMemory.cpp \
         Win32StreamBuf.cpp \
         XlFunctionRegistration.cpp \
         XlfAbstractCmdDesc.cpp \
         XlfArgDesc.cpp \
         XlfArgDescList.cpp \
         XlfCmdDesc.cpp \
         XlfExcel.cpp \
         XlfFuncDesc.cpp \
         XlfOperImpl.cpp \
         XlfOperProperties.cpp \
         XlfRef.cpp \
         XlfServices.cpp \
         xlcall.cpp \
         XlOpenClose.cpp   

MAKEDIR = ../../make
include $(MAKEDIR)/make.rules
include $(MAKEDIR)/make.targets

