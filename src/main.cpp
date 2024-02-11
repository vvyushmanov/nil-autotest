#include <nil/crypto3/hash/algorithm/hash.hpp>
#include <nil/crypto3/hash/sha2.hpp>
using namespace nil::crypto3;
bool is_same(size_t a, size_t b)
{
 return a == b;
}
[[circuit]] bool validate_number(
 [[private_input]] size_t a)
{
 return is_same(a, 5);
}
