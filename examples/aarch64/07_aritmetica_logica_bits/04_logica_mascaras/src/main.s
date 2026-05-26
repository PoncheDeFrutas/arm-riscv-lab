// 07.4 - Logica y mascaras
//
// Objetivo:
//   Encender, apagar, alternar y probar bits con operaciones logicas.
//
// Registros usados:
//   x1, x2 = patrones base.
//   x3 = resultado de and.
//   x4 = resultado de orr.
//   x5 = resultado de eor.
//   x6 = resultado de bic.
//   x7 = indicador producido por tst/cset.
//   x0 = resultado final y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // operar sobre patrones de bits
    mov x1, #0b1010         // patron 10 decimal
    mov x2, #0b1100         // patron 12 decimal
    and x3, x1, x2          // conservar bits encendidos en ambos: 0b1000
    orr x4, x1, x2          // encender bits presentes en cualquiera: 0b1110
    eor x5, x1, x2          // alternar bits distintos: 0b0110
    bic x6, x4, x1          // apagar en x4 los bits encendidos en x1: 0b0100
    tst x4, #0b1000         // probar bit 3 sin guardar resultado
    cset x7, ne             // ne = not equal: x7 = 1 si Z = 0
    add x0, x3, x6          // 8 + 4 = 12
    add x0, x0, x7          // resultado final: 13

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 13
