# Copyright 2017 Petr Kmoch
# Licensed under the Boost Software License Version 1.0
# See accompanying file LICENSE or http://www.boost.org/LICENSE_1_0.txt

if(Seshat_INCLUDED)
	return()
endif()

set(Seshat_INCLUDED TRUE)


set(Seshat_AUTO_CREATE_MISSING_SOURCES NO CACHE STRING "Controls whether seshat_auto_create_missing_sources() checks for missing files. Set to \"ONCE\" to perform check on next configure only")
set_property(
	CACHE Seshat_AUTO_CREATE_MISSING_SOURCES
	PROPERTY STRINGS
	YES ONCE NO
)

if(Seshat_AUTO_CREATE_MISSING_SOURCES)
	macro(seshat_auto_create_missing_sources)
		seshat_create_missing_sources(${ARGN})
	endmacro()
	if(Seshat_AUTO_CREATE_MISSING_SOURCES STREQUAL "ONCE")
		set_property(
			CACHE Seshat_AUTO_CREATE_MISSING_SOURCES
			PROPERTY VALUE
			NO
		)
	endif()
else()
	macro(seshat_auto_create_missing_sources)
	endmacro()
endif()

function(seshat_create_missing_sources)
	foreach(Target IN LISTS ARGN)
		get_target_property(Sources ${Target} SOURCES)
		get_target_property(SourceDir ${Target} SOURCE_DIR)
		if(NOT SourceDir MATCHES "/$")
			set(SourceDir "${SourceDir}/")
		endif()
		foreach(File IN LISTS Sources)
			string(FIND ${File} "$<" IdxGenex)
			if(IdxGenex EQUAL -1)
				get_filename_component(File ${File} ABSOLUTE BASE_DIR ${SourceDir})
				string(FIND ${File} ${SourceDir} IdxSource)
				if(IdxSource EQUAL 0)
					get_source_file_property(IsGenerated ${File} GENERATED)
					if(NOT IsGenerated AND NOT EXISTS ${File})
						file(WRITE ${File} "")
						if(Seshat_VERBOSE)
							message(STATUS "Seshat: Created missing source file ${File}")
						endif()
					endif()
				endif()
			endif()
		endforeach()
	endforeach()
endfunction()



function(seshat_target_consume_interface Target Arg)
	if(Arg STREQUAL "BEFORE")
		set(Before TRUE)
		set(Args ${ARGN})
		list(GET Args 0 Arg)
	else()
		set(Before FALSE)
		set(Args ${Arg} ${ARGN})
	endif()
	if(NOT (Arg STREQUAL "INTERFACE" OR Arg STREQUAL "PUBLIC" OR Arg STREQUAL "PRIVATE"))
		message(FATAL_ERROR "seshat_target_consume_interface(): Expected PRIVATE, PUBLIC, or INTERFACE, got \"${Arg\"")
	endif()
	foreach(Arg IN LISTS Args)
		if(Arg STREQUAL "INTERFACE")
			set(Interface TRUE)
			set(Private FALSE)
		elseif(Arg STREQUAL "PUBLIC")
			set(Interface TRUE)
			set(Private TRUE)
		elseif(Arg STREQUAL "PRIVATE")
			set(Interface FALSE)
			set(Private TRUE)
		else()
			
		endif()
	endforeach()
endfunction()
