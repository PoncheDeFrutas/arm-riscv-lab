.text
.global usar_x19
.type usar_x19, %function

usar_x19:
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    str x19, [sp, #16]

    mov x19, x0
    add x0, x19, #1

    ldr x19, [sp, #16]
    ldp x29, x30, [sp], #32
    ret

.size usar_x19, . - usar_x19
.section .note.GNU-stack,"",@progbits

