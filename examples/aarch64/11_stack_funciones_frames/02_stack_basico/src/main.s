// 11.2 - Stack basico
//
// Objetivo:
//   Reservar 16 bytes en el stack, guardar valores y restaurar sp.
//
// Registros usados:
//   sp = puntero al tope actual del stack.
//   x1 = primer valor temporal.
//   x2 = segundo valor temporal.
//   x3 = valor recuperado desde el stack.
//   x0 = codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // reservar espacio temporal
    sub sp, sp, #16         // bajar sp 16 bytes; el stack crece hacia abajo

    // guardar dos valores en el espacio reservado
    mov x1, #33             // primer valor temporal
    str x1, [sp, #8]        // guardar x1 en la mitad alta del bloque
    mov x2, #7              // segundo valor temporal
    str x2, [sp]            // guardar x2 al inicio del bloque reservado

    // recuperar un valor y liberar el espacio
    ldr x3, [sp, #8]        // leer de vuelta el valor 33
    add sp, sp, #16         // restaurar sp al valor original

    // exit(x3)
    mov x0, x3              // usar el valor recuperado como codigo de salida
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 33
