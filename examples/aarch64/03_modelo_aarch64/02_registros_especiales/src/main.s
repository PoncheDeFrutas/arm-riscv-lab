// 03.2 - Registros especiales
//
// Objetivo:
//   Usar xzr como registro cero y observar sp, pc y x30 desde GDB.
//
// Registros usados:
//   x1 = valor de prueba que no afecta el resultado.
//   xzr = registro cero, siempre lee 0.
//   x0 = resultado y codigo de salida.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // mostrar que xzr siempre aporta cero
    mov x1, #99             // valor visible en GDB
    add x0, xzr, xzr        // xzr + xzr produce 0

    // exit(0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso
