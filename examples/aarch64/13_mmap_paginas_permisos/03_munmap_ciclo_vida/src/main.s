// 13.3 - munmap y ciclo de vida
//
// Objetivo:
//   Usar base y cursor por separado, y liberar con la base original.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = longitud de la region.
//   x2 = permisos de mmap.
//   x3 = flags de mmap.
//   x4 = fd para mmap anonimo.
//   x5 = offset para mmap.
//   x8 = numero de syscall Linux AArch64.
//   x19 = base de la region mapeada.
//   x20 = cursor de escritura dentro de la region.
//   x21 = contador de bytes escritos.
//   w22 = byte temporal.

.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_PRIVATE, 2
.equ MAP_ANONYMOUS, 32
.equ PAGE_SIZE, 4096
.equ SYS_mmap, 222
.equ SYS_munmap, 215
.equ SYS_exit, 93

.global _start

.section .text
_start:
    // mmap anonimo privado
    mov x0, #0              // addr = NULL
    mov x1, #PAGE_SIZE      // longitud de una pagina
    mov x2, #(PROT_READ | PROT_WRITE) // region RW
    mov x3, #(MAP_PRIVATE | MAP_ANONYMOUS) // privado y anonimo
    mov x4, #-1             // fd = -1
    mov x5, #0              // offset = 0
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = base o error
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = fallo de mmap
    mov x19, x0             // guardar base de la region
    mov x20, x19            // cursor inicia en la base
    mov x21, #0             // contador de bytes escritos

    // escribir usando cursor
    mov w22, #88            // byte ASCII 'X'
    strb w22, [x20], #1     // escribir y avanzar cursor 1 byte
    add x21, x21, #1        // contador = 1
    mov w22, #89            // byte ASCII 'Y'
    strb w22, [x20], #1     // escribir y avanzar cursor
    add x21, x21, #1        // contador = 2
    mov w22, #90            // byte ASCII 'Z'
    strb w22, [x20], #1     // escribir y avanzar cursor
    add x21, x21, #1        // contador = 3

    // munmap(base, PAGE_SIZE)
    mov x0, x19             // usar base original, no cursor
    mov x1, #PAGE_SIZE      // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // liberar region
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = fallo de munmap

    // exit(bytes_escritos)
    mov x0, x21             // codigo de salida = 3
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo de syscall

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso
