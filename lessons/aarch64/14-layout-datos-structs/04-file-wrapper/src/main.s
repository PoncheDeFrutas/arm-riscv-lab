.equ FILE_FD,    0
.equ FILE_FLAGS, 8
.equ FILE_SIZE,  16

.equ AT_FDCWD, -100
.equ O_FLAGS, 577        // O_WRONLY | O_CREAT | O_TRUNC

.data
file_obj:
    .quad -1
    .quad 0

filename:
    .asciz "/tmp/u14_file_wrapper_demo.txt"

message:
    .ascii "archivo creado desde file wrapper\n"
message_len = . - message

.text
.global _start
_start:
    ldr x0, =file_obj
    bl file_init

    mov x0, #AT_FDCWD
    ldr x1, =filename
    mov x2, #O_FLAGS
    mov x3, #0644
    mov x8, #56
    svc #0
    cmp x0, #0
    b.lt error

    ldr x9, =file_obj
    str x0, [x9, #FILE_FD]

    mov x10, x0
    mov x0, x10
    ldr x1, =message
    mov x2, #message_len
    mov x8, #64
    svc #0
    cmp x0, #0
    b.lt cleanup_error

    ldr x0, =file_obj
    bl file_close

    mov x0, #0
    mov x8, #93
    svc #0

cleanup_error:
    ldr x0, =file_obj
    bl file_close

error:
    mov x0, #1
    mov x8, #93
    svc #0

file_init:
    mov x1, #-1
    str x1, [x0, #FILE_FD]
    str xzr, [x0, #FILE_FLAGS]
    ret

file_close:
    ldr x1, [x0, #FILE_FD]
    cmp x1, #0
    b.lt file_close_done

    mov x3, x0
    mov x0, x1
    mov x8, #57
    svc #0

    mov x1, #-1
    str x1, [x3, #FILE_FD]

file_close_done:
    ret
