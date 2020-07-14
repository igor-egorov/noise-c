#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

cmake_minimum_required(VERSION 3.12)

include(cmake/HunterGate.cmake)
HunterGate(
    URL "https://github.com/soramitsu/soramitsu-hunter/archive/v0.23.256-soramitsu1.tar.gz"
    SHA1 3bfec823bc49b595b9ad0bb0bc32f05a45f0cfbe
    LOCAL
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

#cmake_policy(SET CMP0048 NEW)
project(noise-c
        VERSION 0.0.1
        LANGUAGES C CXX)

include(cmake/print.cmake)

#if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#    include_directories(SYSTEM /usr/local/include)
#    link_directories(/usr/local/lib)
#    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/usr/local/lib")
##    set(CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES /usr/local/lib ${CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES})
#endif()

option(USE_OPENSSL "Compile with use of OpenSSL" OFF)
option(USE_LIBSODIUM "Compile with use of Libsodium" ON)

if (USE_OPENSSL)
    print("OpenSSL enabled")
    # this will gone when hunter comes
#    if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#        set(OPENSSL_ROOT_DIR "/usr/local/opt/openssl")
#        set(OPENSSL_INCLUDE_DIR "/usr/local/opt/openssl/include")
#    endif()
    hunter_add_package(OpenSSL)
    find_package(OpenSSL CONFIG REQUIRED)
endif()

if (USE_LIBSODIUM)
    print("Libsodium enabled")
    hunter_add_package(libsodium)
    find_library(libsodium CONFIG REQUIRED)
else()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DED25519_CUSTOMHASH -DED25519_CUSTOMRANDOM")
endif()


if (USE_OPENSSL)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUSE_OPENSSL=1")
endif()
if (USE_LIBSODIUM)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUSE_LIBSODIUM=1")
endif()


set(GOLDILOCKS_ARCH "x86_64" CACHE STRING "Arch specifier to pick the right crypto impl")

print("C flags: ${CMAKE_C_FLAGS}")
#print("CXX flags: ${CMAKE_CXX_FLAGS}")

include_directories(
    SYSTEM
    ${PROJECT_SOURCE_DIR}/include
)

add_subdirectory(src)
add_subdirectory(tools)

#add_subdirectory(tests)
#add_subdirectory(examples)
#doc
