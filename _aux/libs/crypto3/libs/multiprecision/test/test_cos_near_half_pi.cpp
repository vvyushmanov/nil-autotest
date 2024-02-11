///////////////////////////////////////////////////////////////
//  Copyright Christopher Kormanyos 2002 - 2011.
//  Copyright 2011 John Maddock. Distributed under the Boost
//  Software License, Version 1.0. (See accompanying file
//  LICENSE_1_0.txt or copy at https://www.boost.org/LICENSE_1_0.txt
//
// This work is based on an earlier work:
// "Algorithm 910: A Portable C++ Multiple-Precision System for Special-Function Calculations",
// in ACM TOMS, {VOL 37, ISSUE 4, (February 2011)} (C) ACM, 2011. http://doi.acm.org/10.1145/1916461.1916469

#ifdef _MSC_VER
#define _SCL_SECURE_NO_WARNINGS
#endif

#include <boost/detail/lightweight_test.hpp>
#include <boost/array.hpp>
#include <boost/math/special_functions/relative_difference.hpp>
#include "test.hpp"

#if !defined(TEST_MPF_50) && !defined(TEST_MPF) && !defined(TEST_CPP_DEC_FLOAT) && !defined(TEST_FLOAT128) && \
    !defined(TEST_CPP_BIN_FLOAT)
#define TEST_MPF_50
#define TEST_CPP_DEC_FLOAT
#define TEST_FLOAT128
#define TEST_CPP_BIN_FLOAT

#ifdef _MSC_VER
#pragma message("CAUTION!!: No backend type specified so testing everything.... this will take some time!!")
#endif
#ifdef __GNUC__
#pragma warning "CAUTION!!: No backend type specified so testing everything.... this will take some time!!"
#endif

#endif

#include <nil/crypto3/multiprecision/mpfr.hpp>

#if defined(TEST_MPF_50)
#include <nil/crypto3/multiprecision/gmp.hpp>
#endif
#ifdef TEST_CPP_DEC_FLOAT
#include <nil/crypto3/multiprecision/cpp_dec_float.hpp>
#endif
#ifdef TEST_FLOAT128
#include <nil/crypto3/multiprecision/float128.hpp>
#endif
#ifdef TEST_CPP_BIN_FLOAT
#include <nil/crypto3/multiprecision/cpp_bin_float.hpp>
#endif

template<class T>
void test() {
    typedef nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::mpfr_float_backend<1000>>
        mpfr_float_1000;

    for (int n = -20; n <= 20; ++n) {
        std::cout << "Testing n = " << n << std::endl;
        T boundary = boost::math::constants::half_pi<T>() * n;
        T val = boundary;
        for (unsigned i = 0; i < 200; ++i) {
            mpfr_float_1000 comparison(val);
            comparison = cos(comparison);
            T found = cos(val);
            T expected = T(comparison);
            BOOST_CHECK_LE(boost::math::epsilon_difference(found, expected), 20);
            // std::cout << std::setprecision(10) << val << std::endl;
            // std::cout << std::setprecision(50) << found << std::endl;
            // std::cout << std::setprecision(50) << comparison << std::endl;
            // std::cout << std::setprecision(50) << expected << std::endl;
            val = boost::math::float_next(val);
        }
        val = boundary;
        for (unsigned i = 0; i < 200; ++i) {
            val = boost::math::float_prior(val);
            mpfr_float_1000 comparison(val);
            comparison = cos(comparison);
            T found = cos(val);
            T expected = T(comparison);
            BOOST_CHECK_LE(boost::math::epsilon_difference(found, expected), 20);
        }
    }
}

int main() {
#ifdef TEST_MPF_50
    test<nil::crypto3::multiprecision::mpf_float_50>();
    test<nil::crypto3::multiprecision::mpf_float_100>();
    nil::crypto3::multiprecision::mpfr_float::default_precision(50);
    test<nil::crypto3::multiprecision::mpf_float>();
    nil::crypto3::multiprecision::mpfr_float::default_precision(100);
    test<nil::crypto3::multiprecision::mpf_float>();
#endif
#ifdef TEST_CPP_DEC_FLOAT
    test<nil::crypto3::multiprecision::cpp_dec_float_50>();
    test<nil::crypto3::multiprecision::cpp_dec_float_100>();
#ifndef SLOW_COMPLER
    // Some "peculiar" digit counts which stress our code:
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<65>>>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<64>>>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<63>>>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<62>>>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<61, long long>>>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<60, long long>>>();
    test<nil::crypto3::multiprecision::number<
        nil::crypto3::multiprecision::cpp_dec_float<59, long long, std::allocator<char>>>>();
    test<nil::crypto3::multiprecision::number<
        nil::crypto3::multiprecision::cpp_dec_float<58, long long, std::allocator<char>>>>();
    // Check low multiprecision digit counts.
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<9>>>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_dec_float<18>>>();
#endif
#endif
#ifdef TEST_FLOAT128
    test<nil::crypto3::multiprecision::float128>();
#endif
#ifdef TEST_CPP_BIN_FLOAT
    test<nil::crypto3::multiprecision::cpp_bin_float_50>();
    test<nil::crypto3::multiprecision::cpp_bin_float_quad>();
    test<nil::crypto3::multiprecision::number<nil::crypto3::multiprecision::cpp_bin_float<
        35, nil::crypto3::multiprecision::digit_base_10, std::allocator<char>, boost::long_long_type>>>();
#endif
    return boost::report_errors();
}