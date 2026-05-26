// 09.3 - read y buffers
//
// Objetivo:
//   Leer bytes desde stdin hacia .bss y escribir exactamente lo leido.
//
// Registros usados:
//   x0 = fd para read/write, retorno de read y codigo para exit.
//   x1 = direccion del buffer.
//   x2 = maximo a leer y luego cantidad real a escribir.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // read(stdin, buffer, 64)
    mov x0, #0              // fd 0 = stdin
    adr x1, buffer          // direccion del buffer en .bss
    mov x2, #64             // maximo de bytes que el kernel puede escribir
    mov x8, #63             // syscall read
    svc #0                  // x0 = bytes leidos, 0 EOF, o error negativo

    // write(stdout, buffer, bytes_leidos)
    mov x2, x0              // usar la cantidad real leida, no el tamano total
    mov x0, #1              // fd 1 = stdout
    adr x1, buffer          // direccion del mismo buffer
    mov x8, #64             // syscall write
    svc #0                  // escribir exactamente los bytes recibidos

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .bss
buffer:
    .skip 64                // espacio que read puede llenar
