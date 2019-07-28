cmake_minimum_required(VERSION 3.12)
project(Tutorial)

set(CMAKE_CXX_STANDARD 11)

set(Tutorial_VERSION_MAJOR 1)
set(Tutorial_VERSION_MINOR 0)

include(${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)

check_function_exists (log HAVE_LOG)
check_function_exists (exp HAVE_EXP)

configure_file(
        "${PROJECT_SOURCE_DIR}/TutorialConfig.h.in"
        "${PROJECT_BINARY_DIR}/TutorialConfig.h"
)

option(USE_MYMATH "Use tutorial provided math implementation" ON)
if (USE_MYMATH)
    message("use my math")
    include_directories("${PROJECT_SOURCE_DIR}/MathFunctions")
    add_subdirectory(MathFunctions)
    set(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions) #list(APPEND EXTRA_ILBS MathFunctions)
endif (USE_MYMATH)

include_directories(${PROJECT_BINARY_DIR})

add_executable(Tutorial main.cpp)
message("extra libs: ${EXTRA_LIBS}")
target_link_libraries(Tutorial ${EXTRA_LIBS})

# install binary && head file
install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" DESTINATION include)

include(CTest)

# does the application run
add_test (TutorialRuns Tutorial 25)
# does it sqrt of 25
add_test (TutorialComp25 Tutorial 25)
set_tests_properties (TutorialComp25 PROPERTIES PASS_REGULAR_EXPRESSION "25 is 5")
# does it handle negative numbers
add_test (TutorialNegative Tutorial -25)
set_tests_properties (TutorialNegative PROPERTIES PASS_REGULAR_EXPRESSION "-25 is 0")
# does it handle small numbers
add_test (TutorialSmall Tutorial 0.0001)
set_tests_properties (TutorialSmall PROPERTIES PASS_REGULAR_EXPRESSION "0.0001 is 0.01")
# does the usage message work?
add_test (TutorialUsage Tutorial)
set_tests_properties (TutorialUsage PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number")

#define a macro to simplify adding tests, then use it
macro (do_test arg result)
    add_test (TutorialComp${arg} Tutorial ${arg})
    set_tests_properties (TutorialComp${arg}
            PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endmacro (do_test)

# do a bunch of result based tests
do_test (25 "25 is 5")
do_test (-25 "-25 is 0")

include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_DIRECTORY ${PROJECT_SOURCE_DIR}/pack)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(PROJECT_VERSION_FULL "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_IGNORE_FILES
        ${PROJECT_SOURCE_DIR}/build
        ${PROJECT_SOURCE_DIR}/cmake-build-debug
        ${PROJECT_SOURCE_DIR}/.idea
        ${PROJECT_SOURCE_DIR}/.git
        ${PROJECT_SOURCE_DIR}/.gitignore
        ${PROJECT_SOURCE_DIR}/.vscode)
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_SOURCE_PACKAGE_FILE_NAME tutorial-${PROJECT_VERSION_FULL})


include (CPack)
