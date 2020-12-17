#include <stddef.h>
#include <stdint.h>

extern void lt(const int32_t* src1, size_t step1,
               const int32_t* src2, size_t step2,
               uint8_t* dst, size_t step3,
               size_t width, size_t height);