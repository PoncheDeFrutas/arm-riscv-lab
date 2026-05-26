// 04.6 - Include y macros
//
// Objetivo:
//   Reutilizar constantes y una macro declaradas en constantes.inc.
//
// Registros usados:
//   x0 = fd para write, codigo dentro de la macro exit_ok.
//   x1 = direccion del mensaje.
//   x2 = longitud del mensaje.
//   x8 = numero de syscall.

.include "constantes.inc"   // inserta constantes y macros antes de ensamblar

.global _start

.section .text
_start:
    // write(STDOUT, msg, msg_len)
    mov x0, #STDOUT         // constante importada desde constantes.inc
    adr x1, msg             // direccion del mensaje local
    mov x2, msg_len         // bytes que write debe enviar
    mov x8, #SYS_write      // syscall write definida en constantes.inc
    svc #0                  // entrar al kernel

    // exit_ok
    exit_ok                 // macro que se expande a mov/mov/svc

.section .data
msg:
    .ascii "Include\n"      // texto usado por write
msg_len = . - msg
