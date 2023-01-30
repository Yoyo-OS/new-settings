cmake_minimum_required(VERSION 3.14)

project(SystemPlugin LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Gui Quick REQUIRED Dbus X11Extras)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Gui REQUIRED X11Extras)
find_package(KF5Config)
find_package(X11 REQUIRED)


add_library(SystemPlugin SHARED
    ../../include/yoyo-settings/dataObject.h
    qml/qml.qrc
    time/timezonemodel.cpp
    time/timezonedata.h
    datetime/time.cpp
    datetime/timezonedata.h
    datetime/timezonemap.cpp
    datetime/timedated_interface.cpp
    cursor/cursorthememodel.cpp
    cursor/cursortheme.cpp
    cursor/mouse.cpp
    accessibility.cpp
    battery.cpp
    batteryhistorymodel.cpp
    defaultapplications.cpp
    desktopproperties.cpp
    language.cpp
    notifications.cpp
    password.cpp
    powermanager.cpp
    touchpad.cpp
    systemplugin.cpp
    systemplugin.h
    systemplugin.json
)

target_link_libraries(SystemPlugin PRIVATE
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::DBus
    Qt${QT_VERSION_MAJOR}::X11Extras
    ${X11_LIBRARIES}
    X11::X11
    X11::Xi
    X11::Xcursor
    KF5::ConfigCore
    )

target_compile_definitions(SystemPlugin PRIVATE SystemPlugin_LIBRARY)

install(TARGETS SystemPlugin DESTINATION lib/yoyoos/setting/plugins/)
