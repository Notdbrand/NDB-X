TARGET := iphone:clang:latest:7.0
export TARGET=iphone:clang:6.0
ARCHS= armv7


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ndbx-tweak

ndbx-tweak_FILES = Tweak.x
ndbx-tweak_CFLAGS = -fobjc-arc
TubeRepair-Tweak_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += ndbx-pref
include $(THEOS_MAKE_PATH)/aggregate.mk
