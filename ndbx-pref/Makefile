TARGET := iphone:clang:latest:7.0
export TARGET=iphone:clang:6.0
ARCHS= armv7

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ndbx-pref

ndbx-pref_FILES = NDBXPrefRootListController.m
ndbx-pref_FRAMEWORKS = UIKit
ndbx-pref_PRIVATE_FRAMEWORKS = Preferences
ndbx-pref_INSTALL_PATH = /Library/PreferenceBundles
ndbx-pref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
