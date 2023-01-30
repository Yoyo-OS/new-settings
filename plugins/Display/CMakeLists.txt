cmake_minimum_required(VERSION 3.14)

project(DisplayPlugin LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Gui Quick REQUIRED Dbus)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Gui REQUIRED)


add_library(DisplayPlugin SHARED
    ../../include/yoyo-settings/dataObject.h
    qml/qml.qrc
    brightness.cpp
    displayplugin.cpp
    displayplugin.h
    displayplugin.json
)

target_link_libraries(DisplayPlugin PRIVATE
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::DBus
    )

target_compile_definitions(DisplayPlugin PRIVATE DisplayPlugin_LIBRARY)

install(TARGETS DisplayPlugin DESTINATION lib/yoyoos/setting/plugins/)
