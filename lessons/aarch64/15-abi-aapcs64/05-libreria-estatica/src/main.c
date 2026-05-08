#include <stdio.h>

extern long mul(long a, long b);

int main(void) {
    long r = mul(6, 7);
    printf("mul = %ld\n", r);
    return r == 42 ? 0 : 1;
}

