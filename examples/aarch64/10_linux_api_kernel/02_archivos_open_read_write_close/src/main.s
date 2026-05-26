// 10.2 - Archivos con openat, read, write y close
//
// Objetivo:
//   Leer un archivo local, escribir la cantidad real leida y cerrar el fd.
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
    adr x1, path            // ruta del archivo de entrada
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno de openat
    b.lt error_sin_fd       // lt = menor signed: error antes de tener fd
    mov x19, x0             // guardar fd para read y close

    // read(fd, buffer, 128)
    mov x0, x19             // fd abierto
    adr x1, buffer          // direccion del buffer en .bss
    mov x2, #128            // maximo de bytes a leer
    mov x8, #63             // syscall read
    svc #0                  // x0 = bytes leidos, 0 EOF, o error negativo
    cmp x0, #0              // revisar error negativo
    b.lt cleanup            // lt = menor signed: cerrar antes de salir
    mov x20, x0             // guardar cantidad real leida

    // write(stdout, buffer, bytes_leidos)
    mov x0, #1              // fd 1 = stdout
    adr x1, buffer          // bytes que read escribio
    mov x2, x20             // cantidad real, no tamano del buffer
    mov x8, #64             // syscall write
    svc #0                  // x0 = bytes escritos o error negativo
    cmp x0, #0              // revisar retorno de write
    b.lt cleanup            // lt = menor signed: cerrar antes de salir

    // close(fd)
    mov x0, x19             // fd guardado
    mov x8, #57             // syscall close
    svc #0                  // cerrar recurso
    cmp x0, #0              // revisar retorno de close
    b.lt error_sin_fd       // lt = menor signed: ya se intento cerrar

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

cleanup:
    // close(fd) antes de salir por error posterior a openat
    mov x0, x19             // fd vivo que debe cerrarse
    mov x8, #57             // syscall close
    svc #0                  // ignorar retorno durante cleanup minimo

error_sin_fd:
    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "10_linux_api_kernel/02_archivos_open_read_write_close/entrada.txt"

.section .bss
buffer:
    .skip 128               // espacio para bytes leidos desde archivo
