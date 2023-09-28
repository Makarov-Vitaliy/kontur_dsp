QT += quick	charts concurrent network

CONFIG += c++11
#TODO
#DEFINES+=GIT_VERSION_NUMBER=\\\"$$system(./gitinfo.sh)\\\"

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        channelmodel.cpp \
        localsettings.cpp \
        main.cpp \
        manager.cpp \
        presetmodel.cpp

HEADERS += \
		channelmodel.h \
		localsettings.h \
		manager.h \
		presetmodel.h

RESOURCES += qml.qrc translations.qrc

OUT_RCC=$$PWD/out_rcc
# make rcc before build
linux {
	RCC=$$PWD/tools/rcc
}
linux: android: {
	RCC=$$PWD/tools/rcc
}

TRANSLATIONS += \
	tr/KonturDSP_ru_RU.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.

android {
QT += androidextras

DISTFILES += \
	android/AndroidManifest.xml \
	android/build.gradle \
	android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS +=

SOURCES +=

assets.files += $$files($$OUT_RCC/*.rcc)
assets.path = /assets
INSTALLS += assets
}

extramakercc.target = extra
extramakercc.commands = mkdir -p $$OUT_RCC &\
		$$RCC -binary $$PWD/Resources@1x/resources.qrc -o $$OUT_RCC/resources@1x.rcc &\
		$$RCC -binary $$PWD/Resources@2x/resources.qrc -o $$OUT_RCC/resources@2x.rcc &\
		$$RCC -binary $$PWD/Resources@3x/resources.qrc -o $$OUT_RCC/resources@3x.rcc
extramakercc.depends =

QMAKE_EXTRA_TARGETS += extramakercc
PRE_TARGETDEPS = extra

DISTFILES +=
