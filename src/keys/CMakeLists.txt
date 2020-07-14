#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

set(NOISE_CERT_PROTO_C ${CMAKE_BINARY_DIR}/src/keys/certificate.c)
set(NOISE_CERT_PROTO_H ${CMAKE_BINARY_DIR}/src/keys/certificate.h)
add_custom_command(
    OUTPUT ${NOISE_CERT_PROTO_C} ${NOISE_CERT_PROTO_H}
    COMMAND ${CMAKE_BINARY_DIR}/tools/protoc/noise-protoc
    -c ${NOISE_CERT_PROTO_C}
    -h ${NOISE_CERT_PROTO_H}
    -l ${CMAKE_SOURCE_DIR}/COPYING
    ${CMAKE_SOURCE_DIR}/doc/noise-certificate.proto
    COMMENT "Generating proto includes for noise-certificate.proto"
    VERBATIM
)

add_custom_target(noisekeys-proto-dep DEPENDS
    noise-protoc
    ${NOISE_CERT_PROTO_C}
    ${NOISE_CERT_PROTO_H}
    )


add_library(noisekeys
    ${NOISE_CERT_PROTO_C}
    loader.c
    )
add_dependencies(noisekeys noisekeys-proto-dep)

target_include_directories(noisekeys PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/src/keys>")
