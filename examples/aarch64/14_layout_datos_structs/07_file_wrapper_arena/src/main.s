// 14.7 - File wrapper y arena simple
//
// Objetivo:
//   Usar descriptores para un fd y una arena con cleanup explicito.
//
// Registros usados:
//   x0 = self, argumentos/retornos de syscalls y codigo de salida.
//   x1 = ruta, tamano de arena, buffer o puntero de write.
//   x2 = flags, longitud o valor temporal.
//   x3 = modo de openat o nuevo used de arena.
//   x4 = capacidad de arena.
//   x5 = base de arena.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd vivo cargado desde wrapper.
//   x20 = puntero asignado por arena.
//   x21 = cantidad real leida.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0
.equ FW_FD, 0
.equ FW_OPEN, 8
.equ FW_SIZE, 16
.equ ARENA_BASE, 0
.equ ARENA_USED, 8
.equ ARENA_CAP, 16
.equ ARENA_SIZE, 24
.equ READ_MAX, 64

.global _start

.section .bss
arena_storage:
    .skip 64

.section .data
.balign 8
file_wrapper:
    .quad -1
    .quad 0
arena_desc:
    .quad arena_storage
    .quad 0
    .quad 64

.section .text
_start:
    // abrir archivo por medio del wrapper
    adr x0, file_wrapper    // self = wrapper de archivo
    adr x1, path            // ruta del archivo
    bl file_open            // abrir y guardar fd/estado
    cmp x0, #0              // revisar retorno
    b.lt error_sin_fd       // lt = no hay fd que cerrar

    // pedir memoria a la arena
    adr x0, arena_desc      // self = arena
    mov x1, #READ_MAX       // tamano solicitado
    bl arena_alloc          // retorna puntero o 0
    cbz x0, cleanup_file    // cbz = no se pudo asignar bloque
    mov x20, x0             // guardar puntero del bloque asignado

    // read(fd, arena_block, READ_MAX)
    adr x0, file_wrapper    // direccion del wrapper
    ldr x19, [x0, #FW_FD]   // cargar fd vivo
    mov x0, x19             // fd para read
    mov x1, x20             // buffer asignado por arena
    mov x2, #READ_MAX       // maximo a leer
    mov x8, #63             // syscall read
    svc #0                  // x0 = bytes leidos o error
    cmp x0, #0              // revisar retorno signed
    b.lt cleanup_file       // lt = cerrar fd antes de salir
    mov x21, x0             // guardar cantidad real leida

    // write(stdout, arena_block, bytes_leidos)
    mov x0, #1              // fd 1 = stdout
    mov x1, x20             // buffer con contenido leido
    mov x2, x21             // cantidad real leida
    mov x8, #64             // syscall write
    svc #0                  // imprimir contenido
    cmp x0, #0              // revisar retorno
    b.lt cleanup_file       // lt = cerrar fd antes de salir

    // cerrar wrapper y resetear arena
    adr x0, file_wrapper    // self = wrapper
    bl file_close           // cerrar fd vivo
    adr x0, arena_desc      // self = arena
    bl arena_reset          // used = 0

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

cleanup_file:
    // cerrar archivo si ya estaba abierto
    adr x0, file_wrapper    // self = wrapper
    bl file_close           // cleanup de fd

error_sin_fd:
    mov x0, #1              // codigo 1 = fallo de recurso

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

file_open:
    // guardar self y llamar openat
    mov x9, x0              // x9 conserva direccion del wrapper
    mov x0, #AT_FDCWD       // directorio actual como base
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno
    b.lt file_open_error    // lt = no guardar fd invalido
    str x0, [x9, #FW_FD]    // wrapper.fd = fd
    mov x2, #1              // estado abierto
    str x2, [x9, #FW_OPEN]  // wrapper.open = 1
    mov x0, #0              // retorno 0 = exito
    ret                     // volver al caller

file_open_error:
    mov x0, #-1             // retorno negativo simplificado
    ret                     // volver al caller

file_close:
    // cerrar solo si el wrapper marca fd abierto
    ldr x2, [x0, #FW_OPEN]  // cargar estado open
    cbz x2, file_close_done // cbz = ya estaba cerrado
    mov x9, x0              // conservar self durante syscall
    ldr x0, [x9, #FW_FD]    // fd vivo
    mov x8, #57             // syscall close
    svc #0                  // cerrar fd
    str xzr, [x9, #FW_OPEN] // wrapper.open = 0
    mov x2, #-1             // fd invalido para estado cerrado
    str x2, [x9, #FW_FD]    // wrapper.fd = -1

file_close_done:
    mov x0, #0              // retorno 0 = cerrado o ya cerrado
    ret                     // volver al caller

arena_alloc:
    // validar capacidad disponible
    ldr x5, [x0, #ARENA_BASE] // base del storage
    ldr x2, [x0, #ARENA_USED] // bytes usados
    ldr x4, [x0, #ARENA_CAP] // capacidad total
    add x3, x2, x1          // nuevo used = used + size
    cmp x3, x4              // comparar nuevo used contra capacidad
    b.hi arena_fail         // hi = nuevo used > cap
    str x3, [x0, #ARENA_USED] // guardar nuevo used
    add x0, x5, x2          // retornar base + used anterior
    ret                     // volver al caller

arena_fail:
    mov x0, #0              // retorno NULL conceptual
    ret                     // volver al caller

arena_reset:
    // liberar todos los bloques de la arena de una vez
    str xzr, [x0, #ARENA_USED] // used = 0
    ret                     // volver al caller

.section .rodata
path:
    .asciz "14_layout_datos_structs/07_file_wrapper_arena/entrada.txt"
