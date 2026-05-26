// 17.5 - QEMU y gdbserver
//
// Objetivo:
//   Tener un programa simple para depurar con QEMU -g y gdb-multiarch.
//
// Registros usados:
//   x0 = fd para write y codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .rodata
msg:
    .ascii "qemu gdbserver\n"
msg_len = . - msg

.section .text
_start:
    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion del mensaje
    mov x2, msg_len         // longitud exacta
    mov x8, #64             // syscall write
    svc #0                  // imprimir mensaje

    // exit(0)
    mov x0, #0              // codigo exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso
