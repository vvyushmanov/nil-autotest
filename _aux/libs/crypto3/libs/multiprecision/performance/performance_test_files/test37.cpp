///////////////////////////////////////////////////////////////
//  Copyright 2019 John Maddock. Distributed under the Boost
//  Software License, Version 1.0. (See accompanying file
//  LICENSE_1_0.txt or copy at https://www.boost.org/LICENSE_1_0.txt

#include "../performance_test.hpp"
#if defined(TEST_MPFR)
#include <nil/crypto3/multiprecision/mpfr.hpp>
#endif

void test37() {
#ifdef TEST_MPFR
    test<nil::crypto3::multiprecision::mpfr_float_100>("mpfr_float", 100);
#endif
}