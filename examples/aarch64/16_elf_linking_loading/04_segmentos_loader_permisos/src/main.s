// 16.4 - Segmentos, loader y permisos
//
// Objetivo:
//   Crear contenido en varias secciones para observar program headers.
//
// Registros usados:
//   x0 = fd para write y codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x3 = direccion de contador en .data.
//   x4 = valor temporal.
//   x5 = direccion de buffer en .bss.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .rodata
msg:
    .ascii "segmentos\n"
msg_len = . - msg

.section .data
contador:
    .quad 1

.section .bss
buffer:
    .skip 32

.section .text
_start:
    // tocar .data y .bss para que el programa use varias zonas
    adr x3, contador        // direccion de contador inicializado
    ldr x4, [x3]            // cargar contador
    add x4, x4, #1          // incrementar valor
    str x4, [x3]            // guardar contador actualizado
    adr x5, buffer          // direccion de buffer .bss
    str x4, [x5]            // escribir en memoria no inicializada

    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion de rodata
    mov x2, msg_len         // longitud del mensaje
    mov x8, #64             // syscall write
    svc #0                  // imprimir mensaje

    // exit(0)
    mov x0, #0              // codigo exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso
