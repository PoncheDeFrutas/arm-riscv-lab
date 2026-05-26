// 14.5 - Descriptores
//
// Objetivo:
//   Usar un descriptor propio para empaquetar fd, puntero, longitud y estado.
//
// Registros usados:
//   x0 = self del descriptor, fd para write, retorno y codigo de salida.
//   x1 = direccion del mensaje para write.
//   x2 = longitud del mensaje para write.
//   x3 = estado cargado desde el descriptor.
//   x8 = numero de syscall Linux AArch64.

.equ DESC_FD, 0
.equ DESC_PTR, 8
.equ DESC_LEN, 16
.equ DESC_STATE, 24
.equ DESC_SIZE, 32

.global _start

.section .rodata
msg:
    .ascii "descriptor propio\n"
msg_len = . - msg

.section .data
.balign 8
stdout_desc:
    .quad 1
    .quad msg
    .quad msg_len
    .quad 1

.section .text
_start:
    // escribir usando descriptor propio
    adr x0, stdout_desc     // self = descriptor de salida
    bl write_descriptor     // escribir segun metadata del descriptor
    cmp x0, #0              // revisar retorno normalizado
    b.lt error              // lt = fallo de write

    // exit(0)
    mov x0, #0              // codigo exitoso
    b salir                 // saltar a salida comun

error:
    mov x0, #1              // codigo 1 = fallo de descriptor/write

salir:
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

write_descriptor:
    // cargar campos del descriptor
    ldr x3, [x0, #DESC_STATE] // cargar estado del descriptor
    ldr x2, [x0, #DESC_LEN] // cargar longitud antes de perder self
    ldr x1, [x0, #DESC_PTR] // cargar puntero al mensaje
    ldr x0, [x0, #DESC_FD]  // cargar fd destino

    // write(fd, ptr, len)
    mov x8, #64             // syscall write
    svc #0                  // x0 = bytes escritos o error negativo
    cmp x0, #0              // revisar retorno signed
    b.lt write_error        // lt = write fallo
    mov x0, #0              // normalizar exito a 0
    ret                     // volver al caller

write_error:
    mov x0, #-1             // retorno negativo simplificado
    ret                     // volver al caller
