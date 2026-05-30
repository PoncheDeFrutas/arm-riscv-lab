// 15.5 - Assembly llamado desde C
//
// Objetivo:
//   Declarar una funcion externa en C y dejar que el linker la resuelva contra
//   el simbolo exportado por sumar.s.

#include <stdio.h>

// ABI AAPCS64: C pasara a y b en x0 y x1; sumar devolvera resultado en x0.
extern long sumar(long a, long b);

int main(void) {
    long resultado = sumar(19, 23);      // llamada normal de C hacia assembly
    printf("resultado = %ld\n", resultado);
    return resultado == 42 ? 0 : 1;      // 0 = prueba correcta, 1 = fallo ABI
}
