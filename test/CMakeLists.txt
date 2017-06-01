# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

file(COPY create_missing_sources DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
add_test(
	NAME create_missing_sources
	COMMAND ${CMAKE_COMMAND}
		-DBuildType=$<CONFIGURATION>
		-DPathToSeshat=${Seshat_SOURCE_DIR}/modules
		-DSource=${CMAKE_CURRENT_BINARY_DIR}/create_missing_sources/source
		-DBinary=${CMAKE_CURRENT_BINARY_DIR}/create_missing_sources/binary
		-DGenerator=${CMAKE_GENERATOR}
		-DGeneratorToolset=${CMAKE_GENERATOR_TOOLSET}
		-P ${CMAKE_CURRENT_SOURCE_DIR}/Test_create_missing_sources.cmake
)
