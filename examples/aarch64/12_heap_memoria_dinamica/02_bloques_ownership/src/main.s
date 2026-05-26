// 12.2 - Bloques y ownership
//
// Objetivo:
//   Simular metadata de un bloque: puntero, capacidad, usado y owner.
//
// Registros usados:
//   x0 = codigo de salida.
//   x1 = puntero al bloque simulado.
//   x2 = direccion de block_capacity.
//   x3 = capacidad cargada desde memoria.
//   x4 = direccion de block_used.
//   x5 = direccion de block_owner.
//   x6 = valor para owner o used.
//   w7 = byte escrito en el bloque.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .data
.balign 8
block_capacity:
    .quad 8
block_used:
    .quad 0
block_owner:
    .quad 0

.section .bss
heap_block:
    .skip 8

.section .text
_start:
    // cargar metadata del bloque simulado
    adr x1, heap_block      // x1 es el puntero al bloque
    adr x2, block_capacity  // direccion donde vive la capacidad
    ldr x3, [x2]            // x3 = capacidad reservada: 8 bytes
    adr x4, block_used      // direccion del contador de bytes usados
    adr x5, block_owner     // direccion de la bandera de ownership

    // tomar ownership del bloque
    mov x6, #1              // 1 significa que este programa es el dueño
    str x6, [x5]            // guardar owner = 1

    // escribir contenido dentro del bloque
    mov w7, #65             // byte ASCII 'A'
    strb w7, [x1]           // heap_block[0] = 'A'
    mov w7, #66             // byte ASCII 'B'
    strb w7, [x1, #1]       // heap_block[1] = 'B'

    // actualizar bytes usados
    mov x6, #2              // ahora hay 2 bytes ocupados
    str x6, [x4]            // block_used = 2
    ldr x0, [x4]            // retornar la cantidad usada

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 2
