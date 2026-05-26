// 15.6 - C desde assembly y printf
//
// Objetivo:
//   Definir main en assembly y llamar printf como funcion de libc.
//
// Registros usados:
//   x0 = primer argumento de printf y retorno de main.
//   x1 = segundo argumento de printf.
//   x29 = frame pointer de main.
//   x30 = link register que main debe preservar antes de llamar printf.

.global main
.type main, %function
.extern printf

.section .rodata
fmt:
    .asciz "printf desde assembly: %ld\n"

.section .text
main:
    // prologo de main porque llamara a printf
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno a libc
    mov x29, sp             // fijar frame pointer

    // printf(fmt, 42)
    adr x0, fmt             // primer argumento: formato
    mov x1, #42             // segundo argumento: valor para %ld
    bl printf               // llamar funcion C externa

    // return 0
    mov w0, #0              // retorno de main = 0
    ldp x29, x30, [sp], #16 // restaurar frame y retorno
    ret                     // volver al runtime de C

.size main, . - main
