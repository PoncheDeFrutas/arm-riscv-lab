// 12.4 - Buffer dinamico
//
// Objetivo:
//   Simular un buffer con capacidad, bytes usados y validacion antes de escribir.
//
// Registros usados:
//   x0 = byte de entrada para push_byte, retorno de estado y fd para write.
//   x1 = direccion de buffer_used o direccion del buffer para write.
//   x2 = bytes usados o longitud para write.
//   x3 = direccion de buffer_capacity.
//   x4 = capacidad del buffer.
//   x5 = direccion base del buffer.
//   x8 = numero de syscall Linux AArch64.

.global _start

.section .data
.balign 8
buffer_capacity:
    .quad 16
buffer_used:
    .quad 0

.section .bss
buffer:
    .skip 16

.section .text
_start:
    // agregar caracteres al buffer simulado
    mov x0, #65             // byte ASCII 'A'
    bl push_byte            // intentar escribir 'A'
    cbnz x0, error_buffer   // cbnz = error si retorno != 0
    mov x0, #66             // byte ASCII 'B'
    bl push_byte            // intentar escribir 'B'
    cbnz x0, error_buffer   // revisar retorno
    mov x0, #67             // byte ASCII 'C'
    bl push_byte            // intentar escribir 'C'
    cbnz x0, error_buffer   // revisar retorno
    mov x0, #10             // byte de salto de linea
    bl push_byte            // intentar escribir '\n'
    cbnz x0, error_buffer   // revisar retorno

    // write(stdout, buffer, buffer_used)
    mov x0, #1              // fd 1 = stdout
    adr x1, buffer          // direccion inicial del buffer
    adr x2, buffer_used     // direccion del contador usado
    ldr x2, [x2]            // cantidad real de bytes validos
    mov x8, #64             // syscall write
    svc #0                  // imprimir ABC\n

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    b salir                 // saltar a salida comun

error_buffer:
    mov x0, #1              // codigo 1 = no habia espacio

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el codigo calculado

push_byte:
    // cargar metadata del buffer
    adr x1, buffer_used     // direccion del contador de bytes usados
    ldr x2, [x1]            // x2 = bytes usados actualmente
    adr x3, buffer_capacity // direccion de la capacidad
    ldr x4, [x3]            // x4 = capacidad total
    cmp x2, x4              // comparar used contra capacity como unsigned
    b.cs buffer_lleno       // cs = used >= capacity, no hay espacio

    // escribir byte y actualizar contador
    adr x5, buffer          // direccion base del buffer
    strb w0, [x5, x2]       // buffer[used] = byte recibido en w0
    add x2, x2, #1          // used = used + 1
    str x2, [x1]            // guardar nuevo contador
    mov x0, #0              // retorno 0 = exito
    ret                     // volver al caller

buffer_lleno:
    mov x0, #1              // retorno 1 = sin espacio disponible
    ret                     // volver al caller
