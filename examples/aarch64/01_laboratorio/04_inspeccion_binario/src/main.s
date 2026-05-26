// 01.4 - Binario para inspeccion
//
// Objetivo:
//   Generar un ELF pequeno para observarlo con file, readelf, objdump y nm.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del mensaje.
//   x2 = cantidad de bytes del mensaje.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // write(stdout, msg, msg_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, msg             // direccion inicial del mensaje en .rodata
    mov x2, msg_len         // cantidad de bytes a escribir
    mov x8, #64             // syscall write
    svc #0                  // entrar al kernel

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar el proceso

.section .rodata
msg:
    .ascii "Inspeccion\n"   // bytes visibles para comprobar ejecucion
msg_len = . - msg           // longitud calculada por el assembler
