// 17.7 - Core dumps, fallo opcional
//
// Objetivo:
//   Provocar un acceso invalido solo cuando se ejecuta run-fault.
//
// Registros usados:
//   x0 = direccion invalida NULL.
//   x1 = valor que se intenta escribir.

.global _start

.section .text
_start:
    // provocar fallo por escritura en direccion cero
    mov x0, #0              // puntero NULL invalido
    mov x1, #42             // valor visible en registros
    str x1, [x0]            // escritura invalida: debe producir senal

    // esta salida no deberia alcanzarse
    mov x0, #0              // codigo de salida si no fallara
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso
