
include(CMakeFindDependencyMacro)
# Library: Boost::container
find_dependency(boost_container 1.76.0)
# Library: Boost::random
find_dependency(boost_random 1.76.0)
# Library: Boost::system
find_dependency(boost_system 1.76.0)
# Library: Boost::unit_test_framework
find_dependency(boost_unit_test_framework 1.76.0)

include("${CMAKE_CURRENT_LIST_DIR}/crypto3-block-targets.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/properties-crypto3-block-targets.cmake")
