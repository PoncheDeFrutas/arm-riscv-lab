// 17.1 - Flujo basico de GDB
//
// Objetivo:
//   Tener un programa pequeno para practicar break, continue, stepi y nexti.
//
// Registros usados:
//   x0 = primer valor y codigo de salida.
//   x1 = segundo valor.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // preparar suma observable instruccion por instruccion
    mov x0, #20             // x0 empieza con 20
    mov x1, #22             // x1 empieza con 22
    add x0, x0, x1          // x0 = 20 + 22 = 42

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42
