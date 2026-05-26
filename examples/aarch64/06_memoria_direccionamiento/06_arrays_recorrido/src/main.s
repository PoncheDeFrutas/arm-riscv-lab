// 06.6 - Arrays y recorrido
//
// Objetivo:
//   Recorrer memoria consecutiva usando post-index y acumular valores.
//
// Registros usados:
//   x1 = puntero al elemento actual del array.
//   x2, x3, x4, x5 = elementos leidos.
//   x0 = acumulador y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // recorrer cuatro elementos con post-index explicito
    adr x1, array           // x1 apunta al primer elemento
    ldr x2, [x1], #8        // x2 = array[0], x1 avanza a array[1]
    ldr x3, [x1], #8        // x3 = array[1], x1 avanza a array[2]
    ldr x4, [x1], #8        // x4 = array[2], x1 avanza a array[3]
    ldr x5, [x1], #8        // x5 = array[3], x1 queda despues del array

    // acumular los valores leidos
    add x0, x2, x3          // suma parcial: 15
    add x0, x0, x4          // suma parcial: 30
    add x0, x0, x5          // suma final: 50

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con la suma del array

.section .data
array:
    .quad 5, 10, 15, 20     // memoria consecutiva de elementos de 8 bytes
