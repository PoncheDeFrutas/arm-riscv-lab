// 07.6 - Extensiones signed y unsigned
//
// Objetivo:
//   Mostrar que el mismo byte puede extenderse como 255 o como -1.
//
// Registros usados:
//   w1 = byte original 0xff.
//   w2 = extension unsigned con uxtb.
//   w3 = extension signed con sxtb.
//   w0 = suma comprobable y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // extender el mismo byte de dos formas
    mov w1, #0xff           // byte original: 11111111
    uxtb w2, w1             // unsigned: 0x000000ff = 255
    sxtb w3, w1             // signed: 0xffffffff = -1
    add w0, w2, w3          // 255 + (-1) = 254

    // exit(w0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 254
