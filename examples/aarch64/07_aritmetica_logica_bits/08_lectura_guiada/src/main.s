// 07.8 - Lectura guiada de aritmetica, logica y bits
//
// Objetivo:
//   Combinar constantes, mascaras, shifts y bitfields en un programa corto.
//
// Registros usados:
//   x1 = constante base.
//   x2 = byte bajo aislado.
//   x3 = byte bajo desplazado.
//   x4 = resultado aritmetico.
//   x5 = campo extraido.
//   x0 = resultado final y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // preparar constante base
    movz x1, #0x1234        // x1 = 0x1234
    and x2, x1, #0xff       // aislar byte bajo: 0x34 = 52
    lsl x3, x2, #1          // desplazar izquierda: 104
    add x4, x3, #1          // aritmetica simple: 105
    ubfx x5, x1, #8, #4     // extraer nibble desde bit 8: 0x2
    add x0, x4, x5          // resultado final: 107

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 107
