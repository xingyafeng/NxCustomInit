LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_REQUIRED_MODULES := init.rc
LOCAL_MODULE := init.yunovo.rc
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)

include $(BUILD_PREBUILT)

.PHONY: $(LOCAL_MODULE)_INSERT
$(LOCAL_MODULE)_INSERT : $(TARGET_ROOT_OUT)/init.rc
	$(info "---- insert init.yunovo.rc ... " )
	$(shell \
		if [ -f $(TARGET_ROOT_OUT)/init.rc -a -z "`cat $(TARGET_ROOT_OUT)/init.rc | grep init.yunovo.rc | awk -F/ '{print $2}'`"  ];then \
			sed -i -e '/import \/init.environ.rc/a\import /init.yunovo.rc' $(TARGET_ROOT_OUT)/init.rc; \
			sed -i -e "/import \/init.environ.rc/a\import /system/ect/init/init.$(YOV_CUSTOM).$(YOV_PROJECT).rc" $(TARGET_ROOT_OUT)/init.rc; \
		fi \
	)

$(LOCAL_INSTALLED_MODULE) : $(LOCAL_MODULE)_INSERT
