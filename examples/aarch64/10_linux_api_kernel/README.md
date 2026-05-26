# 10 · Linux Como API Del Kernel

Bloque: Programas Linux.

Esta unidad trata Linux como API del kernel: file descriptors, recursos,
archivos, rutas de error, `cleanup`, posicion, metadatos, procesos y tiempo.

## Ejemplos

| Ejemplo | Leccion | Estado |
|---|---|---|
| `01_file_descriptors` | 10.1 · File descriptors y recursos | implementado |
| `02_archivos_open_read_write_close` | 10.2 · Archivos con syscalls | implementado |
| `03_errores_cleanup` | 10.3 · Errores y cleanup | implementado |
| `04_posicion_metadatos` | 10.4 · Posicion y metadatos | implementado |
| `05_procesos_tiempo` | 10.5 · Procesos y tiempo | implementado |
| `06_programa_recursos` | 10.6 · Programa guiado con recursos | implementado |

## Flujo Recomendado

1. Entiende que un fd es un entero de recurso, no un puntero.
2. Lee y escribe archivos usando la cantidad real retornada por `read`.
3. Separa rutas de error con y sin fd vivo.
4. Usa `lseek` y `fstat` para posicion y metadatos.
5. Reconoce syscalls de proceso y tiempo con el mismo contrato.
6. Integra todo en el programa guiado con `cleanup`.
