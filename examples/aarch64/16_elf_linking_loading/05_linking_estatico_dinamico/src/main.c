// 16.5 - Linking estatico, dinamico y dynamic loader
//
// Objetivo:
//   Forzar un binario dinamico sencillo para inspeccionar interpreter,
//   seccion dinamica y dependencias con readelf.

#include <stdio.h>

int main(void) {
    puts("link dinamico"); // referencia a libc: genera dependencia dinamica.
    return 0;              // el runtime de C transforma esto en exit(0).
}
