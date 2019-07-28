add_library(MathFunctions MathFunctions.cpp)
option(USE_MYMATH "Use tutorial provided math implemention" ON)
if (USE_MYMATH)
    # does this system provide the log and exp functions?
    include(CheckSymbolExists)
    set(CMAKE_REQUIRED_LIBRARIES "m")
    check_symbol_exists(log "math.h" HAVE_LOG)
    check_symbol_exists(exp "math.h" HAVE_EXP)

    add_executable(MakeTable MakeTable.cpp)

    # add the command to generate the source code
    add_custom_command(
            OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
            COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
            DEPENDS MakeTable
    )
    include_directories(${CMAKE_CURRENT_BINARY_DIR})
    message("cmake current: ${CMAKE_CURRENT_BINARY_DIR}")
    # library that just does sqrt
    add_library(SqrtLibrary STATIC
            mysqrt.cpp
            ${CMAKE_CURRENT_BINARY_DIR}/Table.h
            )

    # state that we depend on our binary dir to find Table.h
    target_include_directories(SqrtLibrary PRIVATE
            ${CMAKE_CURRENT_BINARY_DIR}
            )

#    set_target_properties(SqrtLibrary PROPERTIES
#            POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
#            )

    target_compile_definitions(SqrtLibrary PRIVATE
            "$<$<BOOL:${HAVE_LOG}>:HAVE_LOG>"
            "$<$<BOOL:${HAVE_EXP}>:HAVE_EXP>"
            )
    #target_link_libraries(MathFunctions PRIVATE SqrtLibrary)

endif (USE_MYMATH)

#target_compile_definitions(MathFunctions PRIVATE "$<$<BOOL:${USE_MYMATH}>:USE_MYMATH>")
#
## define the symbol stating we are using the declspec(dllexport) when
##building on windows
#target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")

install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)