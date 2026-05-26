# 14.1 · Structs Y Layout Manual

## Objetivo

Definir un `Point` manual con offsets, tamano total y acceso a campos.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El layout tiene `x` en offset `0`, `y` en offset `8` y tamano total `16`. El
programa escribe `19` y `23`, luego suma ambos campos.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/01_structs_layout run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/01_structs_layout run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 pc
x/4gx &point
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `POINT_X` y `POINT_Y` son offsets, no valores.
- `POINT_SIZE` describe cuantos bytes ocupa un objeto completo.
- La CPU no conoce el struct; solo ve direcciones y desplazamientos.

## Cambios Sugeridos

1. Cambia los valores `19` y `23`.
2. Agrega un tercer campo y actualiza `POINT_SIZE`.
3. Inspecciona `point` como bytes y como quads.
