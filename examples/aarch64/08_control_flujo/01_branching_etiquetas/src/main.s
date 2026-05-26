// 08.1 - Branching y etiquetas
//
// Objetivo:
//   Mostrar salto hacia adelante y salto hacia atras con etiquetas.
//
// Registros usados:
//   x0 = resultado final y codigo de salida.
//   x1 = contador del loop.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // salto hacia adelante para omitir codigo
    mov x0, #99             // valor que sera reemplazado si el salto funciona
    b despues_omitido       // saltar sobre la siguiente instruccion
    mov x0, #1              // instruccion omitida por el branch anterior

despues_omitido:
    // salto hacia atras para repetir tres veces
    mov x1, #0              // contador inicial

loop:
    add x1, x1, #1          // incrementar contador
    cmp x1, #3              // comparar contador con limite
    b.lt loop               // lt = menor signed: volver si N != V
    mov x0, x1              // resultado final: 3

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 3
