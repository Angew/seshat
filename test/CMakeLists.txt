# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

function(AddCopiedTest Name)
	file(COPY ${Name} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	add_test(
		NAME ${Name}
		COMMAND ${CMAKE_COMMAND}
			-DBuildType=$<CONFIGURATION>
			-DPathToSeshat=${Seshat_SOURCE_DIR}/modules
			-DSource=${CMAKE_CURRENT_BINARY_DIR}/${Name}/source
			-DBinary=${CMAKE_CURRENT_BINARY_DIR}/${Name}/binary
			-DGenerator=${CMAKE_GENERATOR}
			-DGeneratorToolset=${CMAKE_GENERATOR_TOOLSET}
			-P ${CMAKE_CURRENT_SOURCE_DIR}/Test_${Name}.cmake
	)
endfunction()


AddCopiedTest(create_missing_sources)

AddCopiedTest(auto_create_missing_sources)
