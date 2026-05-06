/* Proyecto mínimo ARM64 en Linux userland. */

.section .data

msg:
    .ascii "Hola proyecto ARM64\n"
msg_len = . - msg

.section .text
.global _start

_start:
    mov     x0, #1
    adr     x1, msg
    mov     x2, msg_len
    mov     x8, #64
    svc     #0

    mov     x0, #0
    mov     x8, #93
    svc     #0
