// 04.4 - Definicion de datos
//
// Objetivo:
//   Declarar datos de distintos tamanos y leer un byte desde memoria.
//
// Registros usados:
//   x1 = direccion de la tabla de datos.
//   w0 = byte leido y codigo de salida.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // leer el primer byte declarado en .data
    adr x1, datos           // direccion del primer dato
    ldrb w0, [x1]           // lee el primer byte: 'A' = 65

    // exit(w0)
    mov x8, #93             // syscall exit
    svc #0                  // devuelve 65

.section .data
datos:
    .byte 0x41              // 1 byte: ASCII 'A'
h:
    .hword 0x1234           // 2 bytes
w:
    .word 0x12345678        // 4 bytes
q:
    .quad 0x1122334455667788 // 8 bytes
