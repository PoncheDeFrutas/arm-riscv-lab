// 10.6 - Programa guiado con recursos
//
// Objetivo:
//   Leer archivo, escribir a stdout, cerrar fd y usar cleanup si algo falla.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de ruta o buffer.
//   x2 = flags, maximo de lectura o bytes a escribir.
//   x3 = modo de creacion.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd guardado.
//   x20 = cantidad real leida.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path            // archivo local de entrada
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno antes de guardar fd
    b.lt error_sin_fd       // lt = menor signed: no hay fd que cerrar
    mov x19, x0             // guardar fd vivo

    // read(fd, buffer, 128)
    mov x0, x19             // fd abierto
    adr x1, buffer          // buffer donde read copiara bytes
    mov x2, #128            // maximo de lectura
    mov x8, #63             // syscall read
    svc #0                  // x0 = bytes leidos, 0 EOF, o error negativo
    cmp x0, #0              // revisar error negativo
    b.lt cleanup            // lt = menor signed: cerrar antes de salir
    mov x20, x0             // guardar cantidad real leida

    // write(stdout, buffer, bytes_leidos)
    mov x0, #1              // fd 1 = stdout
    adr x1, buffer          // bytes leidos
    mov x2, x20             // cantidad real que read devolvio
    mov x8, #64             // syscall write
    svc #0                  // x0 = bytes escritos o error negativo
    cmp x0, #0              // revisar retorno de write
    b.lt cleanup            // lt = menor signed: cerrar antes de salir

    // close(fd)
    mov x0, x19             // fd guardado
    mov x8, #57             // syscall close
    svc #0                  // x0 = 0 o error negativo
    cmp x0, #0              // revisar retorno de close
    b.lt error_sin_fd       // lt = menor signed: ya no se hace cleanup

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

cleanup:
    // close(fd) porque el recurso ya estaba abierto
    mov x0, x19             // fd que debe liberarse
    mov x8, #57             // syscall close
    svc #0                  // ignorar retorno durante cleanup minimo

error_sin_fd:
    // write(stderr, msg_error, msg_error_len)
    mov x0, #2              // fd 2 = stderr
    adr x1, msg_error       // diagnostico generico
    mov x2, msg_error_len   // cantidad exacta de bytes
    mov x8, #64             // syscall write
    svc #0                  // escribir error

    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "10_linux_api_kernel/06_programa_recursos/entrada.txt"

msg_error:
    .ascii "Error en recurso\n"
msg_error_len = . - msg_error

.section .bss
buffer:
    .skip 128               // buffer de lectura
