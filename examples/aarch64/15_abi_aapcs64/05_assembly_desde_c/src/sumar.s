// 15.5 - Funcion assembly llamada desde C
//
// Objetivo:
//   Exportar sumar para que C la llame siguiendo AAPCS64.
//
// Registros usados:
//   x0 = primer argumento y retorno.
//   x1 = segundo argumento.
//   x30 = link register usado por ret.

.global sumar
.type sumar, %function

.section .text
sumar:
    // calcular retorno para C
    add x0, x0, x1          // x0 = a + b
    ret                     // volver al caller C

.size sumar, . - sumar
