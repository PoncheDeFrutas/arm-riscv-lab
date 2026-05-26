// 07.1 - Movimiento de constantes
//
// Objetivo:
//   Construir constantes pequenas y grandes sin leer memoria.
//
// Registros usados:
//   x1 = constante inmediata pequena.
//   x2 = constante grande construida con movz/movk.
//   x3 = patron generado con movn.
//   x0 = byte bajo de la constante grande y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // constantes pequenas y grandes
    mov x1, #42             // constante inmediata que cabe en una instruccion
    movz x2, #0x7788        // limpia x2 y escribe el bloque bajo de 16 bits
    movk x2, #0x5566, lsl #16 // conserva x2 y reemplaza bits 31..16
    movk x2, #0x3344, lsl #32 // conserva x2 y reemplaza bits 47..32
    movk x2, #0x1122, lsl #48 // x2 = 0x1122334455667788
    movn x3, #0             // x3 = todos los bits en 1
    and x0, x2, #0xff       // conservar solo el byte bajo: 0x88

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 136 decimal
