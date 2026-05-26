# 02.1 · Bits, Bytes Y Bases

## Objetivo

Mostrar que los valores binarios, hexadecimales y decimales terminan como datos
numericos en registros.

## Antes De Empezar

Este ejemplo no imprime texto. Usa el codigo de salida y GDB para comprobar el
resultado.

## Pasos De Estudio

1. Lee `src/main.s` y localiza los valores `0b1010` y `0x5`.
2. Ejecuta el programa.
3. Revisa el codigo de salida con `echo $?`.
4. Depura y observa `x1`, `x2` y `x0` antes de `svc #0`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=02_bases_binarias/01_bits_bytes_bases run
```

Luego verifica:

```bash
echo $?
```

## Salida Esperada

No imprime texto. Termina con codigo `15`.

## Que Observar

- `x0` se forma sumando `0b1010` y `0x5`.
- En GDB, cambia la visualizacion entre decimal y hexadecimal.
- `svc #0` usa `x0` como codigo de salida porque `x8 = 93`.

## Cambios Sugeridos

1. Cambia `0b1010` por otro valor binario.
2. Cambia `0x5` por otro valor hexadecimal.
3. Verifica el resultado con `echo $?`.
