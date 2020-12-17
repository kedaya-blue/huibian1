#include <stdio.h>
#include "cmp.h"

int main(void) {
	int32_t src1[17 * 17];
	int32_t src2[17 * 17];
	for (int i = 0; i < 289; ++i) {
		src1[i] = i;
		src2[i] = (i % 17) * 17 + i / 17;
	}
	uint8_t dst[17 * 17];
	lt(src1, 17, src2, 17, dst, 17, 17, 17);
	for (int i = 0; i < 17; ++i) {
		for (int j = 0; j < 17; ++j) {
			printf("%d ", dst[i * 17 + j]);
		}
		printf("\n");
	}
	return 0;
}
