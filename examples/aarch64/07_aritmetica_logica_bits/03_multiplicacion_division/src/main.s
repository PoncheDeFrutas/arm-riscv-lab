// 07.3 - Multiplicacion y division
//
// Objetivo:
//   Usar mul, udiv y msub para obtener producto, cociente y residuo.
//
// Registros usados:
//   x1 = dividendo base.
//   x2 = divisor.
//   x3 = producto.
//   x4 = cociente.
//   x5 = residuo.
//   x0 = resultado comprobable y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // multiplicar y dividir valores sin signo pequenos
    mov x1, #37             // valor base
    mov x2, #5              // multiplicador y divisor
    mul x3, x1, x2          // x3 = 37 * 5 = 185
    udiv x4, x3, x2         // x4 = 185 / 5 = 37
    msub x5, x4, x2, x3     // x5 = x3 - x4 * x2 = residuo 0
    add x0, x4, x5          // resultado final: 37

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el cociente mas residuo
