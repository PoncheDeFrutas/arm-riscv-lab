.text
.global sum9
.type sum9, %function

sum9:
    add x0, x0, x1
    add x0, x0, x2
    add x0, x0, x3
    add x0, x0, x4
    add x0, x0, x5
    add x0, x0, x6
    add x0, x0, x7
    ldr x9, [sp]
    add x0, x0, x9
    ret

.size sum9, . - sum9
.section .note.GNU-stack,"",@progbits

