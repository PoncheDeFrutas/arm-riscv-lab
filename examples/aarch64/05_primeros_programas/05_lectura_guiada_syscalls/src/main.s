// 05.5 - Lectura guiada de syscalls
//
// Objetivo:
//   Leer cada syscall preguntando que hay en x8 y que significan sus argumentos.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // Pregunta 1: x8 = 64, entonces x0-x2 son argumentos de write.
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion del mensaje
    mov x2, msg_len         // bytes a escribir
    mov x8, #64             // syscall write
    svc #0                  // ejecutar write

    // Pregunta 2: x8 = 93, entonces x0 es codigo de salida.
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // ejecutar exit

.section .rodata
msg:
    .ascii "Syscall\n"      // texto para la syscall write
msg_len = . - msg
