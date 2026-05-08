.equ STR_DATA, 0
.equ STR_LEN,  8
.equ STR_CAP,  16
.equ STR_SIZE, 24

.data
string_desc:
    .quad string_storage
    .quad 4
    .quad 16

string_storage:
    .ascii "Hola"
    .skip 12

newline:
    .ascii "\n"

.text
.global _start
_start:
    ldr x0, =string_desc
    bl string_write_stdout
    cmp x0, #0
    b.ne error

    ldr x0, =string_desc
    mov w1, #'!'
    bl string_push_byte
    cmp x0, #0
    b.ne error

    ldr x0, =string_desc
    bl string_write_stdout
    cmp x0, #0
    b.ne error

    mov x0, #0
    mov x8, #93
    svc #0

error:
    mov x0, #1
    mov x8, #93
    svc #0

string_push_byte:
    ldr x2, [x0, #STR_DATA]
    ldr x3, [x0, #STR_LEN]
    ldr x4, [x0, #STR_CAP]

    cmp x3, x4
    b.hs string_full

    strb w1, [x2, x3]
    add x3, x3, #1
    str x3, [x0, #STR_LEN]

    mov x0, #0
    ret

string_full:
    mov x0, #-1
    ret

string_write_stdout:
    mov x5, x0

    mov x0, #1
    ldr x1, [x5, #STR_DATA]
    ldr x2, [x5, #STR_LEN]
    mov x8, #64
    svc #0
    cmp x0, #0
    b.lt string_write_error

    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    cmp x0, #0
    b.lt string_write_error

    mov x0, #0
    ret

string_write_error:
    mov x0, #-1
    ret
