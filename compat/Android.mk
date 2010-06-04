BUILD_PAND:=1
BUILD_HIDD:=1
BUILD_DUND:=1

common_C_INCLUDES:= \
        $(LOCAL_PATH)/../include \
        $(LOCAL_PATH)/../common \
        $(LOCAL_PATH)/../gdbus \
        $(LOCAL_PATH)/../src \
        $(call include-path-for, glib) \
        $(call include-path-for, dbus)

common_CFLAGS:= \
        -DVERSION=\"4.47\" \
        -DSTORAGEDIR=\"/data/misc/bluetoothd\" \
        -DCONFIGDIR=\"/etc/bluez\" \
        -DANDROID \
        -DNEED_PPOLL \
        -D__S_IFREG=0100000  # missing from bionic stat.h

common_SHARED_LIBRARIES := \
        libbluetooth \
        libbluetoothd \
        libdbus

ifeq ($(BUILD_PAND),1)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(common_C_INCLUDES)
LOCAL_CFLAGS := $(common_CFLAGS)
LOCAL_SHARED_LIBRARIES := $(common_SHARED_LIBRARIES)
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE := pand

LOCAL_SRC_FILES:= \
        pand.c    \
        bnep.c    \
        sdp.c

include $(BUILD_EXECUTABLE)
endif


ifeq ($(BUILD_HIDD),1)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(common_C_INCLUDES)
LOCAL_CFLAGS := $(common_CFLAGS)
LOCAL_SHARED_LIBRARIES := $(common_SHARED_LIBRARIES)
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE := hidd

LOCAL_SRC_FILES:= \
	hidd.c    \
	sdp.c    \
	fakehid.c

include $(BUILD_EXECUTABLE)
endif

ifeq ($(BUILD_DUND),1)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(common_C_INCLUDES)
LOCAL_CFLAGS := $(common_CFLAGS)
LOCAL_SHARED_LIBRARIES := $(common_SHARED_LIBRARIES)
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE := dund

LOCAL_SRC_FILES:= \
        dund.c \
        sdp.c \
        dun.c \
        msdun.c

include $(BUILD_EXECUTABLE)
endif

