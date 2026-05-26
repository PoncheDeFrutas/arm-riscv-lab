// 13.1 - Paginas y memoria virtual
//
// Objetivo:
//   Pedir una pagina con mmap, verificar alineacion y liberarla con munmap.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = longitud de la region.
//   x2 = permisos o mascara de alineacion.
//   x3 = flags de mmap.
//   x4 = fd para mmap anonimo.
//   x5 = offset para mmap.
//   x8 = numero de syscall Linux AArch64.
//   x19 = base de la region mapeada.
//   x20 = bits bajos de la direccion base.

.equ PROT_READ, 1
.equ PROT_WRITE, 2
.equ MAP_PRIVATE, 2
.equ MAP_ANONYMOUS, 32
.equ PAGE_SIZE, 4096
.equ PAGE_MASK, 0xfff
.equ SYS_mmap, 222
.equ SYS_munmap, 215
.equ SYS_exit, 93

.global _start

.section .text
_start:
    // mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
    mov x0, #0              // addr = NULL; el kernel elige la base
    mov x1, #PAGE_SIZE      // longitud de una pagina comun
    mov x2, #(PROT_READ | PROT_WRITE) // region legible y escribible
    mov x3, #(MAP_PRIVATE | MAP_ANONYMOUS) // region privada sin archivo
    mov x4, #-1             // fd = -1 para mapeo anonimo
    mov x5, #0              // offset = 0
    mov x8, #SYS_mmap       // syscall mmap
    svc #0                  // x0 = base mapeada o error negativo
    cmp x0, #0              // revisar retorno como signed
    b.lt error_sin_region   // lt = no hay region que liberar
    mov x19, x0             // guardar base original para munmap

    // verificar alineacion de pagina
    and x20, x19, #PAGE_MASK // extraer los 12 bits bajos de la base
    cmp x20, #0             // una base alineada tiene bits bajos cero
    b.ne error_alineacion   // ne = la base no cumple la alineacion esperada

    // munmap(base, PAGE_SIZE)
    mov x0, x19             // base original de la region
    mov x1, #PAGE_SIZE      // longitud usada en mmap
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // liberar region
    cmp x0, #0              // revisar retorno de munmap
    b.lt error_sin_region   // lt = fallo al liberar

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    b salir                 // saltar a salida comun

error_alineacion:
    // liberar antes de reportar error de alineacion
    mov x0, x19             // base que si fue mapeada
    mov x1, #PAGE_SIZE      // longitud de la region viva
    mov x8, #SYS_munmap     // syscall munmap
    svc #0                  // cleanup antes de salir
    mov x0, #2              // codigo 2 = alineacion inesperada
    b salir                 // saltar a salida comun

error_sin_region:
    mov x0, #1              // codigo 1 = syscall fallo

salir:
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar proceso
