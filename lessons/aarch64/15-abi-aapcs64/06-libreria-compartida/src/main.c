#include <stdio.h>

extern long triple(long value);

int main(void) {
    long r = triple(7);
    printf("triple = %ld\n", r);
    return r == 21 ? 0 : 1;
}

