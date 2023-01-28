cmake_minimum_required(VERSION 3.5)
set(PROJECT_NAME yoyo-settings)
project(${PROJECT_NAME})

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT Core Gui Widgets Quick QuickControls2 DBus LinguistTools)

set(TS_FILES translations/*.ts)

find_package(Qt5 REQUIRED ${QT})
# find_package(FishUI REQUIRED)
find_package(PkgConfig REQUIRED)

# 更新 .ts 翻译文件
execute_process(COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/translations/translate_update.sh WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/translations)
file(GLOB TS_FILES translations/*.ts)
file(GLOB HEADERS include/yoyo-settings)

add_subdirectory(app)
add_subdirectory(plugins)

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES} SOURCES ${TS_FILES})
add_dependencies(${PROJECT_NAME} translations)
install(FILES
    yoyo-settings.desktop
    DESTINATION /usr/share/applications/
    COMPONENT Runtime
)
install(FILES ${QM_FILES} DESTINATION /usr/share/${PROJECT_NAME}/translations)

# dev files
set(INCLUDE_INSTALL_DIR include)
install(DIRECTORY ${HEADERS} DESTINATION ${INCLUDE_INSTALL_DIR})

include(CMakePackageConfigHelpers)
configure_package_config_file(YoyoSettingsConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/YoyoSettingsConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/YoyoSettings
    PATH_VARS INCLUDE_INSTALL_DIR)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/YoyoSettingsConfig.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/YoyoSettings)
