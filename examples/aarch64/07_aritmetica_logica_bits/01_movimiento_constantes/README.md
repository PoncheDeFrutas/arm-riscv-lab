# 07.1 · Movimiento De Constantes

## Objetivo

Construir constantes pequenas y grandes usando instrucciones de movimiento, sin
leer memoria.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El ejemplo compara una constante inmediata pequena con una constante grande
construida por bloques de 16 bits usando `movz` y `movk`. Tambien muestra
`movn` para generar un patron de bits invertido.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/01_movimiento_constantes run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/01_movimiento_constantes run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `136`, el byte bajo `0x88`.

## Que Observar

- `movz` limpia el registro antes de escribir un bloque.
- `movk` conserva el valor existente y reemplaza un bloque.
- `ldr` no aparece porque no se lee memoria.

## Cambios Sugeridos

1. Cambia el bloque bajo `0x7788`.
2. Cambia el `and` final para conservar otro byte.
3. Observa `x2` despues de cada `movk`.
