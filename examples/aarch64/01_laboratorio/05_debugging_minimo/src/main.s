// 01.5 - Debugging minimo
//
// Objetivo:
//   Tener un programa corto para practicar breakpoints, registros y stepi.
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
    adr x1, msg             // direccion que conviene inspeccionar con x/s $x1
    mov x2, msg_len         // longitud que write usara
    mov x8, #64             // syscall write
    svc #0                  // primer punto interesante de depuracion

    // exit(0)
    mov x0, #0              // codigo de salida
    mov x8, #93             // syscall exit
    svc #0                  // segundo punto interesante de depuracion

.section .rodata
msg:
    .ascii "Debug\n"        // texto pequeno para inspeccionar en memoria
msg_len = . - msg
