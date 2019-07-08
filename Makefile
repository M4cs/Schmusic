ARCHS = arm64 arm64e
TARGET = iphone:11.2:8.0
DEBUG = 0
SYSROOT = $(THEOS)/sdks/iPhoneOS11.2.sdk

INSTALL_TARGET_PROCESSES = Music

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Schmusic

Schmusic_FILES = Tweak.x
Schmusic_FRAMEWORKS = UIKit QuartzCore CoreLocation CoreImage
Schmusic_PRIVATE_FRAMEWORKS = MediaRemote
Schmusic_EXTRA_FRAMEWORKS = Cephei
Schmusic_CFLAGS += -fobjc-arc  -Wno-deprecated -Wno-deprecated-declarations -Wno-error -Wno-enum-conversion -Wno-return-type -Wno-logical-op-parentheses -I$(THEOS_PROJECT_DIR)/headers

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += schmusicprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
