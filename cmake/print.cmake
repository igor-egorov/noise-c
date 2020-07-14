#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

function(print)
    message(STATUS "[${CMAKE_PROJECT_NAME}] ${ARGV}")
endfunction()

function(fatal_error)
    message(FATAL_ERROR "[${CMAKE_PROJECT_NAME}] ${ARGV}")
endfunction()
