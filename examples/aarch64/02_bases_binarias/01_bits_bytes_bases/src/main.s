// 02.1 - Bits, bytes y bases
//
// Registros usados:
//   x0 = resultado final y codigo de salida.
//   x1 = valor escrito en binario.
//   x2 = valor escrito en hexadecimal.
//   x8 = numero de syscall.

.global _start

.section .text
_start:
    // sumar valores escritos en bases distintas
    mov x1, #0b1010     // mismo valor que 10 decimal
    mov x2, #0x5        // mismo valor que 5 decimal
    add x0, x1, x2      // 15 decimal, 0x0f hexadecimal

    // exit(x0)
    mov x8, #93         // exit(x0)
    svc #0              // el shell vera el byte bajo de x0
