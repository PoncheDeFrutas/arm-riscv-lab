// 15.7 - Librerias y lectura guiada
//
// Objetivo:
//   Llamar desde C una funcion assembly empaquetada en una biblioteca estatica.

#include <stdio.h>

// El simbolo vive en operaciones.s y se archiva dentro de liboperaciones.a.
extern long suma_lib(long a, long b);

int main(void) {
    long resultado = suma_lib(20, 22);   // C no sabe si viene de .o o .a
    printf("lib = %ld\n", resultado);
    return resultado == 42 ? 0 : 1;      // salida distinta de 0 marca error
}
