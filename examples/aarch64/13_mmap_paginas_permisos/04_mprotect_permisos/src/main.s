// 13.4 - mprotect, permisos y W^X
//
// Objetivo:
//   Cambiar una region RW a solo lectura y leer sin escribir despues del cambio.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = longitud de la region.
//   x2 = permisos de mmap o mprotect.
//   x3 = flags de mmap.
//   x4 = fd para mmap anonimo.
//   x5 = offset para mmap.
//   x8 = numero de syscall Linux AArch64.
//   x19 = base de la region mapeada.
//   w20 = byte escrito y leido.

.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_PRIVATE, 2
.equ MAP_ANONYMOUS, 32
.equ PAGE_SIZE, 4096
.equ SYS_mmap, 222
.equ SYS_munmap, 215
.equ SYS_mprotect, 226
.equ SYS_exit, 93

.global _start

.section .text
_start:
    // mmap con permisos RW
    mov x0, #0              // addr = NULL
    mov x1, #PAGE_SIZE      // longitud de una pagina
    mov x2, #(PROT_READ | PROT_WRITE) // permisos iniciales RW
    mov x3, #(MAP_PRIVATE | MAP_ANONYMOUS) // privado y anonimo
    mov x4, #-1             // fd = -1
    mov x5, #0              // offset = 0
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = base o error
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = no hay region viva
    mov x19, x0             // guardar base para mprotect y munmap

    // escribir antes de quitar PROT_WRITE
    mov w20, #82            // byte ASCII 'R'
    strb w20, [x19]         // escritura valida mientras la region es RW

    // mprotect(base, PAGE_SIZE, PROT_READ)
    mov x0, x19             // base de la region
    mov x1, #PAGE_SIZE      // longitud protegida
    mov x2, #PROT_READ      // nuevo permiso: solo lectura
    mov x8, #SYS_mprotect   // syscall mprotect
    svc #0                  // cambiar permisos
    cmp x0, #0              // revisar retorno
    b.lt cleanup            // lt = liberar region antes de reportar error

    // leer despues de mprotect
    ldrb w20, [x19]         // lectura valida con PROT_READ

    // munmap(base, PAGE_SIZE)
    mov x0, x19             // base original
    mov x1, #PAGE_SIZE      // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // liberar region
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = fallo al liberar

    // exit(byte_leido)
    mov x0, x20             // codigo de salida = 'R' = 82
    b salir                 // saltar a salida comun

cleanup:
    // liberar region viva antes de salir con error
    mov x0, x19             // base de region viva
    mov x1, #PAGE_SIZE      // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // cleanup

error:
    mov x0, #1              // codigo 1 = fallo de syscall

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso
