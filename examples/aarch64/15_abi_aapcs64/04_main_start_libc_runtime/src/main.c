// 15.4 - main, _start, libc y runtime
//
// Objetivo:
//   Usar main con libc para observar que el runtime de C llama a nuestra
//   funcion, en lugar de entrar directamente desde el kernel a _start.

#include <stdio.h>

int main(void) {
    puts("main con runtime C"); // puts pertenece a libc y termina llamando write.
    return 0;                   // el runtime convierte este retorno en exit(0).
}
