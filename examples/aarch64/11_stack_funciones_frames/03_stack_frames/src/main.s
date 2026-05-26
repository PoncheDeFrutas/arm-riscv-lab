// 11.3 - Stack frames
//
// Objetivo:
//   Crear un frame con x29/x30 y usar espacio local en el stack.
//
// Registros usados:
//   x0 = retorno de calcular y codigo de salida.
//   x1 = valor local inicial.
//   x2 = copia leida desde el stack.
//   x8 = numero de syscall Linux AArch64.
//   x29 = frame pointer de la funcion actual.
//   x30 = link register; retorno guardado por bl.

.global _start

.section .text
_start:
    // llamar a una funcion con frame propio
    bl calcular             // x30 recibe el retorno hacia _start

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el retorno de calcular

calcular:
    // prologo del frame
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // x29 apunta al inicio del frame actual

    // reservar y usar variable local
    sub sp, sp, #16         // reservar 16 bytes para locales
    mov x1, #40             // valor base del calculo
    str x1, [sp]            // guardar local en el stack
    ldr x2, [sp]            // recuperar local desde el stack
    add x0, x2, #2          // retorno = 40 + 2

    // epilogo del frame
    add sp, sp, #16         // liberar espacio de locales
    ldp x29, x30, [sp], #16 // restaurar frame anterior y retorno
    ret                     // regresar a _start usando x30 restaurado
