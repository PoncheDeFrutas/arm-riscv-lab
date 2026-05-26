# 03.1 · Registros Generales

## Objetivo

Usar registros `x` y `w` para mover valores y calcular un resultado pequeno.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=03_modelo_aarch64/01_registros_generales run
```

## Salida Esperada

No imprime texto. Termina con codigo `30`.

## Que Observar

- `x0`, `x1` y `x2` son registros de 64 bits.
- El resultado queda en `x0` para usarlo como codigo de salida.
- En GDB puedes consultar `info registers x0 x1 x2`.

## Cambios Sugeridos

1. Cambia los operandos.
2. Usa registros `w` y observa como se limpia la mitad alta.
3. Cambia `add` por `sub`.
