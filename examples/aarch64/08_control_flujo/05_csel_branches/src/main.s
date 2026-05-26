// 08.5 - Branches especializados y csel
//
// Objetivo:
//   Usar cbz, cbnz, tbnz, csel y cset para decisiones pequenas.
//
// Registros usados:
//   x1 = valor revisado por cbz.
//   x2 = valor seleccionado por ramas cbz/cbnz.
//   x3 = mascara revisada por tbnz.
//   x4 = valor seleccionado por prueba de bit.
//   x5 = mayor seleccionado con csel.
//   x6 = indicador producido con cset.
//   x0 = resultado final y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // elegir valor base con cbz/cbnz
    mov x1, #0              // valor cero para disparar cbz
    cbz x1, es_cero         // cbz = saltar si x1 == 0
    mov x2, #99             // camino omitido porque x1 era cero
    b despues_cero          // saltar al final del bloque

es_cero:
    mov x2, #4              // valor usado cuando x1 es cero

despues_cero:
    cbnz x2, tiene_valor    // cbnz = saltar si x2 != 0
    mov x2, #1              // respaldo omitido por cbnz

tiene_valor:
    // elegir otro valor probando un bit
    mov x3, #0b1000         // mascara con bit 3 encendido
    tbnz x3, #3, bit_encendido // tbnz = saltar si bit 3 vale 1
    mov x4, #0              // camino omitido porque el bit estaba encendido
    b despues_bit           // saltar al final del bloque

bit_encendido:
    mov x4, #6              // valor usado si el bit 3 esta encendido

despues_bit:
    // seleccionar sin rama y convertir condicion en 0/1
    cmp x4, x2              // comparar 6 contra 4
    csel x5, x4, x2, gt     // gt = mayor signed: elige x4 si Z = 0 y N = V
    cset x6, gt             // gt = mayor signed: x6 = 1 si Z = 0 y N = V
    add x0, x5, x6          // resultado final: 7

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 7
