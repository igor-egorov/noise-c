#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

set(BISON_DEFINES ${CMAKE_SOURCE_DIR}/tools/protoc/proto3-grammar.h)
set(BISON_OUTPUT ${CMAKE_SOURCE_DIR}/tools/protoc/proto3-grammar.c)
if(BISON_FOUND)
    ADD_CUSTOM_COMMAND(
        OUTPUT ${BISON_OUTPUT}
        COMMAND ${BISON_EXECUTABLE}
        --defines=${BISON_DEFINES}
        --output=${BISON_OUTPUT}
        -d
        ${CMAKE_SOURCE_DIR}/tools/protoc/proto3-grammar.y
        COMMENT "Generating proto3-grammar.c(h)"
    )
endif()

set(FLEX_OUTPUT ${CMAKE_SOURCE_DIR}/tools/protoc/proto3-lexer.c)
if(FLEX_FOUND)
    add_custom_command(
        OUTPUT ${FLEX_OUTPUT}
        COMMAND ${FLEX_EXECUTABLE}
        --outfile=${FLEX_OUTPUT}
        ${CMAKE_SOURCE_DIR}/tools/protoc/proto3-lexer.l
        COMMENT "Generating proto3-lexer.c"
    )
endif()

add_executable(noise-protoc
    main.c
    proto3-ast.c
    proto3-generate-c.c
    ${BISON_OUTPUT}
    ${FLEX_OUTPUT}
    )
