#include <stdio.h>

extern long suma_lib(long a, long b);

int main(void) {
    long resultado = suma_lib(20, 22);
    printf("lib = %ld\n", resultado);
    return resultado == 42 ? 0 : 1;
}
