// 08.2 - Condiciones y flags
//
// Objetivo:
//   Leer la misma comparacion como signed y como unsigned.
//
// Registros usados:
//   x1 = patron -1 signed / maximo unsigned.
//   x2 = valor 1.
//   x3 = indicador signed.
//   x4 = indicador unsigned.
//   x0 = suma de indicadores y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // comparar los mismos bits con dos interpretaciones
    movn x1, #0             // x1 = -1 signed, maximo unsigned
    mov x2, #1              // valor positivo pequeno
    cmp x1, x2              // flags para x1 - x2
    cset x3, lt             // lt = menor signed: x3 = 1 si N != V
    cset x4, hi             // hi = mayor unsigned: x4 = 1 si C = 1 y Z = 0
    add x0, x3, x4          // ambas lecturas fueron verdaderas: 2

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 2
