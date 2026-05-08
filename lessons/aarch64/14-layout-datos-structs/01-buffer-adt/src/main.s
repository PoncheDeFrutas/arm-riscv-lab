.equ BUF_DATA, 0
.equ BUF_LEN,  8
.equ BUF_CAP,  16
.equ BUF_SIZE, 24

.bss
storage:
    .skip 4

.data
buffer_desc:
    .quad storage
    .quad 0
    .quad 4

.text
.global _start
_start:
    ldr x0, =buffer_desc
    mov w1, #'A'
    bl buffer_push_byte
    cmp x0, #0
    b.ne error

    ldr x0, =buffer_desc
    mov w1, #'B'
    bl buffer_push_byte
    cmp x0, #0
    b.ne error

    ldr x0, =buffer_desc
    bl buffer_clear

    mov x0, #0
    mov x8, #93
    svc #0

error:
    mov x0, #1
    mov x8, #93
    svc #0

buffer_push_byte:
    ldr x2, [x0, #BUF_DATA]
    ldr x3, [x0, #BUF_LEN]
    ldr x4, [x0, #BUF_CAP]

    cmp x3, x4
    b.hs buffer_full

    strb w1, [x2, x3]
    add x3, x3, #1
    str x3, [x0, #BUF_LEN]

    mov x0, #0
    ret

buffer_full:
    mov x0, #-1
    ret

buffer_clear:
    str xzr, [x0, #BUF_LEN]
    ret
