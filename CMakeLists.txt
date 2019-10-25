cmake_minimum_required(VERSION 3.14)
project(MLPV)

set(CMAKE_CXX_STANDARD 11)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)


FLEX_TARGET(lexer ${CMAKE_SOURCE_DIR}/src/lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp)
BISON_TARGET(parser ${CMAKE_SOURCE_DIR}/src/parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp)
ADD_FLEX_BISON_DEPENDENCY(lexer parser)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/src)

add_executable(mlpv src/main.cpp ${FLEX_lexer_OUTPUTS} ${BISON_parser_OUTPUTS} src/funcs.hpp)