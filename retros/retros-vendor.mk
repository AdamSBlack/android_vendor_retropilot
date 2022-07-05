# include $(CLEAR_VARS)
# LOCAL_MODULE := dumbspinner
# LOCAL_MODULE_OWNER := retropilot
# LOCAL_SRC_FILES := app/dumbspinner/dumbspinner.apk
# LOCAL_CERTIFICATE := platform
# LOCAL_MODULE_TAGS := optional
# LOCAL_MODULE_CLASS := APPS
# LOCAL_DEX_PREOPT := false
# LOCAL_MODULE_SUFFIX := .apk
# include $(BUILD_PREBUILT)

 $(call inherit-product, vendor/retropilot/retros/sepolicy/sepolicy.mk)

PRODUCT_COPY_FILES += \
    vendor/retropilot/retros/etc/permissions/privapp-permissions-retropilot.xml:system/etc/permissions/privapp-permissions-retropilot.xml \
    vendor/retropilot/retros/etc/init/init.retros.rc:system/etc/init/init.retros.rc \
    vendor/retropilot/retros/etc/init/superuser.rc:system/etc/init/init.retros.rc \
    vendor/retropilot/retros/etc/retros/files.tar.xz:system/etc/retros/files.tar.xz \
    vendor/retropilot/retros/bin/retros_launch.sh:system/bin/retros_launch.sh \
    vendor/retropilot/retros/bin/retros_userspace.sh:system/bin/retros_userspace.sh \
    vendor/retropilot/retros/bin/retros_sshd.sh:system/bin/retros_sshd.sh \
    vendor/retropilot/retros/bin/retros_android_settings.sh:system/bin/retros_android_settings.sh \
    vendor/retropilot/retros/bin/retros_git.sh:system/bin/retros_git.sh \
    vendor/retropilot/retros/bin/busybox:system/bin/busybox \
    vendor/retropilot/retros/xbin/su:system/xbin/su \
    vendor/retropilot/retros/bootanimation.zip:system/media/bootanimation.zip 
    
PRODUCT_PACKAGES += \
    termux \
    dumbspinner
