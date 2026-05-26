// 06.1 - Direccion y contenido
//
// Objetivo:
//   Comparar una direccion de memoria con el contenido guardado en ella.
//
// Registros usados:
//   x0 = direccion temporal y luego codigo de salida.
//   x1 = contenido leido desde memoria.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // cargar direccion y luego contenido
    ldr x0, =valor          // x0 recibe la direccion asociada a la etiqueta valor
    ldr x1, [x0]            // x1 recibe el contenido de 64 bits guardado alli
    mov x0, x1              // mover el valor leido al registro de salida

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el contenido leido: 42

.section .data
valor:
    .quad 42                // dato de 8 bytes que sera leido desde memoria
