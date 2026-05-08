.equ POINT_X, 0
.equ POINT_Y, 8
.equ POINT_SIZE, 16

.data
point1:
    .quad 10
    .quad 20

.text
.global _start
_start:
    ldr x3, =point1
    ldr x1, [x3, #POINT_X]
    ldr x2, [x3, #POINT_Y]

    add x4, x1, x2
    cmp x4, #30
    b.ne error

    mov x0, #0
    mov x8, #93
    svc #0

error:
    mov x0, #1
    mov x8, #93
    svc #0
