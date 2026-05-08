.text
.global main
.type main, %function
.extern funcion_c

main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x0, #7
    mov x1, #5
    bl funcion_c

    cmp x0, #12
    cset x0, ne

    ldp x29, x30, [sp], #16
    ret

.size main, . - main
.section .note.GNU-stack,"",@progbits

