#include <stdio.h>

extern long sum9(long a, long b, long c, long d, long e,
                 long f, long g, long h, long i);

int main(void) {
    long r = sum9(1, 2, 3, 4, 5, 6, 7, 8, 9);
    printf("sum9 = %ld\n", r);
    return r == 45 ? 0 : 1;
}

