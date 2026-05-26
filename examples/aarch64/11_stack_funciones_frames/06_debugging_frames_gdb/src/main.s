// 11.6 - Debugging de frames con GDB
//
// Objetivo:
//   Crear una cadena de llamadas con frames claros para inspeccionarlos en GDB.
//
// Registros usados:
//   x0 = retorno parcial de cada funcion y codigo de salida.
//   x1 = valor local recuperado desde el frame actual.
//   x8 = numero de syscall Linux AArch64.
//   x29 = frame pointer enlazado entre funciones.
//   x30 = link register guardado y restaurado por cada frame.

.global _start

.section .text
_start:
    // iniciar cadena de llamadas
    bl funcion_a            // llamar a la primera funcion con frame

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42

funcion_a:
    // frame de funcion_a
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno a _start
    mov x29, sp             // x29 identifica el frame de funcion_a
    sub sp, sp, #16         // reservar espacio para local de funcion_a
    mov x0, #10             // valor local de funcion_a
    str x0, [sp]            // guardar local antes de llamar a funcion_b

    // llamada anidada
    bl funcion_b            // x30 cambia; el retorno anterior esta en el frame
    ldr x1, [sp]            // recuperar local de funcion_a
    add x0, x0, x1          // acumular retorno de funcion_b + 10

    // salir de funcion_a
    add sp, sp, #16         // liberar local
    ldp x29, x30, [sp], #16 // restaurar frame anterior y retorno
    ret                     // volver a _start

funcion_b:
    // frame de funcion_b
    stp x29, x30, [sp, #-16]! // guardar frame de funcion_a y retorno
    mov x29, sp             // x29 identifica el frame de funcion_b
    sub sp, sp, #16         // reservar espacio para local de funcion_b
    mov x0, #20             // valor local de funcion_b
    str x0, [sp]            // guardar local antes de llamar a funcion_c

    // llamada mas profunda
    bl funcion_c            // llamar al ultimo nivel de la cadena
    ldr x1, [sp]            // recuperar local de funcion_b
    add x0, x0, x1          // acumular retorno de funcion_c + 20

    // salir de funcion_b
    add sp, sp, #16         // liberar local
    ldp x29, x30, [sp], #16 // restaurar frame de funcion_a y retorno
    ret                     // volver a funcion_a

funcion_c:
    // frame de funcion_c
    stp x29, x30, [sp, #-16]! // guardar frame de funcion_b y retorno
    mov x29, sp             // x29 identifica el frame de funcion_c
    mov x0, #12             // retorno base para completar 10 + 20 + 12

    // salir de funcion_c
    ldp x29, x30, [sp], #16 // restaurar frame de funcion_b y retorno
    ret                     // volver a funcion_b
