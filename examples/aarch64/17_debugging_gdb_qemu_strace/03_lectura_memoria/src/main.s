// 17.3 - Lectura de memoria
//
// Objetivo:
//   Preparar .rodata, .data y .bss para inspeccion con GDB.
//
// Registros usados:
//   x0 = codigo de salida.
//   x1 = direccion de valor en .data.
//   x2 = valor cargado desde memoria.
//   x3 = direccion del buffer .bss.
//   w4 = byte escrito en el buffer.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .rodata
mensaje:
    .asciz "memoria visible"

.section .data
valor:
    .quad 42

.section .bss
buffer:
    .skip 16

.section .text
_start:
    // leer valor inicializado
    adr x1, valor           // direccion del dato en .data
    ldr x2, [x1]            // cargar 42 desde memoria

    // escribir un byte en .bss
    adr x3, buffer          // direccion del buffer inicialmente en cero
    mov w4, #65             // byte ASCII 'A'
    strb w4, [x3]           // buffer[0] = 'A'

    // exit(valor)
    mov x0, x2              // codigo de salida = 42
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso
