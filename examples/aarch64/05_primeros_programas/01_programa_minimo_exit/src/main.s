// 05.1 - Programa minimo con exit
//
// Objetivo:
//   Terminar un proceso Linux AArch64 con la syscall exit sin usar libc.
//
// Registros usados:
//   x0 = primer argumento de la syscall; para exit es el codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start
.type _start, %function

.text
_start:
    // exit(0)
    //
    // El kernel interpreta x0 como codigo de salida porque x8 selecciona
    // la syscall exit. Si x8 tuviera otro numero, x0 tendria otro papel.
    mov x0, #0      // codigo de salida que vera el shell con echo $?
    mov x8, #93     // syscall exit en Linux AArch64
    svc #0          // entrar al kernel

.size _start, . - _start
