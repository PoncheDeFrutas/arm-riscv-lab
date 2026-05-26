// 10.5 - Procesos y tiempo
//
// Objetivo:
//   Usar getpid, clock_gettime y nanosleep con el mismo contrato de syscall.
//
// Registros usados:
//   x0 = argumentos y retornos de syscalls.
//   x1 = puntero a timespec o rem.
//   x8 = numero de syscall Linux AArch64.
//   x19 = pid devuelto por getpid para inspeccion en GDB.

.equ CLOCK_MONOTONIC, 1

.global _start

.section .text
_start:
    // getpid()
    mov x8, #172            // syscall getpid, sin argumentos
    svc #0                  // x0 = pid del proceso
    mov x19, x0             // guardar pid solo para inspeccion

    // clock_gettime(CLOCK_MONOTONIC, &now)
    mov x0, #CLOCK_MONOTONIC // reloj monotonic
    adr x1, now             // buffer timespec donde el kernel escribe tiempo
    mov x8, #113            // syscall clock_gettime
    svc #0                  // x0 = 0 o error negativo
    cmp x0, #0              // revisar retorno como signed
    b.lt error              // lt = menor signed: error si x0 < 0

    // nanosleep(&req, NULL)
    adr x0, req             // puntero a timespec solicitado
    mov x1, #0              // no guardar tiempo restante si se interrumpe
    mov x8, #101            // syscall nanosleep
    svc #0                  // x0 = 0 o error negativo
    cmp x0, #0              // revisar retorno como signed
    b.lt error              // lt = menor signed: error si x0 < 0

    // exit(0)
    mov x0, #0              // codigo de salida exitoso
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

error:
    // exit(1)
    mov x0, #1              // codigo de salida con error
    mov x8, #93             // syscall exit
    svc #0                  // terminar proceso

.section .data
req:
    .quad 0                 // segundos
    .quad 1000000           // nanosegundos: 1 ms

.section .bss
now:
    .skip 16                // struct timespec: segundos y nanosegundos
