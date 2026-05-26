// 06.3 - Load/store basico
//
// Objetivo:
//   Practicar el patron cargar, modificar y guardar en memoria.
//
// Registros usados:
//   x0 = direccion del contador y luego codigo de salida.
//   x1 = contenido del contador mientras se modifica.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // cargar-modificar-guardar contador
    ldr x0, =contador       // x0 apunta al dato modificable
    ldr x1, [x0]            // cargar el contenido actual: 41
    add x1, x1, #1          // modificar en registro: 42
    str x1, [x0]            // guardar el resultado de vuelta en memoria
    ldr x0, [x0]            // recargar para comprobar que memoria cambio

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el valor guardado: 42

.section .data
contador:
    .quad 41                // valor inicial que sera incrementado
