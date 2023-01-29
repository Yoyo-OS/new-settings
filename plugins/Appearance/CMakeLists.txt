cmake_minimum_required(VERSION 3.14)

project(AppearancePlugin LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Gui Quick REQUIRED Dbus Xml X11Extras Concurrent)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Gui REQUIRED Xml X11Extras Concurrent)
find_package(Freetype REQUIRED)
pkg_search_module(FontConfig REQUIRED fontconfig IMPORTED_TARGET)


add_library(AppearancePlugin SHARED
    ../../include/yoyo-settings/dataObject.h
    appearance.cpp
    qml/qml.qrc
    fonts.cpp
    kxftconfig.cpp
    fontsmodel.cpp
    background.cpp
    appearanceplugin.cpp
    appearanceplugin.h
    appearanceplugin.json
)

target_link_libraries(AppearancePlugin PRIVATE
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::DBus
    Qt${QT_VERSION_MAJOR}::Xml
    Qt${QT_VERSION_MAJOR}::X11Extras
    Qt${QT_VERSION_MAJOR}::Concurrent
    PkgConfig::FontConfig
    )

target_compile_definitions(AppearancePlugin PRIVATE AppearancePlugin_LIBRARY)

install(TARGETS AppearancePlugin DESTINATION lib/yoyoos/setting/plugins/)
