#include <stdio.h>

extern long sumar(long a, long b);

int main(void) {
    long resultado = sumar(19, 23);
    printf("resultado = %ld\n", resultado);
    return resultado == 42 ? 0 : 1;
}
