// 14.8 - Lectura guiada de un Buffer ADT
//
// Objetivo:
//   Seguir push_byte, error por capacidad y clear en un Buffer manual.
//
// Registros usados:
//   x0 = self del Buffer, retorno de funciones y codigo de salida.
//   w1 = byte a insertar.
//   x2 = puntero a datos.
//   x3 = longitud usada.
//   x4 = capacidad.
//   x8 = numero de syscall Linux AArch64.

.equ BUF_DATA, 0
.equ BUF_LEN, 8
.equ BUF_CAP, 16
.equ BUF_SIZE, 24

.global _start

.section .bss
storage:
    .skip 2

.section .data
.balign 8
buffer_desc:
    .quad storage
    .quad 0
    .quad 2

.section .text
_start:
    // primer push exitoso
    adr x0, buffer_desc     // self = Buffer
    mov w1, #65             // byte ASCII 'A'
    bl buffer_push_byte     // insertar primer byte
    cmp x0, #0              // debe retornar 0
    b.ne error              // ne = fallo inesperado

    // segundo push exitoso
    adr x0, buffer_desc     // recargar self
    mov w1, #66             // byte ASCII 'B'
    bl buffer_push_byte     // insertar segundo byte
    cmp x0, #0              // debe retornar 0
    b.ne error              // ne = fallo inesperado

    // tercer push debe fallar por capacidad
    adr x0, buffer_desc     // recargar self
    mov w1, #67             // byte ASCII 'C'
    bl buffer_push_byte     // intentar insertar tercer byte
    cmp x0, #0              // comparar retorno contra exito
    b.lt error_esperado     // lt = retorno -1, buffer lleno esperado
    b error                 // si no fue negativo, la prueba fallo

error_esperado:
    // limpiar longitud logica del buffer
    adr x0, buffer_desc     // self = Buffer
    bl buffer_clear         // len = 0
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo de la lectura guiada

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

buffer_push_byte:
    // cargar estado actual
    ldr x2, [x0, #BUF_DATA] // puntero al storage
    ldr x3, [x0, #BUF_LEN]  // len actual
    ldr x4, [x0, #BUF_CAP]  // capacidad total
    cmp x3, x4              // comparar len contra cap
    b.cs buffer_full        // cs = len >= cap

    // escribir byte y actualizar len
    strb w1, [x2, x3]       // data[len] = byte
    add x3, x3, #1          // len = len + 1
    str x3, [x0, #BUF_LEN]  // guardar len nuevo
    mov x0, #0              // retorno 0 = exito
    ret                     // volver al caller

buffer_full:
    mov x0, #-1             // retorno -1 = sin capacidad
    ret                     // volver al caller

buffer_clear:
    // borrar longitud logica
    str xzr, [x0, #BUF_LEN] // len = 0
    ret                     // volver al caller
