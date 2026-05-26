// 12.6 - De brk a malloc y mmap
//
// Objetivo:
//   Diferenciar instruccion, syscall y funcion de biblioteca sin usar mmap real.
//
// Registros usados:
//   x0 = fd para write y codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall Linux AArch64.
//   x9 = numero de syscall brk en Linux AArch64.
//   x10 = numero de syscall mmap en Linux AArch64.
//   x11 = numero de syscall munmap en Linux AArch64.

.equ SYS_write, 64
.equ SYS_exit, 93
.equ SYS_brk, 214
.equ SYS_mmap, 222
.equ SYS_munmap, 215

.global _start

.section .data
msg:
    .ascii "brk/malloc/mmap: capas distintas\n"
msg_len = . - msg

.section .text
_start:
    // cargar numeros relacionados para observarlos en GDB
    mov x9, #SYS_brk        // brk es syscall historica del kernel
    mov x10, #SYS_mmap      // mmap es syscall del kernel
    mov x11, #SYS_munmap    // munmap libera regiones mapeadas por syscall

    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion del mensaje
    mov x2, msg_len         // cantidad de bytes del mensaje
    mov x8, #SYS_write      // syscall write
    svc #0                  // entrar al kernel para escribir

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #SYS_exit       // syscall exit
    svc #0                  // terminar el proceso
