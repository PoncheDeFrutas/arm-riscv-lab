// 17.4 - Stack frames en GDB
//
// Objetivo:
//   Crear una cadena de frames para leer sp, x29, x30 y bt.
//
// Registros usados:
//   x0 = retorno acumulado y codigo de salida.
//   x1 = local recuperado desde el stack.
//   x8 = numero de syscall Linux AArch64.
//   x29 = frame pointer de cada funcion.
//   x30 = link register guardado en cada frame.

.global _start

.section .text
_start:
    // iniciar cadena de funciones
    bl funcion_a            // llamar funcion con frame

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42

funcion_a:
    // frame de funcion_a
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // fijar frame pointer
    sub sp, sp, #16         // reservar local
    mov x0, #10             // local de funcion_a
    str x0, [sp]            // guardar local
    bl funcion_b            // llamar siguiente frame
    ldr x1, [sp]            // recuperar local
    add x0, x0, x1          // acumular retorno
    add sp, sp, #16         // liberar local
    ldp x29, x30, [sp], #16 // restaurar frame y retorno
    ret                     // volver a _start

funcion_b:
    // frame de funcion_b
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // fijar frame pointer
    sub sp, sp, #16         // reservar local
    mov x0, #20             // local de funcion_b
    str x0, [sp]            // guardar local
    bl funcion_c            // llamar ultimo frame
    ldr x1, [sp]            // recuperar local
    add x0, x0, x1          // acumular retorno
    add sp, sp, #16         // liberar local
    ldp x29, x30, [sp], #16 // restaurar frame y retorno
    ret                     // volver a funcion_a

funcion_c:
    // frame de funcion_c
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // fijar frame pointer
    mov x0, #12             // retorno base para total 42
    ldp x29, x30, [sp], #16 // restaurar frame y retorno
    ret                     // volver a funcion_b
