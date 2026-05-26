# 13.6 · Errores Y Diagnostico

## Objetivo

Practicar el patron de diagnostico minimo: revisar retornos negativos y tomar
una ruta clara de error sin provocar fallos de memoria.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Se llama `mmap` con longitud `0`, un argumento invalido. El error negativo es el
resultado esperado; el programa lo reconoce, imprime un mensaje y termina con
codigo `0`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/06_errores_diagnostico run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/06_errores_diagnostico run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 x4 x5 x8 pc
stepi
```

## Salida Esperada

```text
mmap fallo como se esperaba
```

Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_esperado` | Less than signed: `mmap` retorno un error negativo. |

## Que Observar

- Un error esperado tambien debe comprobarse explicitamente.
- En syscall directa no hay wrapper de libc; el retorno negativo vive en `x0`.
- No hay region que liberar cuando `mmap` falla.

## Cambios Sugeridos

1. Cambia la longitud de `0` a `4096` y observa que ya no toma la ruta esperada.
2. Cambia los permisos para provocar otro error.
3. Usa GDB para ver el valor negativo exacto en `x0`.
