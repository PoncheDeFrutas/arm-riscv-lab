// 14.1 - Structs y layout manual
//
// Objetivo:
//   Definir un Point con offsets manuales y sumar sus campos.
//
// Registros usados:
//   x0 = codigo de salida.
//   x1 = direccion base del objeto Point.
//   x2 = valor temporal para campo x.
//   x3 = valor temporal para campo y.
//   x8 = numero de syscall Linux AArch64.

.equ POINT_X, 0
.equ POINT_Y, 8
.equ POINT_SIZE, 16

.global _start

.section .bss
.balign 8
point:
    .skip POINT_SIZE

.section .text
_start:
    // escribir campos del struct manual
    adr x1, point           // x1 = direccion base del Point
    mov x2, #19             // valor para campo x
    str x2, [x1, #POINT_X]  // point.x = 19
    mov x3, #23             // valor para campo y
    str x3, [x1, #POINT_Y]  // point.y = 23

    // leer campos por offset y calcular resultado
    ldr x2, [x1, #POINT_X]  // cargar point.x
    ldr x3, [x1, #POINT_Y]  // cargar point.y
    add x0, x2, x3          // resultado = 19 + 23 = 42

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 42
