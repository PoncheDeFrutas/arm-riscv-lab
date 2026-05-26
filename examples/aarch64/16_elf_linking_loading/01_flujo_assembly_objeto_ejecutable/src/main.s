// 16.1 - Del .s al .o y del .o al ELF
//
// Objetivo:
//   Crear un ejecutable ELF minimo para inspeccionar el flujo de build.
//
// Registros usados:
//   x0 = codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // entrar al kernel y terminar
