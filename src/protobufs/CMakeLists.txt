#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

add_library(noiseprotobufs
    protobufs.c
    )

target_include_directories(noiseprotobufs PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>")
