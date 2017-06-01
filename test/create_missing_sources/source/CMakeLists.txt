# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 3.1)
project(SeshatTest_create_missing_sources LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH ${PathToSeshat})
include(Seshat)

file(WRITE
	${CMAKE_CURRENT_BINARY_DIR}/existing2.c
	"/*safe*/"
)
file(REMOVE
	${CMAKE_CURRENT_SOURCE_DIR}/missing1.c
	${CMAKE_CURRENT_SOURCE_DIR}/missing2.c
	${CMAKE_CURRENT_SOURCE_DIR}/missing3.c
	${CMAKE_CURRENT_BINARY_DIR}/missing4.c
)

add_custom_command(
	OUTPUT
		${CMAKE_CURRENT_SOURCE_DIR}/missing3.c
		${CMAKE_CURRENT_BINARY_DIR}/missing4.c
	COMMAND ${CMAKE_COMMAND} --version
)

add_library(obj OBJECT obj.c)
add_executable(exe
	existing1.c
	${CMAKE_CURRENT_BINARY_DIR}/existing2.c
	${CMAKE_CURRENT_SOURCE_DIR}/../extra/existing3.c
	missing1.c
	${CMAKE_CURRENT_SOURCE_DIR}/missing2.c
	${CMAKE_CURRENT_SOURCE_DIR}/missing3.c
	${CMAKE_CURRENT_BINARY_DIR}/missing4.c
	$<TARGET_OBJECTS:obj>
)

seshat_create_missing_sources(exe)
