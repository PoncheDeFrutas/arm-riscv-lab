// 07.2 - Aritmetica y flags
//
// Objetivo:
//   Comparar instrucciones que actualizan flags con instrucciones que no.
//
// Registros usados:
//   x1, x2 = operandos.
//   x3 = resultado de adds.
//   x4 = 1 si hubo carry unsigned.
//   x5 = 1 si cmp detecto igualdad.
//   x0 = suma de indicadores y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // provocar carry unsigned con adds
    movn x1, #0             // x1 = 0xffffffffffffffff
    mov x2, #1              // sumar 1 fuerza wraparound
    adds x3, x1, x2         // resultado 0 y flags actualizados
    cset x4, cs             // cs = carry set: x4 = 1 si C = 1

    // comparar dos valores iguales con cmp
    mov x1, #7              // primer valor de comparacion
    mov x2, #7              // segundo valor de comparacion
    cmp x1, x2              // actualiza flags como x1 - x2
    cset x5, eq             // eq = equal: x5 = 1 si Z = 1
    add x0, x4, x5          // resultado observable: 2

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con la suma de indicadores
