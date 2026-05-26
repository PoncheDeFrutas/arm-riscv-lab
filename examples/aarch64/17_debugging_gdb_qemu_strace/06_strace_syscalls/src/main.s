// 17.6 - strace y syscalls
//
// Objetivo:
//   Ejecutar openat, read, write, close y un error esperado para strace.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de ruta o buffer.
//   x2 = flags o longitud.
//   x3 = modo de openat.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd abierto.
//   x20 = cantidad real leida.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0

.global _start

.section .bss
buffer:
    .skip 32

.section .text
_start:
    // openat(AT_FDCWD, path_ok, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path_ok         // archivo existente
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno signed
    b.lt error              // lt = fallo inesperado
    mov x19, x0             // guardar fd vivo

    // read(fd, buffer, 32)
    mov x0, x19             // fd abierto
    adr x1, buffer          // buffer destino
    mov x2, #32             // maximo a leer
    mov x8, #63             // syscall read
    svc #0                  // x0 = bytes leidos o error
    cmp x0, #0              // revisar retorno
    b.lt cleanup_error      // lt = cerrar fd antes de salir
    mov x20, x0             // guardar cantidad real leida

    // write(stdout, buffer, bytes_leidos)
    mov x0, #1              // fd 1 = stdout
    adr x1, buffer          // buffer con datos leidos
    mov x2, x20             // longitud real
    mov x8, #64             // syscall write
    svc #0                  // imprimir contenido
    cmp x0, #0              // revisar retorno
    b.lt cleanup_error      // lt = cerrar fd antes de salir

    // close(fd)
    mov x0, x19             // fd vivo
    mov x8, #57             // syscall close
    svc #0                  // cerrar archivo
    cmp x0, #0              // revisar retorno
    b.lt error              // lt = fallo al cerrar

    // openat sobre archivo inexistente para error esperado
    mov x0, #AT_FDCWD       // directorio actual
    adr x1, path_missing    // archivo que no existe
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no usado
    mov x8, #56             // syscall openat
    svc #0                  // debe retornar negativo
    cmp x0, #0              // revisar retorno
    b.lt error_esperado     // lt = error esperado
    mov x0, #2              // codigo 2 = no fallo como se esperaba
    b salir                 // saltar a salida

cleanup_error:
    // cerrar fd antes de reportar error inesperado
    mov x0, x19             // fd abierto
    mov x8, #57             // syscall close
    svc #0                  // cleanup de fd

error:
    mov x0, #1              // codigo 1 = fallo inesperado
    b salir                 // saltar a salida

error_esperado:
    mov x0, #0              // codigo exitoso: el error era esperado

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path_ok:
    .asciz "17_debugging_gdb_qemu_strace/06_strace_syscalls/entrada.txt"
path_missing:
    .asciz "17_debugging_gdb_qemu_strace/06_strace_syscalls/no_existe.txt"
