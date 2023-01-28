cmake_minimum_required(VERSION 3.14)

project(demoB LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Gui Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Gui REQUIRED)


add_library(demoB SHARED
    ../../include/dataObject.h
    test.cpp
    qml/qml.qrc
    demob.cpp
    demob.h
    demoB.json
)

target_link_libraries(demoB PRIVATE Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Quick)

target_compile_definitions(demoB PRIVATE demoB_LIBRARY)

install(TARGETS demoB DESTINATION lib/yoyoos/setting/plugins/)
