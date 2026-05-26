# 09 · Syscalls Esenciales

Bloque: Programas Linux.

Esta unidad usa Linux directamente desde assembly: contrato de syscall, `exit`,
`write`, `read`, `openat`, `close`, retornos negativos y manejo minimo de error.

## Ejemplos

| Ejemplo | Leccion | Estado |
|---|---|---|
| `01_contrato_syscall` | 09.1 · Contrato de syscall | implementado |
| `02_exit_write` | 09.2 · exit y write | implementado |
| `03_read_buffers` | 09.3 · read y buffers | implementado |
| `04_openat_close` | 09.4 · openat y close | implementado |
| `05_errores_minimos` | 09.5 · Errores minimos | implementado |
| `06_programa_guiado` | 09.6 · Programa guiado | implementado |

## Flujo Recomendado

1. Lee primero el contrato: `x8`, `x0-x5`, `svc #0` y retorno en `x0`.
2. Formaliza `exit` y `write` antes de leer entrada.
3. Usa `read` con buffers para conectar syscalls y memoria.
4. Abre y cierra archivos con `openat` y `close`.
5. Detecta errores negativos con `cmp` y `b.lt`.
6. Cierra con el programa guiado.
