// 13.5 - mmap con archivo
//
// Objetivo:
//   Abrir un archivo, mapearlo, escribir su contenido y limpiar fd/region.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = ruta, direccion mapeada o longitud.
//   x2 = flags, permisos o longitud de write.
//   x3 = modo de openat o flags de mmap.
//   x4 = fd para mmap.
//   x5 = offset para mmap.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd abierto.
//   x20 = base de la region mapeada.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0
.equ PROT_READ, 1
.equ MAP_PRIVATE, 2
.equ FILE_LEN, 16
.equ SYS_openat, 56
.equ SYS_close, 57
.equ SYS_write, 64
.equ SYS_mmap, 222
.equ SYS_munmap, 215
.equ SYS_exit, 93

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path            // ruta relativa del archivo del ejemplo
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #SYS_openat     // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar si openat fallo
    b.lt error_sin_fd       // lt = no hay fd que cerrar
    mov x19, x0             // guardar fd vivo

    // mmap(NULL, FILE_LEN, PROT_READ, MAP_PRIVATE, fd, 0)
    mov x0, #0              // addr = NULL
    mov x1, #FILE_LEN       // longitud exacta a mapear
    mov x2, #PROT_READ      // region solo lectura
    mov x3, #MAP_PRIVATE    // cambios privados
    mov x4, x19             // fd del archivo abierto
    mov x5, #0              // offset desde el inicio del archivo
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = base mapeada o error
    cmp x0, #0              // revisar retorno
    b.lt cleanup_fd         // lt = cerrar fd antes de reportar error
    mov x20, x0             // guardar base de region

    // close(fd) porque el mapeo ya mantiene la referencia necesaria
    mov x0, x19             // fd abierto
    mov x8, #SYS_close      // syscall close
    svc #0                  // cerrar fd
    cmp x0, #0              // revisar retorno
    b.lt cleanup_region     // lt = region sigue viva y debe liberarse

    // write(stdout, mapped, FILE_LEN)
    mov x0, #1              // fd 1 = stdout
    mov x1, x20             // direccion mapeada del archivo
    mov x2, #FILE_LEN       // cantidad exacta de bytes del archivo
    mov x8, #SYS_write      // syscall write
    svc #0                  // imprimir contenido mapeado
    cmp x0, #0              // revisar write como signed
    b.lt cleanup_region     // lt = liberar region antes de reportar error

    // munmap(mapped, FILE_LEN)
    mov x0, x20             // base mapeada
    mov x1, #FILE_LEN       // longitud usada en mmap
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // liberar region
    cmp x0, #0              // revisar retorno
    b.lt error_sin_fd       // lt = ya no hay fd vivo

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

cleanup_region:
    // liberar region viva
    mov x0, x20             // base mapeada
    mov x1, #FILE_LEN       // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // cleanup de memoria
    b error_sin_fd          // reportar error comun

cleanup_fd:
    // cerrar fd vivo
    mov x0, x19             // fd abierto
    mov x8, #SYS_close      // syscall close
    svc #0                  // cleanup de fd

error_sin_fd:
    mov x0, #1              // codigo 1 = fallo de recurso

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "13_mmap_paginas_permisos/05_mmap_con_archivo/entrada.txt"
