// 05.2 - Hello World con write
//
// Objetivo:
//   Escribir bytes en stdout usando write, sin printf ni libc.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion inicial del mensaje
    mov x2, msg_len         // cantidad de bytes
    mov x8, #64             // syscall write
    svc #0                  // pedir al kernel que escriba

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg:
    .ascii "Hola AArch64\n" // bytes que write enviara
msg_len = . - msg           // longitud del mensaje
