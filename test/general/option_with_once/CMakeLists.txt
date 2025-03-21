# Copyright 2025 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt


add_test(General:option_with_once:defaults
	COMMAND ${CMAKE_COMMAND} -DBinaryDir=${CMAKE_CURRENT_BINARY_DIR}/defaults -P ${CMAKE_CURRENT_LIST_DIR}/test-defaults.cmake
)
