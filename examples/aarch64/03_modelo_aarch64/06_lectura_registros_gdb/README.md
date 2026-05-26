# 03.6 · Lectura De Registros Con GDB

## Objetivo

Preparar valores faciles de reconocer en registros para practicar `info
registers`, `x/i $pc`, `stepi` y breakpoints.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=03_modelo_aarch64/06_lectura_registros_gdb run
```

## Salida Esperada

No imprime texto. Termina con codigo `6`.

## Que Observar

- `x1`, `x2` y `x3` cambian antes de calcular `x0`.
- `pc` avanza instruccion por instruccion con `stepi`.
- `_start` es un buen breakpoint inicial.

## Cambios Sugeridos

1. Cambia los valores y vuelve a depurar.
2. Usa `display/i $pc`.
3. Agrega un breakpoint antes de `svc #0`.
