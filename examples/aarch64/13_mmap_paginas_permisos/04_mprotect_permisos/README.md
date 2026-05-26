# 13.4 · mprotect, Permisos Y W^X

## Objetivo

Cambiar una region de lectura/escritura a solo lectura con `mprotect` y evitar
escrituras despues del cambio.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa escribe un byte mientras la region es RW, cambia permisos a R,
lee ese byte y libera la region. No escribe despues de `mprotect`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/04_mprotect_permisos run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/04_mprotect_permisos run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 x19 x20 pc
x/8xb $x19
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `82`, que corresponde al byte ASCII `R`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt cleanup` | Less than signed: hubo error con region viva y hay que liberar. |
| `lt` | `b.lt error` | Less than signed: fallo antes de tener region o despues de liberarla. |

## Que Observar

- `mprotect` cambia permisos de una region existente.
- Leer despues de pasar a `PROT_READ` es valido.
- Escribir despues del cambio provocaria fallo; por eso queda como ejercicio.

## Cambios Sugeridos

1. Intenta escribir despues de `mprotect` para observar el fallo.
2. Cambia el byte `R` por otro valor.
3. Usa `strace` para ver `mmap`, `mprotect` y `munmap`.
