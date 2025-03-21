# Copyright 2025 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt


# Arguments:
# Generator
# BinaryDir
# ArchitectureArg [optional]
# ToolsetArg [optional]


execute_process(
	COMMAND ${CMAKE_COMMAND}
		-S ${CMAKE_CURRENT_LIST_DIR}/defaults -B ${BinaryDir}
		-G ${Generator} ${ArchitectureArg} ${ToolsetArg}
		--fresh
)

execute_process(
	# inspect it
)
