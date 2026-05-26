# 07.7 · Bitfields

## Objetivo

Extraer e insertar campos dentro de un registro usando `ubfx` y `bfi`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa construye `0x12345678`, extrae el campo `0x56` desde los bits
15..8, e inserta `0xab` en otro campo del mismo registro.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/07_bitfields run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/07_bitfields run
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

No imprime texto. Termina con codigo `86`, que es `0x56`.

## Que Observar

- `ubfx` extrae bits y rellena con ceros.
- `bfi` inserta bits bajos de un registro en una posicion concreta.
- Las posiciones de bit no son offsets de memoria.

## Cambios Sugeridos

1. Extrae otro campo cambiando posicion y ancho.
2. Cambia el valor insertado.
3. Observa `x1` antes y despues de `bfi`.
