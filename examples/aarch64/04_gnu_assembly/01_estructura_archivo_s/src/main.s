// 04.1 - Estructura de archivo .s
//
// Objetivo:
//   Mostrar las piezas formales de un archivo GNU Assembly.
//
// Nota:
//   .type y .size aparecen aqui porque esta leccion los explica. No se usan
//   como boilerplate en todos los ejemplos.

.global _start
.type _start, %function

.section .text
_start:
    mov x0, #0      // codigo de salida
    mov x8, #93     // syscall exit
    svc #0          // entrar al kernel

.size _start, . - _start
