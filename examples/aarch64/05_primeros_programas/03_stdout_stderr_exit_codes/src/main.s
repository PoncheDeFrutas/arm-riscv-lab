// 05.3 - stdout, stderr y codigos de salida
//
// Objetivo:
//   Distinguir fd de write y codigo de salida de exit.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // write(stderr, msg, msg_len)
    mov x0, #2              // para write: fd 2 = stderr
    adr x1, msg             // direccion del mensaje de error
    mov x2, msg_len         // cantidad de bytes a escribir
    mov x8, #64             // syscall write
    svc #0                  // escribir en stderr

    // exit(2)
    mov x0, #2              // para exit: codigo de salida 2
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg:
    .ascii "Error de ejemplo\n" // mensaje escrito en stderr
msg_len = . - msg
