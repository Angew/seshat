# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

file(REMOVE_RECURSE ${Binary})
file(MAKE_DIRECTORY ${Binary})

if(GeneratorToolset)
	set(GeneratorToolset -T ${GeneratorToolset})
endif()

execute_process(
	COMMAND ${CMAKE_COMMAND}
		-G ${Generator}
		${GeneratorToolset}
		-DCMAKE_BUILD_TYPE=${BuildType}
		-DPathToSeshat=${PathToSeshat}
		${Source}
	WORKING_DIRECTORY ${Binary}
	RESULT_VARIABLE Result
)

if(Result GREATER 0 OR Result LESS 0)
	message(FATAL_ERROR "Generation failed with exit code ${Result}")
elseif(NOT Result EQUAL 0)
	message(FATAL_ERROR "Generation could not start: ${Result}")
endif()


function(CheckFileCreated File)
	if(NOT EXISTS ${File})
		message(FATAL_ERROR "File ${File} was not created")
	endif()
endfunction()

function(CheckFileOmitted File)
	if(EXISTS ${File})
		message(FATAL_ERROR "File ${File} was created unexpectedly")
	endif()
endfunction()

function(CheckFileUntouched File)
	file(READ ${File} Contents)
	string(STRIP "${Contents}" Contents)
	if(NOT Contents STREQUAL "/*safe*/")
		message(FATAL_ERROR "File ${File} was clobbered")
	endif()
endfunction()

set(Hallmark "/*safe*/")


CheckFileCreated(${Source}/missing1.c)
CheckFileCreated(${Source}/missing2.c)

CheckFileOmitted(${Source}/missing3.c)
CheckFileOmitted(${Source}/missing4.c)

CheckFileUntouched(${Source}/existing1.c)
CheckFileUntouched(${Binary}/existing2.c)
CheckFileUntouched(${Source}/../extra/existing3.c)

file(GLOB Files "${Source}/*")
foreach(File IN LISTS Files)
	string(FIND ${File} "$" Index)
	if(Index GREATER -1)
		CheckFileOmitted(${File})
	endif()
endforeach()
