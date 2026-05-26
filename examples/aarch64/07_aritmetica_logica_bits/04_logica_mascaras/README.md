# 07.4 · Logica Y Mascaras

## Objetivo

Manipular bits con `and`, `orr`, `eor`, `bic` y probar un bit con `tst`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Dos patrones de bits se combinan para conservar, encender, alternar y apagar
bits. Luego `tst` verifica si el bit 3 esta encendido.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/04_logica_mascaras run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/04_logica_mascaras run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x5 x6 x7 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `13`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `ne` | `cset x7, ne` | Not equal: produce `1` si `Z = 0`. Despues de `tst`, eso indica que la mascara encontro algun bit encendido. |

## Que Observar

- `and` conserva bits compartidos.
- `orr` enciende bits.
- `bic` apaga bits usando una mascara.
- `tst` prueba bits sin guardar un resultado normal y actualiza `Z`.

## Cambios Sugeridos

1. Cambia los patrones iniciales.
2. Prueba otro bit con `tst`.
3. Cambia `bic` por `and` y compara.
