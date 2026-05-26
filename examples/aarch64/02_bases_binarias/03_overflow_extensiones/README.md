# 02.3 · Overflow, Carry Y Extensiones

## Objetivo

Provocar overflow en 32 bits y observar el flag de carry con `ADDS`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=02_bases_binarias/03_overflow_extensiones run
```

## Salida Esperada

No imprime texto. Termina con codigo `1` porque hubo carry.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cs` | `cset x0, cs` | Carry set: produce `1` si `C = 1`. En suma unsigned indica que hubo acarreo. |
| `eq` | cambio sugerido | Equal: produce `1` si `Z = 1`, es decir, si el resultado fue cero. |

## Que Observar

- `w1 = 0xffffffff` mas `1` produce `0` en 32 bits.
- `adds` actualiza flags.
- `cset x0, cs` convierte la condicion `C = 1` en `0` o `1`.

## Cambios Sugeridos

1. Cambia `w1` por `0x7fffffff`.
2. Cambia la condicion `cs` por `eq`.
3. Observa `NZCV` despues de `adds`.
