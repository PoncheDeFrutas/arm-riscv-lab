# 05 · Primeros Programas En Linux AArch64

Bloque: Programas Linux.

Ejemplos para construir programas ejecutables sin libc usando `_start`,
`write`, `exit`, `stdout`, `stderr` y `svc #0`.

## Ejemplos

| Ejemplo | Leccion | Estado |
|---|---|---|
| `01_programa_minimo_exit` | 05.1 · Programa minimo con exit | implementado |
| `02_hello_world_write` | 05.2 · Hello World con write | implementado |
| `03_stdout_stderr_exit_codes` | 05.3 · stdout, stderr y codigos | implementado |
| `04_start_main_libc` | 05.4 · _start, main y libc | implementado |
| `05_lectura_guiada_syscalls` | 05.5 · Lectura guiada de syscalls | implementado |

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=05_primeros_programas/02_hello_world_write run
```
