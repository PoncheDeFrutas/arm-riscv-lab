// 14.2 - Acceso a campos con punteros
//
// Objetivo:
//   Acceder campos con base + offset y pasar un puntero a una funcion.
//
// Registros usados:
//   x0 = puntero recibido por sumar_point, retorno y codigo de salida.
//   x1 = direccion base del array de Point.
//   x2 = valor temporal o campo x.
//   x3 = valor temporal o campo y.
//   x8 = numero de syscall Linux AArch64.

.equ POINT_X, 0
.equ POINT_Y, 8
.equ POINT_SIZE, 16

.global _start

.section .bss
.balign 8
points:
    .skip POINT_SIZE * 2

.section .text
_start:
    // calcular direccion del segundo Point
    adr x1, points          // base del array de structs
    add x0, x1, #POINT_SIZE // x0 apunta a points[1]

    // escribir campos del segundo Point
    mov x2, #10             // valor para points[1].x
    str x2, [x0, #POINT_X]  // points[1].x = 10
    mov x3, #17             // valor para points[1].y
    str x3, [x0, #POINT_Y]  // points[1].y = 17

    // llamar funcion que recibe puntero al objeto
    bl sumar_point          // retorna x + y en x0

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 27

sumar_point:
    // leer campos usando el puntero recibido en x0
    ldr x2, [x0, #POINT_X]  // cargar campo x del Point recibido
    ldr x3, [x0, #POINT_Y]  // cargar campo y del Point recibido
    add x0, x2, x3          // retorno = x + y
    ret                     // volver a _start
