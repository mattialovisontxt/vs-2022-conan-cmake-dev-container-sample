# settings.cmake

# Macro to apply common settings to one or more CMake targets.
#
# Usage:
#   apply_settings(TARGET target_name_1 target_name_2 ...)
#
# Parameters:
#   TARGET: List of target names to apply settings to.
#
# Example:
#   apply_settings(TARGET my_target_1 my_target_2)
#
macro(apply_settings)
    set(options "")
    set(singleValueArgs)
    set(multiValueArgs TARGET)
    cmake_parse_arguments(APPLY_SETTINGS "${options}" "${singleValueArgs}" "${multiValueArgs}" ${ARGN})

    foreach(target IN LISTS APPLY_SETTINGS_TARGET)
        if(NOT TARGET ${target})
            message(FATAL_ERROR "Target ${target} does not exist.")
        endif()

        if(MSVC)
            target_compile_options(${target} PUBLIC /W4 /Zi)
            add_link_options(${target})
        else()
            target_compile_options(${target} PUBLIC -Wall -Wextra -pedantic -Wno-unknown-pragmas)
        endif()

        set_property(TARGET ${target} PROPERTY COMPILE_WARNING_AS_ERROR ON)
    endforeach()
endmacro()
