// 17.8 - Practica guiada de depuracion
//
// Objetivo:
//   Integrar lectura de memoria, frames y syscalls en un programa pequeno.
//
// Registros usados:
//   x0 = retorno de funciones, fd para write y codigo de salida.
//   x1 = direccion del buffer para write.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall Linux AArch64.
//   x29 = frame pointer de funciones no hoja.
//   x30 = link register guardado por frames.

.equ MSG_LEN, 13

.global _start

.section .bss
buffer:
    .skip 16

.section .text
_start:
    // preparar memoria observable
    bl preparar_mensaje     // escribir mensaje en .bss
    bl escribir_stdout      // imprimir mensaje preparado
    cmp x0, #0              // revisar retorno normalizado
    b.lt error              // lt = write fallo

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo de write

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

preparar_mensaje:
    // frame de preparacion
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // fijar frame pointer

    // escribir "debug guiado\n" en buffer
    adr x0, buffer          // direccion base del buffer .bss
    mov w1, #100            // 'd'
    strb w1, [x0]           // buffer[0] = 'd'
    mov w1, #101            // 'e'
    strb w1, [x0, #1]       // buffer[1] = 'e'
    mov w1, #98             // 'b'
    strb w1, [x0, #2]       // buffer[2] = 'b'
    mov w1, #117            // 'u'
    strb w1, [x0, #3]       // buffer[3] = 'u'
    mov w1, #103            // 'g'
    strb w1, [x0, #4]       // buffer[4] = 'g'
    mov w1, #32             // espacio
    strb w1, [x0, #5]       // buffer[5] = ' '
    mov w1, #103            // 'g'
    strb w1, [x0, #6]       // buffer[6] = 'g'
    mov w1, #117            // 'u'
    strb w1, [x0, #7]       // buffer[7] = 'u'
    mov w1, #105            // 'i'
    strb w1, [x0, #8]       // buffer[8] = 'i'
    mov w1, #97             // 'a'
    strb w1, [x0, #9]       // buffer[9] = 'a'
    mov w1, #100            // 'd'
    strb w1, [x0, #10]      // buffer[10] = 'd'
    mov w1, #111            // 'o'
    strb w1, [x0, #11]      // buffer[11] = 'o'
    mov w1, #10             // salto de linea
    strb w1, [x0, #12]      // buffer[12] = '\n'

    // salir de preparar_mensaje
    ldp x29, x30, [sp], #16 // restaurar frame y retorno
    ret                     // volver a _start

escribir_stdout:
    // frame de escritura
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno
    mov x29, sp             // fijar frame pointer

    // write(stdout, buffer, MSG_LEN)
    mov x0, #1              // fd 1 = stdout
    adr x1, buffer          // direccion del mensaje en .bss
    mov x2, #MSG_LEN        // longitud exacta del mensaje
    mov x8, #64             // syscall write
    svc #0                  // x0 = bytes escritos o error negativo
    cmp x0, #0              // revisar retorno signed
    b.lt escribir_error     // lt = write fallo
    mov x0, #0              // normalizar exito
    b escribir_fin          // saltar al epilogo

escribir_error:
    mov x0, #-1             // retorno negativo simplificado

escribir_fin:
    ldp x29, x30, [sp], #16 // restaurar frame y retorno
    ret                     // volver a _start
