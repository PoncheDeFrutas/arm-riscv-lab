// 15.7 - Funcion para libreria estatica
//
// Objetivo:
//   Exportar suma_lib para empaquetarla en liboperaciones.a.
//
// Registros usados:
//   x0 = primer argumento y retorno.
//   x1 = segundo argumento.
//   x30 = link register usado por ret.

.global suma_lib
.type suma_lib, %function

.section .text
suma_lib:
    // calcular suma para el programa C
    add x0, x0, x1          // x0 = a + b
    ret                     // volver al caller C

.size suma_lib, . - suma_lib
