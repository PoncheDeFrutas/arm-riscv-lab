// 08.3 - if/else en assembly
//
// Objetivo:
//   Construir un if/else usando cmp, b.cond, etiquetas y salto a fin_if.
//
// Registros usados:
//   x1 = valor evaluado.
//   x0 = resultado de la decision y codigo de salida.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .text
_start:
    // if (x1 < 10) x0 = 0; else x0 = 1
    mov x1, #7              // valor de prueba
    cmp x1, #10             // preparar flags para comparar con 10
    b.lt menor              // lt = menor signed: saltar si N != V

mayor_o_igual:
    mov x0, #1              // resultado para x1 >= 10
    b fin_if                // evitar caer al bloque menor

menor:
    mov x0, #0              // resultado para x1 < 10

fin_if:
    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el resultado del if/else
