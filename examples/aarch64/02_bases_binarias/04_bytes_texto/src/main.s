// 02.4 - Bytes y texto
//
// Objetivo:
//   Mostrar que un texto ASCII es una secuencia de bytes para write.
//
// Registros usados:
//   x0 = fd para write, codigo para exit.
//   x1 = direccion del primer byte del texto.
//   x2 = cantidad de bytes.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // write(stdout, texto, texto_len)
    mov x0, #1              // fd 1 = stdout
    adr x1, texto           // direccion del primer byte
    mov x2, texto_len       // cantidad de bytes, no incluye terminador NULL
    mov x8, #64             // syscall write
    svc #0                  // escribir bytes

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .data
texto:
    .ascii "ABC\n"          // bytes ASCII: 41 42 43 0a
texto_len = . - texto       // longitud calculada por el assembler
