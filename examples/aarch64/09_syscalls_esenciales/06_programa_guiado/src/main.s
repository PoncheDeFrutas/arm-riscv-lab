// 09.6 - Programa guiado de syscalls
//
// Objetivo:
//   Abrir un archivo, escribir un mensaje, cerrar el fd y manejar error minimo.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de ruta o mensaje.
//   x2 = flags o longitud.
//   x3 = modo de creacion.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd guardado para write y close.

.equ AT_FDCWD, -100
.equ O_WRONLY, 1
.equ O_CREAT, 64
.equ O_TRUNC, 512
.equ MODE_0644, 420

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_WRONLY|O_CREAT|O_TRUNC, 0644)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path            // ruta del archivo de salida
    mov x2, #(O_WRONLY | O_CREAT | O_TRUNC) // crear/truncar para escritura
    mov x3, #MODE_0644      // permisos iniciales del archivo
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno antes de usarlo como fd
    b.lt error              // lt = menor signed: error si x0 < 0
    mov x19, x0             // guardar fd para llamadas posteriores

    // write(fd, msg, msg_len)
    mov x0, x19             // fd guardado
    adr x1, msg             // mensaje a escribir
    mov x2, msg_len         // cantidad exacta de bytes
    mov x8, #64             // syscall write
    svc #0                  // x0 = bytes escritos o error negativo
    cmp x0, #0              // revisar retorno de write
    b.lt error              // lt = menor signed: error si x0 < 0

    // close(fd)
    mov x0, x19             // fd que debe cerrarse
    mov x8, #57             // syscall close
    svc #0                  // x0 = 0 o error negativo
    cmp x0, #0              // revisar retorno de close
    b.lt error              // lt = menor signed: error si x0 < 0

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

error:
    // write(stderr, msg_error, msg_error_len)
    mov x0, #2              // fd 2 = stderr
    adr x1, msg_error       // mensaje comun de error
    mov x2, msg_error_len   // cantidad exacta de bytes
    mov x8, #64             // syscall write
    svc #0                  // escribir diagnostico minimo

    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "09_syscalls_esenciales/06_programa_guiado/salida_guiada.txt"

msg:
    .ascii "Creado con syscalls AArch64\n"
msg_len = . - msg

msg_error:
    .ascii "Error en syscall\n"
msg_error_len = . - msg_error
