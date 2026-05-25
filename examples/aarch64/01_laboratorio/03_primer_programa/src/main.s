// 01.3 - Primer programa AArch64
//
// Objetivo:
//   Escribir un mensaje en stdout con write y terminar con exit.
//
// Registros usados:
//   x0 = primer argumento de syscall: fd para write, codigo para exit.
//   x1 = segundo argumento de write: direccion del mensaje.
//   x2 = tercer argumento de write: cantidad de bytes.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .data
msg:
    .ascii "Hola ARM64\n"
msg_len = . - msg

.section .text
_start:
    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion inicial de los bytes a escribir
    mov x2, msg_len         // cantidad de bytes del mensaje
    mov x8, #64             // syscall write
    svc #0                  // entrar al kernel

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0
