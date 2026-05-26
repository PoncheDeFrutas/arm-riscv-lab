// 15.3 - Caller-saved, callee-saved y funciones correctas
//
// Objetivo:
//   Usar x19 dentro de una funcion y restaurarlo antes de retornar.
//
// Registros usados:
//   x0 = retorno de usar_x19 y codigo de salida.
//   x8 = numero de syscall Linux AArch64.
//   x19 = registro callee-saved que el caller espera intacto.
//   x30 = link register guardado junto a x19.

.global _start

.section .text
_start:
    // preparar valor que debe sobrevivir a la llamada
    mov x19, #40            // el caller conserva dato importante en x19
    bl usar_x19             // la funcion debe preservar x19
    add x0, x0, x19         // retorno 2 + x19 preservado 40 = 42

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42

usar_x19:
    // preservar registro callee-saved y retorno
    stp x19, x30, [sp, #-16]! // guardar x19 original y x30

    // usar x19 como temporal interno
    mov x19, #100           // valor interno que no debe escapar al caller
    sub x0, x19, #98        // retorno = 2

    // restaurar entorno del caller
    ldp x19, x30, [sp], #16 // recuperar x19 original y retorno
    ret                     // volver a _start
