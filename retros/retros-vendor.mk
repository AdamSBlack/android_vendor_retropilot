

@echo "anger"
$(warning $(LOCAL_PATH))

PRODUCT_COPY_FILES += \
    vendor/retropilot/retros/etc/permissions/privapp-permissions-retropilot.xml:system/etc/permissions/privapp-permissions-retropilot.xml
PRODUCT_PACKAGES += \
    termux