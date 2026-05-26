// 14.3 - ADTs e invariantes
//
// Objetivo:
//   Mantener la invariante used <= capacity en un Buffer ADT manual.
//
// Registros usados:
//   x0 = puntero a Buffer, retorno de funcion y codigo de salida.
//   w1 = byte a insertar.
//   x2 = puntero a datos del buffer.
//   x3 = longitud usada.
//   x4 = capacidad del buffer.
//   x8 = numero de syscall Linux AArch64.

.equ BUF_DATA, 0
.equ BUF_LEN, 8
.equ BUF_CAP, 16
.equ BUF_SIZE, 24

.global _start

.section .bss
storage:
    .skip 4

.section .data
.balign 8
buffer_desc:
    .quad storage
    .quad 0
    .quad 4

.section .text
_start:
    // insertar dos bytes por medio del ADT
    adr x0, buffer_desc     // x0 = self del Buffer
    mov w1, #65             // byte ASCII 'A'
    bl buffer_push_byte     // intentar push de 'A'
    cmp x0, #0              // revisar retorno
    b.ne error              // ne = retorno distinto de exito

    adr x0, buffer_desc     // recargar self porque x0 fue retorno
    mov w1, #66             // byte ASCII 'B'
    bl buffer_push_byte     // intentar push de 'B'
    cmp x0, #0              // revisar retorno
    b.ne error              // ne = retorno distinto de exito

    // retornar longitud usada
    adr x0, buffer_desc     // direccion del descriptor
    ldr x0, [x0, #BUF_LEN]  // cargar len actual: 2
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo inesperado

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar con len o error

buffer_push_byte:
    // cargar estado del descriptor
    ldr x2, [x0, #BUF_DATA] // x2 = puntero al almacenamiento
    ldr x3, [x0, #BUF_LEN]  // x3 = bytes usados
    ldr x4, [x0, #BUF_CAP]  // x4 = capacidad
    cmp x3, x4              // comparar len contra cap como unsigned
    b.cs buffer_full        // cs = len >= cap, no hay espacio

    // escribir byte y actualizar len
    strb w1, [x2, x3]       // data[len] = byte
    add x3, x3, #1          // len = len + 1
    str x3, [x0, #BUF_LEN]  // guardar len actualizado
    mov x0, #0              // retorno 0 = exito
    ret                     // volver al caller

buffer_full:
    mov x0, #1              // retorno 1 = buffer lleno
    ret                     // volver al caller
