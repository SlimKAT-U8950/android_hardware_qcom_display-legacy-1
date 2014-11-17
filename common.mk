#Common headers
common_includes := $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libgralloc
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libgenlock
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/liboverlay
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libcopybit
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libqdutils
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libhwcomposer
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libexternal
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libqservice
common_includes += $(call project-path-for,qcom-display)/$(TARGET_BOARD_PLATFORM)/libvirtual


ifeq ($(TARGET_USES_POST_PROCESSING),true)
    common_flags     += -DUSES_POST_PROCESSING
    common_includes += $(TARGET_OUT_HEADERS)/pp/inc
endif


#Common libraries external to display HAL
common_libs := liblog libutils libcutils libhardware

ifeq ($(TARGET_USES_POST_PROCESSING),true)
    common_libs += libmm-abl
endif

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifeq ($(TARGET_NO_HW_VSYNC),true)
    common_flags += -DNO_HW_VSYNC
endif

ifeq ($(TARGET_USES_QCOM_BSP),true)
    common_flags += -DQCOM_BSP
endif

common_deps :=
kernel_includes :=

ifneq ($(TARGET_PREBUILT_HEADERS),true)
ifeq ($(call is-vendor-board-platform,QCOM),true)
     common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
     kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
 endif
endif
