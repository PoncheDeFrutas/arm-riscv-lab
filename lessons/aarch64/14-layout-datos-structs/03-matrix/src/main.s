.equ MAT_DATA, 0
.equ MAT_ROWS, 8
.equ MAT_COLS, 16
.equ MAT_SIZE, 24

.data
matrix_desc:
    .quad matrix_data
    .quad 2
    .quad 3

matrix_data:
    .quad 1, 2, 3
    .quad 4, 5, 6

.text
.global _start
_start:
    ldr x0, =matrix_desc
    mov x1, #1
    mov x2, #2
    bl matrix_get_u64

    cmp x0, #0
    b.lt error

    cmp x0, #6
    b.ne error

    mov x0, #0
    mov x8, #93
    svc #0

error:
    mov x0, #1
    mov x8, #93
    svc #0

matrix_get_u64:
    ldr x3, [x0, #MAT_ROWS]
    cmp x1, x3
    b.hs matrix_oob

    ldr x4, [x0, #MAT_COLS]
    cmp x2, x4
    b.hs matrix_oob

    ldr x5, [x0, #MAT_DATA]
    mul x6, x1, x4
    add x6, x6, x2
    lsl x6, x6, #3
    ldr x0, [x5, x6]
    ret

matrix_oob:
    mov x0, #-1
    ret
