cmake_minimum_required(VERSION 3.24)

include("${SETTINGS_FILE}")

set(PROJECT "TestSample")

project(${PROJECT}
    VERSION 1.0.0
    LANGUAGES CXX
)

# External Dependecies
find_package(Threads REQUIRED)
find_package(fmt REQUIRED)

# Define project name
set(TARGET_NAME "TestSample")

# Add an object library target called ATBOSManager
add_executable(${TARGET_NAME})

# Specify target properties
set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD 17)

apply_settings(TARGET ${TARGET_NAME})

set_target_properties(${TARGET_NAME}
	PROPERTIES
		VERSION			${PROJECT_VERSION}
		SOVERSION		${PROJECT_VERSION_MAJOR}
		LINKER_LANGUAGE CXX
)

# Link external dependecies
target_link_libraries(${TARGET_NAME}
    PUBLIC
        Threads::Threads
        fmt::fmt
)

# Sources
target_sources(${TARGET_NAME}
    PRIVATE
		source/main.cpp
		source/main.hpp
)

target_include_directories(${TARGET_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

install(TARGETS ${TARGET_NAME}
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include
)