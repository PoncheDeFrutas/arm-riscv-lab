# 03.2 · Registros Especiales

## Objetivo

Mostrar el uso de `xzr` como registro cero y dejar preparado un punto para
observar `sp`, `pc` y `lr` en GDB.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=03_modelo_aarch64/02_registros_especiales run
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Que Observar

- `xzr` siempre lee cero.
- `pc` apunta a la instruccion actual.
- `sp` existe aunque este ejemplo no use el stack.

## Cambios Sugeridos

1. Intenta escribir en `xzr` y observa que no conserva el valor.
2. Consulta `info registers sp pc x30`.
3. Agrega una llamada con `bl` y mira `x30`.
