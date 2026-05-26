// 09.2 - exit y write
//
// Objetivo:
//   Formalizar write hacia stdout y stderr, y terminar con exit.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // write(stdout, msg_out, msg_out_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg_out         // direccion del mensaje normal
    mov x2, msg_out_len     // bytes del mensaje normal
    mov x8, #64             // syscall write
    svc #0                  // escribir en stdout

    // write(stderr, msg_err, msg_err_len)
    mov x0, #2              // fd 2 = stderr
    adr x1, msg_err         // direccion del mensaje de diagnostico
    mov x2, msg_err_len     // bytes del mensaje de diagnostico
    mov x8, #64             // syscall write
    svc #0                  // escribir en stderr

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg_out:
    .ascii "stdout desde write\n"
msg_out_len = . - msg_out

msg_err:
    .ascii "stderr desde write\n"
msg_err_len = . - msg_err
