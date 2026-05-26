// 12.1 - Stack vs heap
//
// Objetivo:
//   Comparar un local temporal en stack con un bloque persistente simulado.
//
// Registros usados:
//   x0 = retorno de funciones y codigo de salida.
//   x1 = direccion del bloque simulado en .bss.
//   x2 = valor persistente escrito en el bloque.
//   x3 = copia del retorno temporal.
//   x8 = numero de syscall Linux AArch64.
//   sp = espacio temporal de crear_dato_stack.

.global _start

.section .bss
.balign 8
heap_buffer:
    .skip 8

.section .text
_start:
    // obtener un valor temporal desde stack
    bl crear_dato_stack     // retorna 2 sin devolver direccion al stack
    mov x3, x0              // guardar copia del valor temporal

    // obtener un valor desde bloque persistente simulado
    bl crear_dato_heap_simulado // escribe y lee desde heap_buffer
    add x0, x0, x3          // resultado final: 40 + 2 = 42

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42

crear_dato_stack:
    // crear y consumir un local de vida corta
    sub sp, sp, #16         // reservar 16 bytes temporales
    mov x0, #2              // valor local temporal
    str x0, [sp]            // guardar local dentro del frame temporal
    ldr x0, [sp]            // recuperar el valor, no su direccion
    add sp, sp, #16         // liberar el espacio temporal
    ret                     // volver con el valor en x0

crear_dato_heap_simulado:
    // escribir en un bloque que sigue existiendo despues del retorno
    adr x1, heap_buffer     // x1 apunta al bloque simulado en .bss
    mov x2, #40             // valor persistente para el ejemplo
    str x2, [x1]            // guardar dato en heap_buffer
    ldr x0, [x1]            // retornar el contenido persistente
    ret                     // volver a _start
