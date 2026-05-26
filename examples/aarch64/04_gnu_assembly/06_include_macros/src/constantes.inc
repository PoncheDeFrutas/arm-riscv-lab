// Constantes compartidas por main.s.
// El punto de la leccion es evitar numeros magicos en cada instruccion.
.equ SYS_write, 64      // numero de syscall write en Linux AArch64
.equ SYS_exit, 93       // numero de syscall exit en Linux AArch64
.equ STDOUT, 1          // descriptor de archivo para stdout

.macro exit_ok
    // exit(0)
    mov x0, #0          // codigo de salida exitoso
    mov x8, #SYS_exit   // syscall exit usando la constante compartida
    svc #0              // entrar al kernel
.endm
