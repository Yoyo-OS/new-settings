cmake_minimum_required(VERSION 3.14)

project(demoA LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Gui Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Gui REQUIRED)


add_library(demoA SHARED
    ../../include/dataObject.h
    test.cpp
    qml/qml.qrc
    demoa.cpp
    demoa.h
    demoA.json
)

target_link_libraries(demoA PRIVATE Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Quick)

target_compile_definitions(demoA PRIVATE DEMOA_LIBRARY)

install(TARGETS demoA DESTINATION lib/yoyoos/setting/plugins/)
