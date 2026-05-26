// 03.6 - Lectura de registros con GDB
//
// Objetivo:
//   Preparar registros faciles de reconocer y avanzar con stepi.
//
// Registros usados:
//   x1, x2, x3 = valores visibles en GDB.
//   x0 = suma acumulada y codigo de salida.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // cargar valores pequenos para inspeccionarlos
    mov x1, #1              // primer valor
    mov x2, #2              // segundo valor
    mov x3, #3              // tercer valor

    // sumar paso a paso para observar cambios en x0
    add x0, x1, x2          // x0 = 3
    add x0, x0, x3          // x0 = 6

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // devuelve 6
