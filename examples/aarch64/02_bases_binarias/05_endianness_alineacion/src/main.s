// 02.5 - Endianness y alineacion
//
// Objetivo:
//   Leer el primer byte de un word para observar el orden little endian.
//
// Registros usados:
//   x1 = direccion del word en memoria.
//   w0 = primer byte leido, usado como codigo de salida.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // cargar direccion y leer solo el primer byte
    adr x1, valor           // x1 apunta al word 0x12345678
    ldrb w0, [x1]           // primer byte: 0x78 en little endian

    // exit(w0)
    mov x8, #93             // syscall exit
    svc #0                  // el shell vera 120 decimal

.section .data
.balign 4                   // alinear el word a una direccion multiplo de 4
valor:
    .word 0x12345678        // en memoria: 78 56 34 12
