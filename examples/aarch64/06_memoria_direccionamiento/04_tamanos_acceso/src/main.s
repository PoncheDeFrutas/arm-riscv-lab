// 06.4 - Tamanos de acceso
//
// Objetivo:
//   Leer los mismos bytes con instrucciones de 1, 2 y 4 bytes.
//
// Registros usados:
//   x1 = direccion base de los bytes.
//   w2 = lectura de 1 byte con ldrb.
//   w3 = lectura de 2 bytes con ldrh.
//   w4 = lectura de 4 bytes con ldr.
//   x0 = codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // leer el mismo inicio de memoria con tamanos distintos
    adr x1, bytes           // x1 apunta al primer byte: 0x11
    ldrb w2, [x1]           // w2 = 0x11
    ldrh w3, [x1]           // w3 = 0x2211 en little endian
    ldr w4, [x1]            // w4 = 0x44332211 en little endian
    mov w0, w2              // devolver la lectura mas pequena para comprobar

    // exit(w0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 0x11, decimal 17

.section .data
bytes:
    .byte 0x11, 0x22, 0x33, 0x44 // secuencia para comparar lecturas
