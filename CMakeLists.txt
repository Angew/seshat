# Copyright 2025 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt


cmake_minimum_required(VERSION 3.19)

project(Seshat
	VERSION 0.1
	LANGUAGES NONE
)

include(CMakePackageConfigHelpers)

set(PackageBuildRoot ${CMAKE_CURRENT_BINARY_DIR}/package)

set(PackageDir_Modules .)

configure_package_config_file(
	package/SeshatConfig.cmake.in
	${PackageBuildRoot}/SeshatConfig.cmake
	PATH_VARS PackageDir_Modules
	INSTALL_DESTINATION .
)

write_basic_package_version_file(
	${PackageBuildRoot}/SeshatConfigVersion.cmake
	COMPATIBILITY SameMinorVersion
	ARCH_INDEPENDENT
)

add_custom_command(
	OUTPUT ${PackageBuildRoot}/${PackageDir_Modules}/SeshatGeneral.cmake
	COMMENT "Copying SeshatGeneral.cmake to package"
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/modules/SeshatGeneral.cmake ${PackageBuildRoot}/${PackageDir_Modules}
	DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/modules/SeshatGeneral.cmake
	VERBATIM
)

add_custom_target(Modules ALL
	COMMENT "Ensured modules are up-to-date"
	DEPENDS ${PackageBuildRoot}/${PackageDir_Modules}/SeshatGeneral.cmake
)