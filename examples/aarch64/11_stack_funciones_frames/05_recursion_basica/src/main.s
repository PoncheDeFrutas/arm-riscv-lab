// 11.5 - Recursion basica
//
// Objetivo:
//   Calcular suma(n) con recursion pequena y un frame por llamada.
//
// Registros usados:
//   x0 = argumento n, retorno de suma y codigo de salida.
//   x1 = n original recuperado desde el frame actual.
//   x8 = numero de syscall Linux AArch64.
//   x29 = frame pointer de cada llamada recursiva.
//   x30 = link register guardado por cada frame.

.global _start

.section .text
_start:
    // calcular suma(4)
    mov x0, #4              // argumento inicial n = 4
    bl suma                 // retorno esperado: 10

    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con 10

suma:
    // prologo de cada llamada recursiva
    stp x29, x30, [sp, #-16]! // guardar frame anterior y retorno propio
    mov x29, sp             // fijar frame pointer de esta llamada
    sub sp, sp, #16         // reservar espacio para n local
    str x0, [sp]            // guardar n antes de modificar x0

    // revisar caso base
    cbz x0, caso_base       // cbz = saltar si n == 0

    // llamada recursiva suma(n - 1)
    sub x0, x0, #1          // preparar n - 1
    bl suma                 // calcular suma(n - 1)
    ldr x1, [sp]            // recuperar n de esta llamada
    add x0, x0, x1          // retorno = suma(n - 1) + n
    b fin_suma              // saltar al epilogo comun

caso_base:
    mov x0, #0              // suma(0) retorna 0

fin_suma:
    // epilogo de cada llamada recursiva
    add sp, sp, #16         // liberar n local
    ldp x29, x30, [sp], #16 // restaurar frame anterior y retorno
    ret                     // volver al caller de esta llamada
