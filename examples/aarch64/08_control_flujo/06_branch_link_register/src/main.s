// 08.6 - Branch link register
//
// Objetivo:
//   Introducir bl, ret y x30/lr con una funcion hoja simple.
//
// Registros usados:
//   x0 = retorno de la funcion y codigo de salida.
//   x8 = numero de syscall Linux AArch64.
//   x30 = link register usado por bl/ret.

.global _start

.section .text
_start:
    // llamar funcion_simple y volver usando x30/lr
    bl funcion_simple       // saltar y guardar direccion de retorno en x30
    add x0, x0, #1          // ajustar retorno de la funcion: 41 + 1 = 42

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42

funcion_simple:
    // funcion hoja: no llama a otra funcion
    mov x0, #41             // valor de retorno manual
    ret                     // volver a la direccion guardada en x30
