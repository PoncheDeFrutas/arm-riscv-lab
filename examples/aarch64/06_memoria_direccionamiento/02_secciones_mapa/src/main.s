// 06.2 - Secciones y mapa de memoria
//
// Objetivo:
//   Ver como .text, .rodata, .data y .bss separan codigo y datos.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje y direccion del buffer.
//   x2 = longitud del mensaje.
//   w3 = byte temporal escrito en .bss.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // escribir un byte en .bss para observarlo en memoria
    adr x1, buffer          // x1 apunta a una zona reservada en .bss
    mov w3, #'A'            // byte visible para inspeccion en GDB
    strb w3, [x1]           // guardar el byte en buffer[0]

    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion del mensaje constante en .rodata
    mov x2, msg_len         // cantidad de bytes a escribir
    mov x8, #64             // syscall write
    svc #0                  // pedir al kernel que imprima el mensaje

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar el proceso

.section .rodata
msg:
    .ascii "Secciones 06\n" // texto constante de solo lectura
msg_len = . - msg

.section .data
contador:
    .word 1                 // dato inicializado y modificable

.section .bss
buffer:
    .skip 8                 // memoria reservada que inicia en cero
