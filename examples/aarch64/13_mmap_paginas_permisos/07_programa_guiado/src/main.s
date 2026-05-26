// 13.7 - Programa guiado con mmap, mprotect y munmap
//
// Objetivo:
//   Mapear una pagina, escribir datos, volverla solo lectura, imprimir y liberar.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = longitud, direccion o argumento de syscall.
//   x2 = permisos, longitud de write o byte temporal extendido.
//   x3 = flags de mmap.
//   x4 = fd para mmap anonimo.
//   x5 = offset para mmap.
//   x8 = numero de syscall Linux AArch64.
//   x19 = base de la region mapeada.
//   w20 = byte temporal escrito en la region.

.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_PRIVATE, 2
.equ MAP_ANONYMOUS, 32
.equ PAGE_SIZE, 4096
.equ MSG_LEN, 3
.equ SYS_write, 64
.equ SYS_mmap, 222
.equ SYS_munmap, 215
.equ SYS_mprotect, 226
.equ SYS_exit, 93

.global _start

.section .text
_start:
    // mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
    mov x0, #0              // addr = NULL
    mov x1, #PAGE_SIZE      // longitud de una pagina
    mov x2, #(PROT_READ | PROT_WRITE) // permisos iniciales RW
    mov x3, #(MAP_PRIVATE | MAP_ANONYMOUS) // privado y anonimo
    mov x4, #-1             // fd = -1
    mov x5, #0              // offset = 0
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = base o error
    cmp x0, #0              // revisar retorno
    b.lt error_sin_region   // lt = no hay region que liberar
    mov x19, x0             // guardar base de la region

    // escribir "OK\n" mientras la region es RW
    mov w20, #79            // byte ASCII 'O'
    strb w20, [x19]         // region[0] = 'O'
    mov w20, #75            // byte ASCII 'K'
    strb w20, [x19, #1]     // region[1] = 'K'
    mov w20, #10            // byte salto de linea
    strb w20, [x19, #2]     // region[2] = '\n'

    // mprotect(base, PAGE_SIZE, PROT_READ)
    mov x0, x19             // base de region viva
    mov x1, #PAGE_SIZE      // longitud de la region
    mov x2, #PROT_READ      // dejar solo lectura
    mov x8, #SYS_mprotect   // syscall mprotect
    svc #0                  // cambiar permisos
    cmp x0, #0              // revisar retorno
    b.lt cleanup            // lt = liberar antes de reportar error

    // write(stdout, region, MSG_LEN)
    mov x0, #1              // fd 1 = stdout
    mov x1, x19             // region ahora se usa solo para lectura
    mov x2, #MSG_LEN        // longitud del mensaje
    mov x8, #SYS_write      // syscall write
    svc #0                  // imprimir OK\n
    cmp x0, #0              // revisar retorno
    b.lt cleanup            // lt = liberar antes de reportar error

    // munmap(base, PAGE_SIZE)
    mov x0, x19             // base original
    mov x1, #PAGE_SIZE      // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // liberar region
    cmp x0, #0              // revisar retorno
    b.lt error_sin_region   // lt = region ya no se considera viva

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

cleanup:
    // liberar region viva despues de un error
    mov x0, x19             // base de region viva
    mov x1, #PAGE_SIZE      // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // cleanup

error_sin_region:
    mov x0, #1              // codigo 1 = fallo de syscall

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso
