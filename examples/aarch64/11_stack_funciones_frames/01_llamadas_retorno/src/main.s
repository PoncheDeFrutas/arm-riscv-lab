// 11.1 - Llamadas y retorno
//
// Objetivo:
//   Llamar a una funcion hoja con bl y regresar con ret.
//
// Registros usados:
//   x0 = argumento de la funcion, retorno de la funcion y codigo de salida.
//   x8 = numero de syscall Linux AArch64.
//   x30 = link register; bl guarda aqui la direccion de retorno.

.global _start

.section .text
_start:
    // preparar argumento y llamar a la funcion
    mov x0, #21             // x0 lleva el argumento: 21
    bl duplicar             // bl salta a duplicar y guarda retorno en x30

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el valor devuelto: 42

duplicar:
    // calcular retorno de una funcion hoja
    add x0, x0, x0          // x0 = x0 * 2; 21 se convierte en 42
    ret                     // volver al caller usando x30
