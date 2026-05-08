.text
.global triple
.type triple, %function

triple:
    add x0, x0, x0, lsl #1
    ret

.size triple, . - triple
.section .note.GNU-stack,"",@progbits

