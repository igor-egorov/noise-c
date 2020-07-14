#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

set(NOISE_KEYTOOL_LINK_DEPS )
if (USE_OPENSSL)
    list(APPEND NOISE_KEYTOOL_LINK_DEPS OpenSSL::SSL)
endif()
if (USE_LIBSODIUM)
    list(APPEND NOISE_KEYTOOL_LINK_DEPS libsodium::libsodium)
endif()

add_executable(noise-keytool
    generate.c
    keytool.c
    show.c
    sign.c
    )

target_link_libraries(noise-keytool
    noisekeys
    noiseprotobufs
    noiseprotocol
    ${NOISE_KEYTOOL_LINK_DEPS}
    )

#target_include_directories(noise-keytool PUBLIC
#    "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>")
