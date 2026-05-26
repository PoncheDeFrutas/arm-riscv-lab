// 14.4 - Objetos manuales
//
// Objetivo:
//   Usar self en x0 para constructor, metodo y destructor de un objeto manual.
//
// Registros usados:
//   x0 = self, retorno de metodo y codigo de salida.
//   x1 = argumento inicial o delta.
//   x2 = temporal para campos del objeto.
//   x8 = numero de syscall Linux AArch64.
//   x19 = resultado guardado antes del destructor.

.equ COUNTER_VALUE, 0
.equ COUNTER_ALIVE, 8
.equ COUNTER_SIZE, 16

.global _start

.section .bss
.balign 8
counter:
    .skip COUNTER_SIZE

.section .text
_start:
    // construir objeto Counter
    adr x0, counter         // self = &counter
    mov x1, #30             // valor inicial
    bl counter_init         // constructor manual

    // ejecutar metodo sobre el objeto
    adr x0, counter         // self = &counter
    mov x1, #12             // delta a sumar
    bl counter_add          // retorna value + delta
    mov x19, x0             // guardar resultado antes de destruir

    // destruir objeto manual
    adr x0, counter         // self = &counter
    bl counter_destroy      // limpiar estado del objeto

    // exit(resultado)
    mov x0, x19             // codigo de salida = 42
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

counter_init:
    // inicializar campos del objeto
    str x1, [x0, #COUNTER_VALUE] // value = argumento inicial
    mov x2, #1              // alive = 1
    str x2, [x0, #COUNTER_ALIVE] // marcar objeto vivo
    ret                     // volver al caller

counter_add:
    // sumar delta al campo value
    ldr x2, [x0, #COUNTER_VALUE] // cargar value actual
    add x2, x2, x1          // value = value + delta
    str x2, [x0, #COUNTER_VALUE] // guardar nuevo value
    mov x0, x2              // retornar value actualizado
    ret                     // volver al caller

counter_destroy:
    // limpiar estado del objeto
    str xzr, [x0, #COUNTER_VALUE] // value = 0
    str xzr, [x0, #COUNTER_ALIVE] // alive = 0
    ret                     // volver al caller
