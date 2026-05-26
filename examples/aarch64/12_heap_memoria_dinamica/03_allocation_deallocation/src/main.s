// 12.3 - Allocation y deallocation
//
// Objetivo:
//   Simular reserva, uso y liberacion de un bloque con cleanup de metadata.
//
// Registros usados:
//   x0 = puntero retornado, codigo de estado y codigo de salida.
//   x1 = direccion de block_state.
//   x2 = estado cargado o nuevo valor de estado.
//   x3 = direccion de block_ptr.
//   x4 = direccion de block_capacity.
//   x5 = capacidad simulada del bloque.
//   x8 = numero de syscall Linux AArch64.
//   x19 = copia del puntero mientras el bloque esta reservado.

.global _start

.section .data
.balign 8
block_ptr:
    .quad 0
block_state:
    .quad 0
block_capacity:
    .quad 0

.section .bss
heap_block:
    .skip 16

.section .text
_start:
    // reservar bloque simulado
    bl reservar_bloque      // retorna puntero valido o 0
    cbz x0, error_reserva   // cbz = error si el puntero retornado es 0
    mov x19, x0             // conservar puntero mientras se usa el bloque

    // usar el bloque reservado
    mov w1, #77             // byte ASCII 'M'
    strb w1, [x19]          // escribir dentro del bloque reservado

    // liberar bloque simulado
    bl liberar_bloque       // retorna 0 si libero correctamente
    cmp x0, #0              // comparar retorno contra exito
    b.ne error_liberar      // ne = saltar si liberar retorno otro codigo

    // salida exitosa
    mov x0, #0              // codigo de salida exitoso
    b salir                 // saltar a salida comun

error_reserva:
    mov x0, #1              // codigo 1 = fallo de reserva
    b salir                 // saltar a salida comun

error_liberar:
    mov x0, #2              // codigo 2 = fallo al liberar

salir:
    // exit(x0)
    mov x8, #93             // syscall exit
    svc #0                  // terminar con el codigo calculado

reservar_bloque:
    // revisar si el bloque ya esta ocupado
    adr x1, block_state     // direccion de la bandera ocupado/libre
    ldr x2, [x1]            // cargar estado actual
    cbnz x2, reserva_falla  // cbnz = si state != 0, ya estaba reservado

    // marcar bloque como reservado
    mov x2, #1              // 1 significa reservado
    str x2, [x1]            // block_state = 1
    adr x0, heap_block      // retornar puntero al bloque simulado
    adr x3, block_ptr       // direccion donde se guarda el puntero activo
    str x0, [x3]            // block_ptr = heap_block
    adr x4, block_capacity  // direccion de capacidad
    mov x5, #16             // capacidad simulada del bloque
    str x5, [x4]            // block_capacity = 16
    ret                     // retornar puntero valido en x0

reserva_falla:
    mov x0, #0              // puntero cero representa fallo conceptual
    ret                     // volver al caller

liberar_bloque:
    // revisar ownership antes de liberar
    adr x1, block_state     // direccion de la bandera ocupado/libre
    ldr x2, [x1]            // cargar estado actual
    cbz x2, liberar_falla   // cbz = no hay bloque reservado que liberar

    // limpiar metadata del bloque
    str xzr, [x1]           // block_state = 0
    adr x3, block_ptr       // direccion del puntero guardado
    str xzr, [x3]           // block_ptr = 0 para evitar puntero obsoleto
    adr x4, block_capacity  // direccion de capacidad
    str xzr, [x4]           // block_capacity = 0
    mov x0, #0              // retorno 0 = liberacion exitosa
    ret                     // volver al caller

liberar_falla:
    mov x0, #1              // retorno 1 = liberar sin ownership
    ret                     // volver al caller
