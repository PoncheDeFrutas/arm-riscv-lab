// 13.6 - Errores y diagnostico
//
// Objetivo:
//   Detectar un error negativo de mmap sin provocar un fallo de memoria.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = longitud invalida o direccion del mensaje.
//   x2 = permisos o longitud del mensaje.
//   x3 = flags de mmap.
//   x4 = fd para mmap anonimo.
//   x5 = offset para mmap.
//   x8 = numero de syscall Linux AArch64.

.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_PRIVATE, 2
.equ MAP_ANONYMOUS, 32
.equ SYS_mmap, 222
.equ SYS_write, 64
.equ SYS_exit, 93

.global _start

.section .text
_start:
    // mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
    mov x0, #0              // addr = NULL
    mov x1, #0              // longitud invalida: mmap debe fallar
    mov x2, #(PROT_READ | PROT_WRITE) // permisos normales
    mov x3, #(MAP_PRIVATE | MAP_ANONYMOUS) // privado y anonimo
    mov x4, #-1             // fd = -1
    mov x5, #0              // offset = 0
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = error negativo esperado
    cmp x0, #0              // revisar retorno signed
    b.lt error_esperado     // lt = fallo esperado por longitud cero

    // si mmap no fallo, el diagnostico esperado no se cumplio
    mov x0, #2              // codigo 2 = resultado inesperado
    b salir                 // saltar a salida comun

error_esperado:
    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion del mensaje
    mov x2, msg_len         // cantidad exacta de bytes
    mov x8, #SYS_write      // syscall write
    svc #0                  // imprimir diagnostico

    // exit(0)
    mov x0, #0              // codigo exitoso porque el fallo era esperado

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso

.section .rodata
msg:
    .ascii "mmap fallo como se esperaba\n"
msg_len = . - msg
