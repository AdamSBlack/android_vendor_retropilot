PRODUCT_COPY_FILES += \
    vendor/retropilot/retros/etc/permissions/privapp-permissions-retropilot.xml:system/etc/permissions/privapp-permissions-retropilot.xml \
    vendor/retropilot/retros/etc/init/init.retros.rc:system/etc/init/init.retros.rc \
    vendor/retropilot/retros/etc/init/superuser.rc:system/etc/init/init.retros.rc \
    vendor/retropilot/retros/etc/retros/files.tar.xz:system/etc/retros/files.tar.xz \
    vendor/retropilot/retros/bin/retros_launch.sh:system/bin/retros_launch.sh \
    vendor/retropilot/retros/bin/retros_userspace.sh:system/bin/retros_userspace.sh \
    vendor/retropilot/retros/bin/retros_sshd.sh:system/bin/retros_sshd.sh \
    vendor/retropilot/retros/bin/retros_android_settings.sh:system/bin/retros_android_settings.sh \
    vendor/retropilot/retros/bin/busybox:system/bin/busybox \
    vendor/retropilot/retros/xbin/su:system/xbin/su \
    vendor/retropilot/retros/bootanimation.zip:system/media/bootanimation.zip 

    
PRODUCT_PACKAGES += \
    termux

