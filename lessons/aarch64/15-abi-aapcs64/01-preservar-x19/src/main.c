#include <stdio.h>

extern long usar_x19(long value);

int main(void) {
    long r = usar_x19(41);
    printf("usar_x19 = %ld\n", r);
    return r == 42 ? 0 : 1;
}

