// 15.2 - Argumentos, retornos y stack
//
// Objetivo:
//   Pasar diez argumentos: ocho por registros y dos por stack.
//
// Registros usados:
//   x0-x7 = primeros ocho argumentos y acumulador de retorno.
//   x8 = numero de syscall Linux AArch64 al salir.
//   x9 = temporal para preparar argumentos extra.
//   x10 = noveno argumento cargado desde stack.
//   x11 = decimo argumento cargado desde stack.
//   sp = area de argumentos adicionales.

.global _start

.section .text
_start:
    // reservar espacio para argumentos 9 y 10
    sub sp, sp, #16         // mantener sp alineado a 16 bytes
    mov x9, #9              // noveno argumento
    str x9, [sp]            // arg9 vive en el stack
    mov x9, #10             // decimo argumento
    str x9, [sp, #8]        // arg10 vive despues de arg9

    // preparar los primeros ocho argumentos en registros
    mov x0, #1              // arg1
    mov x1, #2              // arg2
    mov x2, #3              // arg3
    mov x3, #4              // arg4
    mov x4, #5              // arg5
    mov x5, #6              // arg6
    mov x6, #7              // arg7
    mov x7, #8              // arg8
    bl sumar10              // retorno = 55 en x0
    add sp, sp, #16         // liberar argumentos de stack del caller

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 55

sumar10:
    // sumar argumentos recibidos por registros
    add x0, x0, x1          // acumular arg1 + arg2
    add x0, x0, x2          // sumar arg3
    add x0, x0, x3          // sumar arg4
    add x0, x0, x4          // sumar arg5
    add x0, x0, x5          // sumar arg6
    add x0, x0, x6          // sumar arg7
    add x0, x0, x7          // sumar arg8

    // leer argumentos adicionales desde el stack del caller
    ldr x10, [sp]           // cargar arg9 desde el stack
    ldr x11, [sp, #8]       // cargar arg10 desde el stack
    add x0, x0, x10         // sumar arg9
    add x0, x0, x11         // sumar arg10
    ret                     // volver con retorno en x0
