# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 3.1)
project(SeshatTest_auto_create_missing_sources LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH ${PathToSeshat})
include(Seshat)

file(REMOVE
	${CMAKE_CURRENT_SOURCE_DIR}/missing1.c
)

add_executable(exe
	existing1.c
	missing1.c
)

seshat_auto_create_missing_sources(exe)
