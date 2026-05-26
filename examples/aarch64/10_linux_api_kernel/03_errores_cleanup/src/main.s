// 10.3 - Errores y cleanup
//
// Objetivo:
//   Separar error antes de tener fd y cleanup despues de abrir un recurso.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de ruta o buffer invalido.
//   x2 = flags o maximo a leer.
//   x3 = modo de creacion.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd guardado para cleanup.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path            // archivo valido del ejemplo
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar si openat fallo
    b.lt error_sin_fd       // lt = menor signed: no hay fd que cerrar
    mov x19, x0             // guardar fd vivo

    // read(fd, NULL, 16) para provocar EFAULT y practicar cleanup
    mov x0, x19             // fd abierto correctamente
    mov x1, #0              // buffer invalido: direccion NULL
    mov x2, #16             // cantidad solicitada
    mov x8, #63             // syscall read
    svc #0                  // x0 = error negativo esperado
    cmp x0, #0              // revisar retorno como signed
    b.lt cleanup            // lt = menor signed: cerrar fd antes de salir

    // exit(0) no deberia alcanzarse en este ejemplo
    mov x0, #0              // codigo exitoso si read no fallara
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

cleanup:
    // close(fd) porque openat ya habia funcionado
    mov x0, x19             // fd guardado que sigue vivo
    mov x8, #57             // syscall close
    svc #0                  // liberar recurso antes de reportar error

error_sin_fd:
    // write(stderr, msg_error, msg_error_len)
    mov x0, #2              // fd 2 = stderr
    adr x1, msg_error       // mensaje comun de error
    mov x2, msg_error_len   // cantidad exacta de bytes
    mov x8, #64             // syscall write
    svc #0                  // escribir diagnostico minimo

    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "10_linux_api_kernel/03_errores_cleanup/entrada.txt"

msg_error:
    .ascii "Error con cleanup\n"
msg_error_len = . - msg_error
