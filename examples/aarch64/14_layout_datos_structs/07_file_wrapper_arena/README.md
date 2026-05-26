# 14.7 · File Wrapper Y Arena Simple

## Objetivo

Combinar un wrapper de archivo con una arena simple para manejar recursos con
descriptores propios y cleanup claro.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El wrapper abre `entrada.txt` y guarda fd/estado. La arena entrega un bloque
para leer el archivo. Luego el programa escribe lo leido, cierra el wrapper y
resetea la arena.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/07_file_wrapper_arena run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/07_file_wrapper_arena run
```

## Depurar

```gdb
break file_open
break arena_alloc
break file_close
continue
info registers x0 x1 x2 x8 x19 x20 x21 pc
x/4gx &file_wrapper
x/4gx &arena_desc
stepi
```

## Salida Esperada

```text
Arena y file wrapper
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_fd` | Error antes de tener fd vivo. |
| `lt` | `b.lt cleanup_file` | Error con fd vivo; cerrar antes de salir. |
| `cbz` | `cbz x0, cleanup_file` | La arena no pudo entregar bloque. |
| `hi` | `b.hi arena_fail` | Higher unsigned: `used + size > capacity`. |

## Que Observar

- El fd real vive dentro del wrapper.
- La arena no libera cada bloque; resetea `used`.
- Cleanup depende de que recurso ya fue adquirido.

## Cambios Sugeridos

1. Baja la capacidad de la arena para forzar `arena_fail`.
2. Cambia el contenido de `entrada.txt`.
3. Borra temporalmente el archivo para revisar la ruta sin fd.
