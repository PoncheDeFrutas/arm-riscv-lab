// 10.4 - Posicion y metadatos
//
// Objetivo:
//   Usar fstat para metadatos y lseek para mover la posicion de lectura.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de ruta, buffer de stat o offset.
//   x2 = flags de openat, whence de lseek o cantidad de read.
//   x3 = modo de creacion.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd guardado.
//   x21 = byte leido despues de lseek.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0
.equ SEEK_SET, 0

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path            // archivo local del ejemplo
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno de openat
    b.lt error_sin_fd       // lt = menor signed: no hay fd que cerrar
    mov x19, x0             // guardar fd para fstat/lseek/read/close

    // fstat(fd, statbuf)
    mov x0, x19             // fd abierto
    adr x1, statbuf         // buffer donde el kernel escribira metadatos
    mov x8, #80             // syscall fstat
    svc #0                  // x0 = 0 o error negativo
    cmp x0, #0              // revisar retorno de fstat
    b.lt cleanup            // lt = menor signed: cerrar antes de salir

    // lseek(fd, 5, SEEK_SET)
    mov x0, x19             // fd abierto
    mov x1, #5              // mover posicion al byte 5
    mov x2, #SEEK_SET       // origen: inicio del archivo
    mov x8, #62             // syscall lseek
    svc #0                  // x0 = nueva posicion o error negativo
    cmp x0, #0              // lseek retorna offset; negativo es error
    b.lt cleanup            // lt = menor signed: cerrar antes de salir

    // read(fd, bytebuf, 1)
    mov x0, x19             // fd abierto en posicion 5
    adr x1, bytebuf         // buffer de 1 byte
    mov x2, #1              // leer un solo byte
    mov x8, #63             // syscall read
    svc #0                  // x0 = bytes leidos o error negativo
    cmp x0, #0              // revisar error negativo
    b.lt cleanup            // lt = menor signed: cerrar antes de salir
    adr x1, bytebuf         // recuperar direccion del byte leido
    ldrb w21, [x1]          // guardar byte para usarlo despues de close

    // close(fd)
    mov x0, x19             // fd guardado
    mov x8, #57             // syscall close
    svc #0                  // cerrar recurso

    // exit(byte)
    mov x0, x21             // devolver byte leido despues de lseek
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

cleanup:
    // close(fd) antes de error
    mov x0, x19             // fd vivo
    mov x8, #57             // syscall close
    svc #0                  // liberar recurso

error_sin_fd:
    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "10_linux_api_kernel/04_posicion_metadatos/entrada.txt"

.section .bss
statbuf:
    .skip 256               // espacio suficiente para struct stat en este laboratorio
bytebuf:
    .skip 1                 // byte leido despues de lseek
