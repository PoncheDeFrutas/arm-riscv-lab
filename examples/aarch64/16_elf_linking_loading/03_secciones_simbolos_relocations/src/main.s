// 16.3 - Secciones, simbolos y relocations
//
// Objetivo:
//   Usar varias secciones y simbolos para inspeccion con readelf/nm.
//
// Registros usados:
//   x0 = codigo de salida.
//   x1 = direccion de valor en .data.
//   x2 = valor cargado desde .data.
//   x3 = direccion de scratch en .bss.
//   w4 = byte temporal escrito en .bss.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .rodata
constante:
    .quad 2

.section .data
valor:
    .quad 40

.section .bss
.balign 8
scratch:
    .skip 8

.section .text
_start:
    // leer dato inicial desde .data
    adr x1, valor           // direccion del simbolo valor
    ldr x2, [x1]            // cargar 40 desde .data

    // escribir un byte en .bss
    adr x3, scratch         // direccion del espacio sin inicializar
    mov w4, #1              // byte temporal
    strb w4, [x3]           // scratch[0] = 1

    // sumar constante desde .rodata
    adr x1, constante       // direccion de constante
    ldr x0, [x1]            // cargar 2 desde .rodata
    add x0, x0, x2          // resultado = 2 + 40 = 42

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42
