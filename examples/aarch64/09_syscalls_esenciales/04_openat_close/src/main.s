// 09.4 - openat y close
//
// Objetivo:
//   Crear un archivo con openat, escribir bytes y cerrar el fd guardado.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = direccion de ruta o mensaje.
//   x2 = flags de openat o longitud para write.
//   x3 = modo de creacion del archivo.
//   x8 = numero de syscall Linux AArch64.
//   x19 = fd guardado para write y close.

.equ AT_FDCWD, -100
.equ O_WRONLY, 1
.equ O_CREAT, 64
.equ O_TRUNC, 512
.equ MODE_0644, 420

.global _start

.section .text
_start:
    // openat(AT_FDCWD, path, O_WRONLY|O_CREAT|O_TRUNC, 0644)
    mov x0, #AT_FDCWD       // usar el directorio actual como base
    adr x1, path            // ruta relativa del archivo a crear
    mov x2, #(O_WRONLY | O_CREAT | O_TRUNC) // abrir para escritura y truncar
    mov x3, #MODE_0644      // permisos iniciales si el archivo se crea
    mov x8, #56             // syscall openat
    svc #0                  // x0 = fd o error negativo
    mov x19, x0             // guardar fd antes de que write sobrescriba x0

    // write(fd, msg, msg_len)
    mov x0, x19             // fd devuelto por openat
    adr x1, msg             // bytes a escribir en el archivo
    mov x2, msg_len         // cantidad exacta de bytes
    mov x8, #64             // syscall write
    svc #0                  // x0 = bytes escritos o error negativo

    // close(fd)
    mov x0, x19             // close recibe el fd, no una direccion
    mov x8, #57             // syscall close
    svc #0                  // cerrar recurso

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .rodata
path:
    .asciz "09_syscalls_esenciales/04_openat_close/salida.txt"

msg:
    .ascii "Archivo creado desde openat\n"
msg_len = . - msg
