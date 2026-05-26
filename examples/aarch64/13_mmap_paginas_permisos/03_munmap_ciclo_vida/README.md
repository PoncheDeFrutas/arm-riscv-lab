# 13.3 · munmap Y Ciclo De Vida

## Objetivo

Separar la base de una region mapeada de un cursor de escritura y liberar la
region correcta con `munmap`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Despues de `mmap`, `x19` conserva la base y `x20` avanza como cursor mientras se
escriben bytes. `munmap` usa `x19`, no el cursor.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=13_mmap_paginas_permisos/03_munmap_ciclo_vida run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=13_mmap_paginas_permisos/03_munmap_ciclo_vida run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x19 x20 x21 x0 x1 x8 pc
x/8xb $x19
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `3`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: `mmap` o `munmap` falló. |

## Que Observar

- La base identifica la region completa.
- El cursor sirve para recorrerla, pero no reemplaza a la base.
- Despues de `munmap`, no se debe leer ni escribir esa direccion.

## Cambios Sugeridos

1. Cambia los tres bytes escritos.
2. Intenta pasar `x20` a `munmap` y observa el fallo.
3. Agrega un `write` antes de liberar para imprimir los bytes.
