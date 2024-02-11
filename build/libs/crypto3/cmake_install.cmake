# Install script for directory: /opt/zkllvm-template/libs/crypto3

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/opt/zkllvm-template/build/libs/crypto3/libs/algebra/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/block/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/codec/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/containers/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/hash/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/kdf/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/mac/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/math/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/modes/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/multiprecision/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/passhash/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/pbkdf/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/pkmodes/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/pkpad/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/pubkey/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/random/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/stream/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/vdf/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/zk/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/marshalling/algebra/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/marshalling/core/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/marshalling/multiprecision/cmake_install.cmake")
  include("/opt/zkllvm-template/build/libs/crypto3/libs/marshalling/zk/cmake_install.cmake")

endif()

