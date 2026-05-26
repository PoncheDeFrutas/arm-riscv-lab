// 09.1 - Contrato de syscall
//
// Objetivo:
//   Mostrar que Linux lee el numero de syscall en x8, argumentos en x0-x5
//   y devuelve el resultado en x0.
//
// Registros usados:
//   x0 = fd para write, luego codigo de salida para exit.
//   x1 = direccion del mensaje.
//   x2 = cantidad de bytes del mensaje.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // write(stdout, msg, msg_len)
    mov x0, #1              // x0 = argumento 1: fd 1 = stdout
    adr x1, msg             // x1 = argumento 2: direccion del mensaje
    mov x2, msg_len         // x2 = argumento 3: cantidad de bytes
    mov x8, #64             // x8 = numero de syscall write
    svc #0                  // entrar al kernel; x0 recibe bytes escritos o error

    // exit(0)
    mov x0, #0              // x0 = argumento 1 de exit: codigo de salida
    mov x8, #93             // x8 = numero de syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg:
    .ascii "Contrato syscall\n" // bytes enviados por write
msg_len = . - msg
