# 03.3 · Flags NZCV

## Objetivo

Usar `cmp` para actualizar flags y convertir una condicion en un valor con
`cset`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=03_modelo_aarch64/03_flags_nzcv run
```

## Salida Esperada

No imprime texto. Termina con codigo `1`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `eq` | `cset x0, eq` | Equal: produce `1` si `Z = 1`, que ocurre cuando `cmp` vio igualdad. |
| `lt` | cambio sugerido | Less than signed: verdadero si `N != V`. Sirve para comparaciones con signo. |

## Que Observar

- `cmp x1, x2` actualiza NZCV.
- `cset x0, eq` produce `1` si `Z = 1`.
- En GDB puedes observar el registro `cpsr`/`pstate` segun la vista.

## Cambios Sugeridos

1. Cambia `x2` para que no sea igual.
2. Cambia `eq` por `lt`.
3. Prueba `subs` en vez de `cmp`.
