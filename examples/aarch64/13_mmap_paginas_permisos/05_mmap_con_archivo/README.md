# 13.5 · mmap Con Archivo

## Objetivo

Abrir un archivo, mapear su contenido con `mmap`, escribirlo a stdout y liberar
los dos recursos: fd y region.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`openat` entrega un fd, `mmap` crea una region de lectura privada sobre el
archivo, `close` libera el fd y `munmap` libera la region despues del `write`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/05_mmap_con_archivo run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/05_mmap_con_archivo run
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 x4 x5 x8 x19 x20 pc
x/32cb $x20
stepi
```

## Salida Esperada

```text
Archivo mapeado
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_fd` | Error antes de tener fd o despues de liberar recursos. |
| `lt` | `b.lt cleanup_fd` | Error con fd vivo; cerrar antes de salir. |
| `lt` | `b.lt cleanup_region` | Error con region viva; `munmap` antes de salir. |

## Que Observar

- Cerrar el fd no destruye el mapeo.
- `write` usa la direccion retornada por `mmap`.
- Hay dos recursos con dos limpiezas distintas.

## Cambios Sugeridos

1. Cambia el contenido de `entrada.txt`.
2. Borra temporalmente `entrada.txt` para probar `error_sin_fd`.
3. Cambia `MAP_PRIVATE` por otro flag solo despues de revisar la documentacion.
