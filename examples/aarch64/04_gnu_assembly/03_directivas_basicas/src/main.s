// 04.3 - Directivas basicas
//
// Objetivo:
//   Usar directivas para dar nombres a constantes y exponer _start.
//
// Registros usados:
//   x0 = codigo de salida.
//   x8 = numero de syscall.

.equ SYS_exit, 93           // nombre simbolico para la syscall exit
.equ EXIT_CODE, 7           // codigo que devolvera el proceso

.global _start              // hace visible _start para el linker

.section .text
_start:
    // exit(EXIT_CODE)
    mov x0, #EXIT_CODE      // usar la constante definida con .equ
    mov x8, #SYS_exit       // usar la constante definida con .equ
    svc #0                  // entrar al kernel
