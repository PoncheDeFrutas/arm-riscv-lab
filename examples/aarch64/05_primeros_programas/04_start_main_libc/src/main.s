// 05.4 - _start, main y libc
//
// Objetivo:
//   Mostrar que sin runtime de C el proceso entra por _start, no por main.
//
// Registros usados:
//   x0 = retorno manual de main y codigo de salida.
//   x8 = numero de syscall.
//   x30 = link register usado por bl/ret.

.global _start

.section .text
_start:
    // llamar una etiqueta llamada main manualmente
    bl main                 // no hay runtime: llamamos main a mano

    // exit(x0)
    mov x8, #93             // exit usa el valor que main dejo en x0
    svc #0                  // terminar proceso

main:
    // funcion propia minima
    mov x0, #5              // valor de retorno manual
    ret                     // volver a la direccion guardada en x30
