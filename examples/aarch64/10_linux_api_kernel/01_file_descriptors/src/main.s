// 10.1 - File descriptors y recursos
//
// Objetivo:
//   Abrir un archivo para obtener un fd, guardarlo y cerrarlo como recurso.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de la ruta.
//   x2 = flags de openat.
//   x3 = modo de creacion.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd guardado.

.equ AT_FDCWD, -100
.equ O_RDONLY, 0

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_RDONLY, 0)
    mov x0, #AT_FDCWD       // directorio actual como base
    adr x1, path            // ruta del archivo local del ejemplo
    mov x2, #O_RDONLY       // abrir solo lectura
    mov x3, #0              // modo no se usa sin O_CREAT
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    cmp x0, #0              // revisar retorno como signed
    b.lt error              // lt = menor signed: error si x0 < 0
    mov x19, x0             // guardar fd; no es puntero, es entero de recurso

    // close(fd)
    mov x0, x19             // close recibe el fd guardado
    mov x8, #57             // syscall close
    svc #0                  // liberar recurso

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

error:
    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "10_linux_api_kernel/01_file_descriptors/entrada.txt"
