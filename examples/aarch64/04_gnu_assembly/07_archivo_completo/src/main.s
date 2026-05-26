// 04.7 - Lectura guiada de archivo completo
//
// Objetivo:
//   Leer un .s completo con constantes, secciones, datos e instrucciones.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall.

.equ SYS_write, 64          // syscall write
.equ SYS_exit, 93           // syscall exit
.equ STDOUT, 1              // fd stdout
.equ EXIT_OK, 0             // codigo de salida exitoso

.global _start

.section .text
_start:
    // write(STDOUT, msg, msg_len)
    mov x0, #STDOUT         // destino de escritura
    adr x1, msg             // direccion del mensaje
    mov x2, msg_len         // longitud calculada por el assembler
    mov x8, #SYS_write      // syscall write
    svc #0                  // imprimir mensaje

    // exit(EXIT_OK)
    mov x0, #EXIT_OK        // codigo de salida
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg:
    .ascii "Hola GNU Assembly\n" // mensaje constante
msg_len = . - msg
