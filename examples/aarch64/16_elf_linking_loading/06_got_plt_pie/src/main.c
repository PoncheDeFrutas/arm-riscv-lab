// 16.6 - GOT, PLT y PIE
//
// Objetivo:
//   Crear una llamada a libc dentro de un ejecutable PIE para inspeccionar
//   saltos PLT, relocations dinamicas y direcciones relativas.

#include <stdio.h>

int main(void) {
    printf("plt pie %d\n", 42); // printf pasa por PLT y se resuelve dinamicamente.
    return 0;                   // codigo de salida exitoso.
}
