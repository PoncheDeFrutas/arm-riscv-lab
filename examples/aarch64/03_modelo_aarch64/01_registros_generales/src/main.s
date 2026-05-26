// 03.1 - Registros generales
//
// Objetivo:
//   Mover valores entre registros generales y calcular un resultado.
//
// Registros usados:
//   x1 = primer operando.
//   x2 = segundo operando.
//   x0 = resultado y codigo de salida.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // calcular 10 + 20
    mov x1, #10             // primer valor de prueba
    mov x2, #20             // segundo valor de prueba
    add x0, x1, x2          // resultado: 30

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // devuelve el resultado al shell
