# 02.2 · Enteros, Signo Y Rangos

## Objetivo

Comparar una lectura sin signo y una lectura con signo usando el mismo patron de
bits de 32 bits.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=02_bases_binarias/02_enteros_signo_rangos run
```

## Salida Esperada

No imprime texto. Termina con codigo `255`.

## Que Observar

- `w1 = 0xffffffff` puede leerse como `4294967295` sin signo o `-1` con signo.
- `sxtw x0, w1` extiende con signo hacia 64 bits.
- El shell solo muestra el byte bajo del codigo de salida.

## Cambios Sugeridos

1. Cambia `0xffffffff` por `0x7fffffff`.
2. Compara `sxtw` con `uxtw`.
3. Observa `x0` en hexadecimal dentro de GDB.
