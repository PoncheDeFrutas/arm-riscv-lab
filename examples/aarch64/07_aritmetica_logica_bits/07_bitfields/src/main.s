// 07.7 - Campos de bits
//
// Objetivo:
//   Extraer e insertar campos dentro de un registro sin tocar memoria.
//
// Registros usados:
//   x1 = valor base.
//   x2 = campo extraido con ubfx.
//   x3 = byte que se insertara.
//   x0 = campo extraido y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // construir un valor y extraer un campo
    movz x1, #0x5678        // bits 15..0 del valor base
    movk x1, #0x1234, lsl #16 // x1 = 0x0000000012345678
    ubfx x2, x1, #8, #8     // extraer bits 15..8: 0x56

    // insertar un campo nuevo en el valor base
    mov x3, #0xab           // byte bajo que se insertara
    bfi x1, x3, #16, #8     // insertar 0xab en bits 23..16
    mov x0, x2              // devolver el campo extraido original

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 0x56, decimal 86
