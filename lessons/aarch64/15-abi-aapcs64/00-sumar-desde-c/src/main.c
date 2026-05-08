#include <stdio.h>

extern long sumar(long a, long b);

int main(void) {
    long r = sumar(2, 3);
    printf("resultado = %ld\n", r);
    return r == 5 ? 0 : 1;
}

