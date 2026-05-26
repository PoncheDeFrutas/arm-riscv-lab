// 07.5 - Shifts y rotates
//
// Objetivo:
//   Comparar desplazamientos logicos, aritmeticos y rotacion.
//
// Registros usados:
//   x1 = valor inicial positivo.
//   x2 = resultado de lsl.
//   x3 = resultado de lsr.
//   x4 = valor con todos los bits en 1.
//   x5 = resultado de asr.
//   x6 = resultado de ror.
//   x0 = byte bajo observable y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // desplazar y rotar bits
    mov x1, #8              // valor inicial: 0b1000
    lsl x2, x1, #2          // desplazar izquierda: 8 * 4 = 32
    lsr x3, x2, #1          // desplazar derecha logico: 16
    movn x4, #0             // x4 = -1 si se interpreta con signo
    asr x5, x4, #4          // desplazamiento aritmetico conserva el signo
    ror x6, x2, #1          // rotar derecha: bit bajo vuelve por arriba
    and x0, x6, #0xff       // byte bajo de la rotacion: 16

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 16
