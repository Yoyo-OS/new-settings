cmake_minimum_required(VERSION 3.14)

project(NetworkPlugin LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Gui Quick REQUIRED Dbus)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Gui REQUIRED)


add_library(NetworkPlugin SHARED
    ../../include/yoyo-settings/dataObject.h
    qml/qml.qrc
    networkplugin.cpp
    networkproxy.cpp
    networkplugin.h
    networkplugin.json
)

target_link_libraries(NetworkPlugin PRIVATE
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::DBus
    )

target_compile_definitions(NetworkPlugin PRIVATE NetworkPlugin_LIBRARY)

install(TARGETS NetworkPlugin DESTINATION lib/yoyoos/setting/plugins/)
