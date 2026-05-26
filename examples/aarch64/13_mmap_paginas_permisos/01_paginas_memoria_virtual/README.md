# 13.1 · Paginas Y Memoria Virtual

## Objetivo

Pedir una pagina de memoria virtual, observar que la base queda alineada y
liberar la region con `munmap`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa pide 4096 bytes con `mmap`, guarda la base, revisa los 12 bits bajos
para confirmar alineacion de pagina y libera la region.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/01_paginas_memoria_virtual run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/01_paginas_memoria_virtual run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 x4 x5 x8 x19 x20 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_region` | Less than signed: la syscall retorno un error negativo. |
| `ne` | `b.ne error_alineacion` | Not equal: los bits bajos no fueron cero. |

## Que Observar

- `x0 = 0` antes de `mmap` significa que el kernel elige la direccion.
- `x0` despues de `mmap` es base de region o error negativo.
- `munmap` necesita la base original, no un cursor modificado.

## Cambios Sugeridos

1. Cambia el tamano a `8192`.
2. Inspecciona `x19` y confirma que termina en bits bajos cero.
3. Cambia la mascara `0xfff` y observa que validacion estas haciendo.
