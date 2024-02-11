///////////////////////////////////////////////////////////////
//  Copyright 2019 John Maddock. Distributed under the Boost
//  Software License, Version 1.0. (See accompanying file
//  LICENSE_1_0.txt or copy at https://www.boost.org/LICENSE_1_0.txt

#include "../performance_test.hpp"
#if defined(TEST_CPP_BIN_FLOAT)
#include <nil/crypto3/multiprecision/cpp_bin_float.hpp>
#endif

void test32() {
#ifdef TEST_CPP_BIN_FLOAT
    test<nil::crypto3::multiprecision::cpp_bin_float_50>("cpp_bin_float", 50);
#endif
}