
include(CMakeFindDependencyMacro)
# Library: crypto3::algebra
find_dependency(crypto3::algebra)
# Library: crypto3::hash
find_dependency(crypto3::hash)
# Library: crypto3::mac
find_dependency(crypto3::mac)
# Library: crypto3::stream
find_dependency(crypto3::stream)
# Library: marshalling::crypto3_algebra
find_dependency(marshalling::crypto3_algebra)
# Library: Boost::container
find_dependency(boost_container 1.76.0)
# Library: Boost::random
find_dependency(boost_random 1.76.0)
# Library: Boost::system
find_dependency(boost_system 1.76.0)
# Library: Boost::unit_test_framework
find_dependency(boost_unit_test_framework 1.76.0)

include("${CMAKE_CURRENT_LIST_DIR}/crypto3-random-targets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/properties-crypto3-random-targets.cmake")
