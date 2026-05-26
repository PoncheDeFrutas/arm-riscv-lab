// 02.6 - Direcciones, punteros y memoria
//
// Objetivo:
//   Separar direccion de memoria y contenido almacenado en esa direccion.
//
// Registros usados:
//   x1 = direccion de la etiqueta numero.
//   w0 = contenido leido desde memoria.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // leer contenido usando una direccion
    adr x1, numero          // x1 guarda la direccion de numero
    ldr w0, [x1]            // w0 recibe el contenido almacenado en esa direccion

    // exit(w0)
    mov x8, #93             // syscall exit
    svc #0                  // devuelve 42

.section .data
numero:
    .word 42                // dato almacenado en memoria
