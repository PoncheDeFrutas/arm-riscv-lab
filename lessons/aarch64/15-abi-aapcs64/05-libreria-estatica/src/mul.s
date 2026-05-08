.text
.global mul
.type mul, %function

mul:
    mul x0, x0, x1
    ret

.size mul, . - mul
.section .note.GNU-stack,"",@progbits

