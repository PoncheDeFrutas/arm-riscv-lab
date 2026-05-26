// 11.4 - Funciones no hoja
//
// Objetivo:
//   Proteger x30 y un temporal cuando una funcion llama a otra funcion.
//
// Registros usados:
//   x0 = argumento, retorno de funciones y codigo de salida.
//   x1 = valor original recuperado desde el stack.
//   x8 = numero de syscall Linux AArch64.
//   x29 = frame pointer de funcion_no_hoja.
//   x30 = link register; cada bl lo sobrescribe.

.global _start

.section .text
_start:
    // llamar a una funcion que tambien llama a otra
    mov x0, #20             // argumento inicial para funcion_no_hoja
    bl funcion_no_hoja      // x30 guarda retorno hacia _start

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 62

funcion_no_hoja:
    // prologo: proteger retorno antes de ejecutar otro bl
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // fijar frame pointer de esta funcion

    // guardar temporal que se necesitara despues de la llamada
    sub sp, sp, #16         // reservar espacio para un temporal
    str x0, [sp]            // conservar el argumento original: 20

    // llamada interna que sobrescribe x30
    add x0, x0, #1          // preparar argumento para duplicar: 21
    bl duplicar             // x30 ahora apunta de vuelta a funcion_no_hoja

    // usar el retorno y el temporal guardado
    ldr x1, [sp]            // recuperar argumento original: 20
    add x0, x0, x1          // retorno = 42 + 20 = 62

    // epilogo: liberar local y restaurar retorno real
    add sp, sp, #16         // liberar temporal
    ldp x29, x30, [sp], #16 // restaurar x29 y retorno hacia _start
    ret                     // regresar a _start

duplicar:
    // funcion hoja: no llama a nadie, por eso no necesita guardar x30
    add x0, x0, x0          // duplicar el argumento recibido
    ret                     // volver a funcion_no_hoja
