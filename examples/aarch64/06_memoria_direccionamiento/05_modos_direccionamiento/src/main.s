// 06.5 - Modos de direccionamiento
//
// Objetivo:
//   Usar base, offset inmediato, offset escalado y post-index.
//
// Registros usados:
//   x1 = direccion base del array.
//   x2 = indice usado para offset escalado.
//   x3, x4, x5 = valores leidos con distintos modos.
//   x0 = acumulador y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // preparar base e indice
    adr x1, array           // x1 apunta a array[0]
    mov x2, #2              // indice para leer array[2]

    // leer usando modos de direccionamiento distintos
    ldr x3, [x1]            // base sola: array[0] = 10
    ldr x4, [x1, #8]        // offset inmediato de 8 bytes: array[1] = 20
    ldr x5, [x1, x2, lsl #3] // offset escalado: array[2] = 30
    add x0, x3, x4          // acumulador parcial: 30
    add x0, x0, x5          // acumulador final: 60

    // demostrar post-index sin afectar el resultado
    ldr x3, [x1], #8        // lee array[0] y luego avanza x1 a array[1]

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 60

.section .data
array:
    .quad 10, 20, 30, 40    // elementos de 8 bytes para lsl #3
