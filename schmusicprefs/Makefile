ARCHS = arm64 arm64e
TARGET = iphone:11.2:8.0
DEBUG = 0
SYSROOT = $(THEOS)/sdks/iPhoneOS11.2.sdk

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SchmusicPrefs

SchmusicPrefs_FILES = SMPRootListController.m
SchmusicPrefs_INSTALL_PATH = /Library/PreferenceBundles
SchmusicPrefs_FRAMEWORKS = UIKit
SchmusicPrefs_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
SchmusicPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SchmusicPrefs.plist$(ECHO_END)
