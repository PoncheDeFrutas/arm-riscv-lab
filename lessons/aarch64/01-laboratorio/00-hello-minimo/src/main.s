/* =========================================================
 * Unidad 01 - Laboratorio ARM64 reproducible
 * Leccion: Hello minimo ARM64
 * Archivo: main.s
 *
 * Linux userland. Sin libc. Solo syscalls write y exit.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados
 * ---------------------------------------------------------
 * x0 = argumento 1 de syscall
 * x1 = argumento 2 de syscall
 * x2 = argumento 3 de syscall
 * x8 = numero de syscall Linux AArch64
 * --------------------------------------------------------- */

.section .data

msg:
    .ascii "Hola ARM64\n"
msg_len = . - msg

.section .text
.global _start

_start:
    /* write(stdout, msg, msg_len) */
    mov     x0, #1
    adr     x1, msg
    mov     x2, msg_len
    mov     x8, #64
    svc     #0

    /* exit(0) */
    mov     x0, #0
    mov     x8, #93
    svc     #0
