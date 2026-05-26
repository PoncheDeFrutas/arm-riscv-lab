// 17.7 - Core dumps, ejecucion segura
//
// Objetivo:
//   Mantener run seguro mientras el binario de fallo se construye aparte.
//
// Registros usados:
//   x0 = codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // exit(0)
    mov x0, #0              // ejecucion normal exitosa
    mov x8, #93             // syscall exit
    svc #0                  // terminar sin provocar fallo
