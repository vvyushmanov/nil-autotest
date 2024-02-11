
include(CMakeFindDependencyMacro)
# Library: crypto3::multiprecision
find_dependency(crypto3::multiprecision)
# Library: crypto3::algebra
find_dependency(crypto3::algebra)
# Library: marshalling::crypto3_multiprecision
find_dependency(marshalling::crypto3_multiprecision)
# Library: marshalling::core
find_dependency(marshalling::core)

include("${CMAKE_CURRENT_LIST_DIR}/marshalling-crypto3_algebra-targets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/properties-marshalling-crypto3_algebra-targets.cmake")
