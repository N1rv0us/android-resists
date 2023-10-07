LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# Loader lib
LOCAL_MODULE    := RevenyInjector
LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)

LOCAL_SRC_FILES := Inject.cpp \

LOCAL_LDLIBS := -llog -landroid

include $(BUILD_SHARED_LIBRARY)

#Test lib
include $(CLEAR_VARS)

LOCAL_MODULE    := Test
LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)

LOCAL_SRC_FILES := test/Test.cpp \

LOCAL_LDLIBS := -llog -landroid

include $(BUILD_SHARED_LIBRARY)