.text
.global sumar
.type sumar, %function

sumar:
    add x0, x0, x1
    ret

.size sumar, . - sumar
.section .note.GNU-stack,"",@progbits

