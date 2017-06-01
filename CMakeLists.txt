# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 3.1)

project(Seshat LANGUAGES NONE)

set(SeshatBuild_TEST ON CACHE BOOL "Generate Seshat tests")

if(SeshatBuild_TEST)
	enable_testing()
	add_subdirectory(test)
endif()
