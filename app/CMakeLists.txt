cmake_minimum_required(VERSION 3.14)

project(yoyo-settings VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt5 COMPONENTS Core Quick QuickControls2 LinguistTools REQUIRED Xml DBus)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick LinguistTools REQUIRED)


# load interfaces
set(INTERFACES_FILES
                ../include/interfaceplugin.h
                ../include/pluginMetaData.h
                ../include/dataObject.h
)

set(PROJECT_SOURCES
        src/main.cpp
        src/qtpluginsmanager.cpp
        src/qtpluginsmanagerprivate.cpp
        src/application.cpp
        src/qml/qml.qrc
)

qt5_add_dbus_adaptor(DBUS_SOURCES
                     src/com.yoyo.SettingsUI.xml
                     src/application.h Application)
set_source_files_properties(${DBUS_SOURCES} PROPERTIES SKIP_AUTOGEN ON)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(yoyo-settings
        MANUAL_FINALIZATION
        ${INTERFACES_FILES}
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET yoyo-settings APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation

else()
    if(ANDROID)
        add_library(yoyo-settings SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(yoyo-settings
          ${INTERFACES_FILES}
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(yoyo-settings
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(yoyo-settings
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::DBus)

set_target_properties(yoyo-settings PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(yoyo-settings)
    qt_finalize_executable(yoyo-settings)
endif()

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
