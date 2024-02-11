//---------------------------------------------------------------------------//
// Copyright (c) 2019 Mikhail Komarov <nemo@nil.foundation>
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//---------------------------------------------------------------------------//

#ifndef CRYPTO3_KDF_KDF2_POLICY_HPP
#define CRYPTO3_KDF_KDF2_POLICY_HPP

#include <boost/container/small_vector.hpp>

namespace nil {
    namespace crypto3 {
        namespace kdf {
            namespace detail {
                template<typename Hash>
                struct kdf2_policy {
                    typedef Hash hash_type;

                    constexpr static const std::size_t salt_bits = CHAR_BIT;
                    constexpr static const std::size_t salt_size = CHAR_BIT / CHAR_BIT;
                    typedef boost::container::small_vector<std::uint8_t, salt_size> salt_type;

                    constexpr static const std::size_t secret_bits = CHAR_BIT;
                    constexpr static const std::size_t secret_size = CHAR_BIT / CHAR_BIT;
                    typedef boost::container::small_vector<std::uint8_t, secret_size> secret_type;

                    constexpr static const std::size_t label_bits = CHAR_BIT;
                    constexpr static const std::size_t label_size = CHAR_BIT / CHAR_BIT;
                    typedef boost::container::small_vector<std::uint8_t, salt_size> label_type;
                };
            }    // namespace detail
        }        // namespace kdf
    }            // namespace crypto3
}    // namespace nil

#endif    // CRYPTO3_HKDF_POLICY_HPP
