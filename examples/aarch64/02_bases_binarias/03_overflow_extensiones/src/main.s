// 02.3 - Overflow, carry y extensiones
//
// Objetivo:
//   Provocar wraparound en 32 bits y convertir el flag C en un valor visible.
//
// Registros usados:
//   w1, w2 = operandos de 32 bits.
//   w3 = resultado truncado a 32 bits.
//   x0 = 1 si hubo carry, 0 si no.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // provocar overflow sin signo en 32 bits
    mov w1, #0xffffffff     // maximo valor de 32 bits sin signo
    mov w2, #1              // sumar 1 fuerza wraparound
    adds w3, w1, w2         // 0xffffffff + 1 -> 0, con carry
    cset x0, cs             // cs = carry set: x0 = 1 si C = 1

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // devuelve 1 si hubo carry
