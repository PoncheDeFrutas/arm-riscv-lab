// 17.2 - Registros e instrucciones
//
// Objetivo:
//   Observar registros y pc mientras se ejecutan instrucciones simples.
//
// Registros usados:
//   x0 = valor base y codigo de salida.
//   x1 = valor desplazado.
//   x2 = resultado intermedio.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // preparar valores faciles de reconocer
    mov x0, #10             // x0 = 10
    mov x1, #4              // x1 = 4
    lsl x1, x1, #3          // x1 = 4 << 3 = 32
    add x2, x0, x1          // x2 = 10 + 32 = 42
    mov x0, x2              // x0 lleva el resultado final

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42
