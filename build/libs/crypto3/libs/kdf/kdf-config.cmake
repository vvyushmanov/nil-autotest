
include(CMakeFindDependencyMacro)
# Library: crypto3::block
find_dependency(crypto3::block)
# Library: crypto3::hash
find_dependency(crypto3::hash)
# Library: crypto3::mac
find_dependency(crypto3::mac)

include("${CMAKE_CURRENT_LIST_DIR}/crypto3-kdf-targets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/properties-crypto3-kdf-targets.cmake")
