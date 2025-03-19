# Copyright 2025 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt


include_guard(GLOBAL)


function(Seshat_option_with_once Name Help)
	if(ARGN)
		set(Default ${ARGV2})
	else()
		set(Default OFF)
	endif()
	string(REPLACE "!Seshat" "Using the value \"ONCE\" enables this only for the next CMake run." Help "${Help}")
	set(${Name} ${Default} CACHE STRING "${Help}")
	set_property(CACHE ${Name} PROPERTY STRINGS "ON;OFF;ONCE")
	if(${Name} STREQUAL "ONCE")
		set_property(CACHE ${Name} PROPERTY VALUE ON)
		cmake_language(EVAL CODE "
			cmake_language(DEFER DIRECTORY ${CMAKE_SOURCE_DIR} CALL set_property CACHE ${Name} PROPERTY VALUE OFF)
		")
	endif()
endfunction()
