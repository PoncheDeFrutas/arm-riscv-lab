.text
.global main
.type main, %function
.extern printf

main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    adrp x0, fmt
    add x0, x0, :lo12:fmt
    mov x1, #42
    bl printf

    mov x0, #0
    ldp x29, x30, [sp], #16
    ret

.size main, . - main

.section .rodata
fmt:
    .asciz "valor = %ld\n"

.section .note.GNU-stack,"",@progbits

