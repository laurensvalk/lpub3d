#####################################################################################
# Automatically generated by qmake (2.01a) Tue 2. Dec 10:46:50 2014
#####################################################################################
QT   += core gui opengl network xml

TEMPLATE = app

greaterThan(QT_MAJOR_VERSION, 4) {
    QT *= printsupport
    QT += concurrent
}

include(../gitversion.pri)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TARGET +=
DEPENDPATH += .
INCLUDEPATH += .
INCLUDEPATH += ../lc_lib/common ../lc_lib/qt ../ldrawini

# If quazip is alredy installed you can suppress building it again by
# adding CONFIG+=quazipnobuild to the qmake arguments
# Update the quazip header path if not installed at default location below
quazipnobuild {
    INCLUDEPATH += /usr/include/quazip
} else {
    INCLUDEPATH += ../quazip
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

HOST_VERSION = $$(PLATFORM_VER)
BUILD_TARGET = $$(TARGET_VENDOR)
BUILD_ARCH   = $$(TARGET_CPU)
!contains(QT_ARCH, unknown):  BUILD_ARCH = $$QT_ARCH
else: isEmpty(BUILD_ARCH):    BUILD_ARCH = UNKNOWN ARCH
contains(HOST_VERSION, 1320):contains(BUILD_TARGET, suse):contains(BUILD_ARCH, aarch64): DEFINES += OPENSUSE_1320_ARM
if (contains(QT_ARCH, x86_64)|contains(QT_ARCH, arm64)|contains(BUILD_ARCH, aarch64)) {
    ARCH     = 64
    STG_ARCH = x86_64
    LIB_ARCH = 64
} else {
    ARCH     = 32
    STG_ARCH = x86
    LIB_ARCH =
}
if (contains(QT_ARCH, arm)|contains(QT_ARCH, arm64)|contains(BUILD_ARCH, aarch64)): CHIPSET = ARM
else:                                                                               CHIPSET = X86
DEFINES     += VER_ARCH=\\\"$$ARCH\\\"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CONFIG += precompile_header c++11
PRECOMPILED_HEADER += ../lc_lib/common/lc_global.h

QMAKE_CXXFLAGS  += $(Q_CXXFLAGS)
QMAKE_LFLAGS    += $(Q_LDFLAGS)
QMAKE_CFLAGS    += $(Q_CFLAGS)
QMAKE_CFLAGS_WARN_ON += -Wno-unused-parameter -Wno-unknown-pragmas

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

win32 {

    DEFINES += _CRT_SECURE_NO_WARNINGS _CRT_SECURE_NO_DEPRECATE=1 _CRT_NONSTDC_NO_WARNINGS=1
    QMAKE_EXT_OBJ = .obj
    PRECOMPILED_SOURCE = ../lc_lib/common/lc_global.cpp
    CONFIG += windows
    LIBS += -ladvapi32 -lshell32 -lopengl32 -lwininet -luser32 -lz

    QMAKE_TARGET_COMPANY = "LPub3D Software"
    QMAKE_TARGET_DESCRIPTION = "LPub3D - An LDraw Building Instruction Editor."
    QMAKE_TARGET_COPYRIGHT = "Copyright (c) 2015-2018 Trevor SANDY"
    QMAKE_TARGET_PRODUCT = "LPub3D ($$join(ARCH,,,bit))"
    RC_LANG = "English (United Kingdom)"
    RC_ICONS = "lpub3d.ico"

} else {

    LIBS += -lz
    # Use installed quazip library
    quazipnobuild: LIBS += -lquazip
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

unix:!macx: TARGET = lpub3d
else: TARGET = LPub3D
STG_TARGET   = $$TARGET
DIST_TARGET  = $$TARGET

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

static {                                     # everything below takes effect with CONFIG ''= static
    CONFIG+= static
    LIBS += -static
    BUILD = Static
    DEFINES += STATIC
    DEFINES += QUAZIP_STATIC                 # this is so the compiler can detect quazip static
    macx: TARGET = $$join(TARGET,,,_static)  # this adds an _static in the end, so you can seperate static build from non static build
    win32: TARGET = $$join(TARGET,,,s)       # this adds an s in the end, so you can seperate static build from non static build
} else {
    BUILD = Shared
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Note on x11 platforms you can also pre-install install quazip ($ sudo apt-get install libquazip-dev)
# If quazip is already installed, set CONFIG+=quazipnobuild to use installed library

CONFIG(debug, debug|release) {
    DEFINES += QT_DEBUG_MODE
    BUILD += Debug
    ARCH_BLD = bit_debug
    macx {
        LDRAWINI_LIB = LDrawIni_debug
        QUAZIP_LIB = QuaZIP_debug
    }
    win32 {
        LDRAWINI_LIB = LDrawInid161
        QUAZIP_LIB = QuaZIPd07
    }
    unix:!macx {
        LDRAWINI_LIB = ldrawinid
        QUAZIP_LIB = quazipd
    }
    # executable target name
    macx: TARGET = $$join(TARGET,,,_debug)
    else: TARGET = $$join(TARGET,,,d$$VER_MAJOR$$VER_MINOR)
} else {
    BUILD += Release
    ARCH_BLD = bit_release
    macx {
        LDRAWINI_LIB = LDrawIni
        QUAZIP_LIB = QuaZIP
    }
    win32 {
        LDRAWINI_LIB = LDrawIni161
        QUAZIP_LIB = QuaZIP07
    }
    unix:!macx {
        LDRAWINI_LIB = ldrawini
        QUAZIP_LIB = quazip
    }
    # executable target name
    !macx:!win32: TARGET = $$join(TARGET,,,$$VER_MAJOR$$VER_MINOR)
}
# build path component
DESTDIR = $$join(ARCH,,,$$ARCH_BLD)
# library target name
LIBS += -L$$OUT_PWD/../ldrawini/$$DESTDIR -l$$LDRAWINI_LIB
!quazipnobuild: LIBS += -L$$OUT_PWD/../quazip/$$DESTDIR -l$$QUAZIP_LIB


MAN_PAGE = $$join(TARGET,,,.1)
message("~~~ MAIN_APP $$join(ARCH,,,bit) $${BUILD} $${CHIPSET} ~~~")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PRECOMPILED_DIR = $$DESTDIR/.pch
OBJECTS_DIR     = $$DESTDIR/.obj
MOC_DIR         = $$DESTDIR/.moc
RCC_DIR         = $$DESTDIR/.qrc
UI_DIR          = $$DESTDIR/.ui

#~~file distributions~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Install 3rd party executables, documentation and resources.
# When building on macOS, it is necessary to add CONFIG+=dmg at
# Projects/Build Steps/Qmake/'Additional arguments' because,
# macOS build will also bundle all deliverables.

# If you wish to build and install on Linux or Windows, then
# set deb|rpm|pkg|exe respectively.
macx: build_package = $$(INSTALL_3RD_PARTY)
else: build_package = $$(LP3D_BUILD_PKG)
if(deb|rpm|pkg|dmg|exe|contains(build_package, yes)) {
    args = deb rpm pkg dmg exe
    for(arg, args) {
        contains(CONFIG, $$arg): opt = $$arg
    }
    isEmpty(opt): opt = $$build_package
    message("~~~ BUILD DISTRIBUTION PACKAGE: $$opt ~~~")

    THIRD_PARTY_DIST_DIR_PATH = $$(LP3D_DIST_DIR_PATH)
    !exists($$THIRD_PARTY_DIST_DIR_PATH) {
        unix:!macx: DIST_DIR=lpub3d_linux_3rdparty
        macx: DIST_DIR=lpub3d_macos_3rdparty
        win32: DIST_DIR=lpub3d_windows_3rdparty
        THIRD_PARTY_DIST_DIR_PATH = $$_PRO_FILE_PWD_/../../$$DIST_DIR
        message("~~~ INFO - THIRD_PARTY_DIST_DIR_PATH WAS NOT SPECIFIED, USING $$THIRD_PARTY_DIST_DIR_PATH ~~~")
    }
    message("~~~ 3RD PARTY DISTRIBUTION REPO $$THIRD_PARTY_DIST_DIR_PATH ~~~")

    if (unix|copy3rd) {
        CONFIG+=copy3rdexe
        CONFIG+=copy3rdexeconfig
        CONFIG+=copy3rdcontent
    }
    win32 {
        CONFIG+=stagewindistcontent
        CONFIG+=stage3rdexe
        CONFIG+=stage3rdexeconfig
        CONFIG+=stage3rdcontent
    }
}

VER_LDVIEW     = ldview-4.3
VER_LDGLITE    = ldglite-1.3
VER_POVRAY     = lpub3d_trace_cui-3.8
DEFINES       += VER_LDVIEW=\\\"$$VER_LDVIEW\\\"
DEFINES       += VER_LDGLITE=\\\"$$VER_LDGLITE\\\"
DEFINES       += VER_POVRAY=\\\"$$VER_POVRAY\\\"

win32:include(winfiledistro.pri)
macx:include(macosfiledistro.pri)
unix:!macx:include(linuxfiledistro.pri)

#~~ includes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

include(../lc_lib/lc_lib.pri)
include(../qslog/QsLog.pri)
include(../qsimpleupdater/QSimpleUpdater.pri)
include(../LPub3DPlatformSpecific.pri)

#~~ inputs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

HEADERS += \
    aboutdialog.h \
    application.h \
    annotations.h \
    archiveparts.h \
    backgrounddialog.h \
    backgrounditem.h \
    borderdialog.h \
    callout.h \
    calloutbackgrounditem.h \
    color.h \
    commands.h \
    commonmenus.h \
    csiitem.h \
    dependencies.h \
    dialogexportpages.h \
    dividerdialog.h \
    editwindow.h \
    excludedparts.h \
    fadestepcolorparts.h \
    globals.h \
    gradients.h \
    highlighter.h \
    hoverpoints.h \
    ldrawfiles.h \
    ldsearchdirs.h \
    lpub.h \
    lpub_preferences.h \
    messageboxresizable.h \
    meta.h \
    metagui.h \
    metaitem.h \
    metatypes.h \
    name.h \
    numberitem.h \
    pagebackgrounditem.h \
    pageattributetextitem.h \
    pageattributepixmapitem.h \
    pairdialog.h \
    pageorientationdialog.h \
    pagesizedialog.h \
    parmshighlighter.h \
    parmswindow.h \
    paths.h \
    placement.h \
    placementdialog.h \
    pli.h \
    pliannotationdialog.h \
    pliconstraindialog.h \
    plisortdialog.h \
    plisubstituteparts.h \
    pointer.h \
    pointeritem.h \
    preferencesdialog.h \
    range.h \
    range_element.h \
    ranges.h \
    ranges_element.h \
    ranges_item.h \
    render.h \
    reserve.h \
    resize.h \
    resolution.h \
    rotateiconitem.h \
    rx.h \
    scaledialog.h \
    step.h \
    textitem.h \
    threadworkers.h \
    updatecheck.h \
    where.h \
    sizeandorientationdialog.h \
    version.h

SOURCES += \
    aboutdialog.cpp \
    application.cpp \
    annotations.cpp \
    archiveparts.cpp \
    assemglobals.cpp \
    backgrounddialog.cpp \
    backgrounditem.cpp \
    borderdialog.cpp \
    callout.cpp \
    calloutbackgrounditem.cpp \
    calloutglobals.cpp \
    color.cpp \
    commands.cpp \
    commonmenus.cpp \
    csiitem.cpp \
    dependencies.cpp \
    dialogexportpages.cpp \
    dividerdialog.cpp \
    editwindow.cpp \
    excludedparts.cpp \
    fadestepcolorparts.cpp \
    fadestepglobals.cpp \
    formatpage.cpp \
    gradients.cpp \
    highlighter.cpp \
    hoverpoints.cpp \
    ldrawfiles.cpp \
    ldsearchdirs.cpp \
    lpub.cpp \
    lpub_preferences.cpp \
    meta.cpp \
    metagui.cpp \
    metaitem.cpp \
    multistepglobals.cpp \
    numberitem.cpp \
    openclose.cpp \
    pagebackgrounditem.cpp \
    pageattributetextitem.cpp \
    pageattributepixmapitem.cpp \
    pageglobals.cpp \
    pageorientationdialog.cpp \
    pagesizedialog.cpp \
    pairdialog.cpp \
    parmshighlighter.cpp \
    parmswindow.cpp \
    paths.cpp \
    placement.cpp \
    placementdialog.cpp \
    pli.cpp \
    pliannotationdialog.cpp \
    pliconstraindialog.cpp \
    pliglobals.cpp \
    plisortdialog.cpp \
    plisubstituteparts.cpp \
    pointeritem.cpp \
    preferencesdialog.cpp \
    printfile.cpp \
    projectglobals.cpp \
    range.cpp \
    range_element.cpp \
    ranges.cpp \
    ranges_element.cpp \
    ranges_item.cpp \
    render.cpp \
    resize.cpp \
    resolution.cpp \
    rotateiconitem.cpp \
    rotate.cpp \
    rx.cpp \
    scaledialog.cpp \
    sizeandorientationdialog.cpp \
    step.cpp \
    textitem.cpp \
    threadworkers.cpp \
    traverse.cpp \
    updatecheck.cpp \
    undoredo.cpp

FORMS += \
    preferences.ui \
    aboutdialog.ui \
    dialogexportpages.ui

OTHER_FILES += \
    Info.plist \
    lpub3d.desktop \
    org.trevorsandy.lpub3d.appdata.xml \
    lpub3d.xml \
    lpub3d.sh \
    $$lower($$MAN_PAGE) \
    lpub3d.1 \
    ../README.md \
    ../.gitignore \
    ../.travis.yml \
    ../appveyor.yml

include(otherfiles.pri)

RESOURCES += \
    lpub3d.qrc

DISTFILES += \
    ldraw_document.icns

# Suppress warnings
QMAKE_CFLAGS_WARN_ON += -Wall -W \
    -Wno-deprecated-declarations \
    -Wno-unused-parameter \
    -Wno-sign-compare
macx {
QMAKE_CFLAGS_WARN_ON += \
    -Wno-overloaded-virtual \
    -Wno-sometimes-uninitialized \
    -Wno-self-assign \
    -Wno-unused-result
} else: win32 {
QMAKE_CFLAGS_WARN_ON += \
   -Wno-misleading-indentation
QMAKE_CXXFLAGS_WARN_ON += \
   -Wno-maybe-uninitialized \
   -Wno-implicit-fallthrough \
   -Wno-unused-result
} else {
QMAKE_CFLAGS_WARN_ON += \
    -Wno-strict-aliasing
}
QMAKE_CXXFLAGS_WARN_ON += $${QMAKE_CFLAGS_WARN_ON}

# set config to enable initial update check
# CONFIG+=update_check
update_check: DEFINES += DISABLE_UPDATE_CHECK

#message($$CONFIG)
