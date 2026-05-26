// 12.5 - Errores de memoria
//
// Objetivo:
//   Simular double free y use-after-free con banderas en lugar de corromper memoria.
//
// Registros usados:
//   x0 = codigo retornado por las funciones y codigo de salida.
//   x1 = direccion de owner_flag o del bloque.
//   x2 = estado de ownership cargado desde memoria.
//   x8 = numero de syscall Linux AArch64.
//   x19 = acumulador de codigos de error.

.global _start

.section .data
.balign 8
owner_flag:
    .quad 0

.section .bss
heap_block:
    .skip 8

.section .text
_start:
    // reservar y liberar una vez correctamente
    bl reservar             // owner_flag pasa a 1
    bl liberar              // primera liberacion retorna 0

    // provocar double free de forma controlada
    bl liberar              // segunda liberacion retorna 4
    mov x19, x0             // guardar codigo de double free

    // provocar use-after-free de forma controlada
    bl usar_bloque          // usar sin ownership retorna 2
    orr x0, x19, x0         // combinar errores: 4 | 2 = 6

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 6

reservar:
    // tomar ownership del bloque simulado
    adr x1, owner_flag      // direccion de la bandera de ownership
    mov x2, #1              // 1 significa bloque reservado
    str x2, [x1]            // owner_flag = 1
    mov x0, #0              // retorno 0 = reserva conceptual exitosa
    ret                     // volver al caller

liberar:
    // validar ownership antes de liberar
    adr x1, owner_flag      // direccion de la bandera de ownership
    ldr x2, [x1]            // cargar estado actual
    cbz x2, double_free     // cbz = si owner_flag == 0, ya estaba liberado
    str xzr, [x1]           // owner_flag = 0, bloque liberado
    mov x0, #0              // retorno 0 = liberacion correcta
    ret                     // volver al caller

double_free:
    mov x0, #4              // codigo 4 = double free simulado
    ret                     // volver al caller

usar_bloque:
    // validar ownership antes de escribir
    adr x1, owner_flag      // direccion de la bandera de ownership
    ldr x2, [x1]            // cargar estado actual
    cbz x2, use_after_free  // cbz = si owner_flag == 0, uso invalido
    adr x1, heap_block      // direccion del bloque valido
    mov w2, #88             // byte ASCII 'X'
    strb w2, [x1]           // escribir solo si hay ownership
    mov x0, #0              // retorno 0 = uso correcto
    ret                     // volver al caller

use_after_free:
    mov x0, #2              // codigo 2 = use-after-free simulado
    ret                     // volver al caller
