TWEAK_NAME = SampleTweak

SampleTweak_FILES = Tweak.xm
SampleTweak_FRAMEWORKS = UIKit


include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

# Here we can set the preferences bundle directory as a tweak aggregate
SUBPROJECTS += preferences
include $(THEOS_MAKE_PATH)/aggregate.mk
