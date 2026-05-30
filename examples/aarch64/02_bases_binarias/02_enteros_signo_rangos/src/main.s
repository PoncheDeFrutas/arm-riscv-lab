// 02.2 - Enteros, signo y rangos
//
// Objetivo:
//   Mostrar que un mismo patron de bits cambia al interpretarse con signo.
//
// Registros usados:
//   w1 = patron de 32 bits.
//   x0 = valor extendido con signo.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // preparar un patron que depende de como se interprete
    mov w1, #0xffffffff     // todos los bits en 1 dentro de 32 bits
    sxtw x0, w1             // interpretar w1 como signed y extender a 64 bits

    // exit(x0)
    mov x8, #93             // exit(x0); el shell vera 255
    svc #0                  // terminar proceso
