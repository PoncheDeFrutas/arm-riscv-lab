// 08.4 - Loops y recorrido de array
//
// Objetivo:
//   Recorrer un array con cbz, post-index y una rama hacia atras.
//
// Registros usados:
//   x1 = puntero al elemento actual.
//   x2 = cantidad de elementos restantes.
//   x3 = elemento leido.
//   x0 = acumulador y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // inicializar puntero, contador y acumulador
    adr x1, array           // x1 apunta a array[0]
    mov x2, #4              // cantidad de elementos
    mov x0, #0              // acumulador inicial

loop:
    cbz x2, fin             // cbz = saltar si x2 == 0
    ldr x3, [x1], #8        // leer elemento actual y avanzar puntero
    add x0, x0, x3          // acumular elemento leido
    sub x2, x2, #1          // decrementar contador
    b loop                  // volver a revisar condicion

fin:
    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con la suma del array

.section .data
array:
    .quad 5, 10, 15, 20     // suma esperada: 50
