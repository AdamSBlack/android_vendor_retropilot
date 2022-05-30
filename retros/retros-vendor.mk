

@echo "anger"
$(warning $(LOCAL_PATH))

PRODUCT_COPY_FILES += \
    vendor/retropilot/retros/etc/permissions/privapp-permissions-retropilot.xml:system/etc/permissions/privapp-permissions-retropilot.xml \
     vendor/retropilot/retros/priv-app/termux/termux-app_v0.118.0+github-debug_arm64-v8a.apk:system/priv-app/termux/termux-app_v0.118.0+github-debug_arm64-v8a.apk

PRODUCT_PACKAGES += \
    termux