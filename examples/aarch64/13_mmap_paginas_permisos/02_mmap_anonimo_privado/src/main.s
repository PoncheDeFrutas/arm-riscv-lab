// 13.2 - mmap anonimo privado
//
// Objetivo:
//   Crear una region anonima privada, escribir un byte y liberarla.
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
//   w20 = byte escrito en la region.

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
    // mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
    mov x0, #0              // addr = NULL
    mov x1, #PAGE_SIZE      // pedir una pagina
    mov x2, #(PROT_READ | PROT_WRITE) // permitir lectura y escritura
    mov x3, #(MAP_PRIVATE | MAP_ANONYMOUS) // privado y anonimo
    mov x4, #-1             // fd invalido requerido por mapeo anonimo
    mov x5, #0              // offset cero
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = base o error negativo
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = fallo de mmap
    mov x19, x0             // guardar base para usarla y liberarla

    // escribir dentro de la region
    mov w20, #65            // byte ASCII 'A'
    strb w20, [x19]         // region[0] = 'A'

    // munmap(base, PAGE_SIZE)
    mov x0, x19             // base original
    mov x1, #PAGE_SIZE      // longitud original
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // liberar region
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = fallo de munmap

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo de syscall

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso
