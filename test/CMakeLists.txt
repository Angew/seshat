# Copyright 2025 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt


enable_testing()


set(PackageForTestsDir ${CMAKE_CURRENT_BINARY_DIR}/installation)

add_custom_target(InstallForTests ALL
	COMMENT "Installed for testing to ${PackageForTestsDir}"
	COMMAND
		${CMAKE_COMMAND} -E rm -rf ${PackageForTestsDir}
	COMMAND
		${CMAKE_COMMAND}
		--install ${Seshat_BINARY_DIR}
		--config $<CONFIG>
		--prefix ${PackageForTestsDir}
	VERBATIM
)


add_subdirectory(general/option_with_once)
