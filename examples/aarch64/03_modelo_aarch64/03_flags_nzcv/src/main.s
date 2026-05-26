// 03.3 - Flags NZCV
//
// Objetivo:
//   Actualizar flags con cmp y convertir una condicion en 0 o 1.
//
// Registros usados:
//   x1 = primer valor a comparar.
//   x2 = segundo valor a comparar.
//   x0 = resultado de la condicion eq.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // comparar dos valores iguales
    mov x1, #7              // primer valor
    mov x2, #7              // segundo valor
    cmp x1, x2              // actualiza flags como si hiciera x1 - x2
    cset x0, eq             // eq = equal: x0 = 1 si Z = 1

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // devuelve 1 si eran iguales
