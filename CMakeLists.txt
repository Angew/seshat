# Copyright 2025 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 3.11)

project(Seshat
	VERSION 0.1
	LANGUAGES NONE
)

include(CMakePackageConfigHelpers)

set(PackageBuildRoot ${CMAKE_CURRENT_BINARY_DIR}/package)

configure_package_config_file(
	package/SeshatConfig.cmake.in
	${PackageBuildRoot}/SeshatConfig.cmake
	INSTALL_DESTINATION .
)

write_basic_package_version_file(
	${PackageBuildRoot}/SeshatConfigVersion.cmake
	COMPATIBILITY SameMinorVersion
	ARCH_INDEPENDENT
)
