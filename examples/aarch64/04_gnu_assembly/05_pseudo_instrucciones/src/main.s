// 04.5 - Pseudo-instrucciones
//
// Objetivo:
//   Usar ldr =valor para cargar una constante grande.
//
// Registros usados:
//   x0 = constante cargada y codigo de salida.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // cargar una constante que no cabe en un mov simple
    ldr x0, =0x123456789abcdef0 // el assembler decide como materializarla

    // exit(x0)
    mov x8, #93                 // syscall exit
    svc #0                      // el shell vera solo el byte bajo
