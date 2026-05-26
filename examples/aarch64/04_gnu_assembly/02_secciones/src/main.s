// 04.2 - Secciones
//
// Objetivo:
//   Separar codigo, datos de solo lectura, datos modificables y bss.
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
    adr x1, msg             // mensaje en .rodata
    mov x2, msg_len         // bytes a escribir
    mov x8, #64             // syscall write
    svc #0                  // imprimir mensaje

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg:
    .ascii "Secciones\n"    // dato constante de solo lectura
msg_len = . - msg

.section .data
contador:
    .word 1                 // dato inicializado y modificable

.section .bss
buffer:
    .skip 16                // espacio reservado sin bytes explicitos
