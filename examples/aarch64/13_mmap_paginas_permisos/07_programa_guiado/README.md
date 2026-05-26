# 13.7 · Programa Guiado

## Objetivo

Juntar `mmap`, escritura, `mprotect`, `write`, `munmap` y rutas de cleanup en un
programa pequeno.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Se mapea una pagina RW, se escribe `OK\n`, se cambia a solo lectura, se imprime
desde la region y se libera con `munmap`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/07_programa_guiado run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/07_programa_guiado run
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 x19 pc
x/8cb $x19
stepi
```

## Salida Esperada

```text
OK
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_region` | Fallo antes de tener region o despues de liberarla. |
| `lt` | `b.lt cleanup` | Fallo con region viva; hacer `munmap` antes de salir. |

## Que Observar

- La region cambia de estado: sin region, RW, R, liberada.
- Despues de `mprotect`, el programa solo lee desde la region.
- `cleanup` existe porque varias syscalls pueden fallar despues de `mmap`.

## Cambios Sugeridos

1. Cambia el mensaje escrito dentro de la region.
2. Intenta escribir despues de `mprotect` para ver el fallo real.
3. Agrega un breakpoint en `cleanup` y provoca un error cambiando argumentos.
