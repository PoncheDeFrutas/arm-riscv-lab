// 09.5 - Errores minimos
//
// Objetivo:
//   Detectar retorno negativo de syscall con cmp + b.lt y escribir a stderr.
//
// Registros usados:
//   x0 = retorno de openat, fd para write y codigo para exit.
//   x1 = direccion de ruta o mensaje de error.
//   x2 = flags de openat o longitud del mensaje.
//   x3 = modo de creacion.
//   x8 = numero de syscall Linux AArch64.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0

.global _start

.section .text
_start:
    // openat(AT_FDCWD, missing_path, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, missing_path    // ruta que no debe existir
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no importa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // comparar retorno como signed contra cero
    b.lt error              // lt = menor signed: saltar si x0 < 0

    // exit(0) solo si openat no fallo
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

error:
    // write(stderr, msg_error, msg_error_len)
    mov x0, #2              // fd 2 = stderr
    adr x1, msg_error       // mensaje generico de error
    mov x2, msg_error_len   // cantidad de bytes del mensaje
    mov x8, #64             // syscall write
    svc #0                  // escribir diagnostico minimo

    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
missing_path:
    .asciz "09_syscalls_esenciales/05_errores_minimos/no_existe.txt"

msg_error:
    .ascii "Error minimo: openat fallo\n"
msg_error_len = . - msg_error
