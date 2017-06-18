# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

file(REMOVE_RECURSE ${Binary})
file(MAKE_DIRECTORY ${Binary})

if(GeneratorToolset)
	set(GeneratorToolset -T ${GeneratorToolset})
endif()


function(RunCMake ResultVar OutputVar ErrorVar)
	execute_process(
		COMMAND ${CMAKE_COMMAND}
			-G ${Generator}
			${GeneratorToolset}
			-DCMAKE_BUILD_TYPE=${BuildType}
			-DPathToSeshat=${PathToSeshat}
			${ARGN}
			${Source}
		WORKING_DIRECTORY ${Binary}
		RESULT_VARIABLE Result
		OUTPUT_VARIABLE Output
		OUTPUT_STRIP_TRAILING_WHITESPACE
		ERROR_VARIABLE Error
		ERROR_STRIP_TRAILING_WHITESPACE
	)
	if(Result GREATER 0 OR Result LESS 0 OR Result EQUAL 0)
		set(${ResultVar} ${Result} PARENT_SCOPE)
		set(${OutputVar} "${Output}" PARENT_SCOPE)
		set(${ErrorVar} "${Error}" PARENT_SCOPE)
	else()
		message(FATAL_ERROR "Generation could not start: ${Result}")
	endif()
endfunction()


RunCMake(Result Stdout Stderr)
if(NOT (Result GREATER 0 AND Stderr MATCHES "Cannot find source file:[ \t\r\n]*missing1.c"))
	message(FATAL_ERROR "Clean run: expected missing file to fail")
endif()

RunCMake(Result Stdout Stderr -DSeshat_AUTO_CREATE_MISSING_SOURCES=NO)
if(NOT (Result GREATER 0 AND Stderr MATCHES "Cannot find source file:[ \t\r\n]*missing1.c"))
	message(FATAL_ERROR "NO: expected missing file to fail")
endif()

RunCMake(Result Stdout Stderr)
if(NOT (Result GREATER 0 AND Stderr MATCHES "Cannot find source file:[ \t\r\n]*missing1.c"))
	message(FATAL_ERROR "Run after NO: expected missing file to fail")
endif()

RunCMake(Result Stdout Stderr -DSeshat_AUTO_CREATE_MISSING_SOURCES=ONCE)
if(NOT Result EQUAL 0)
	message(FATAL_ERROR "ONCE: run failed")
endif()

RunCMake(Result Stdout Stderr)
if(NOT (Result GREATER 0 AND Stderr MATCHES "Cannot find source file:[ \t\r\n]*missing1.c"))
	message(FATAL_ERROR "Run after ONCE: expected missing file to fail")
endif()

RunCMake(Result Stdout Stderr -DSeshat_AUTO_CREATE_MISSING_SOURCES=YES)
if(NOT Result EQUAL 0)
	message(FATAL_ERROR "YES: run failed")
endif()

RunCMake(Result Stdout Stderr)
if(NOT Result EQUAL 0)
	message(FATAL_ERROR "Run after YES: run failed")
endif()
