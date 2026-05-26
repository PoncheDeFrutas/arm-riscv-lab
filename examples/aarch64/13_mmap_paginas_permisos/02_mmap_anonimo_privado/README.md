# 13.2 · mmap Anonimo Privado

## Objetivo

Pedir memoria dinamica real al kernel con `mmap` anonimo privado, escribir un
byte y liberar la region.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa crea una region `PROT_READ | PROT_WRITE`, guarda la base en `x19`,
escribe `A` y luego llama a `munmap`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/02_mmap_anonimo_privado run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/02_mmap_anonimo_privado run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 x4 x5 x8 x19 pc
x/8xb $x19
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: una syscall retorno error negativo. |

## Que Observar

- `MAP_ANONYMOUS` significa que la region no viene de un archivo.
- `MAP_PRIVATE` significa que los cambios son privados del proceso.
- La base debe guardarse antes de usar `x0` para otra syscall.

## Cambios Sugeridos

1. Cambia el byte escrito de `A` a `Z`.
2. Agrega un `write` antes de `munmap` para imprimir el byte.
3. Cambia permisos a solo lectura y observa por que escribir ya no seria seguro.
