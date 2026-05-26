# 08.2 · Condiciones Y Flags

## Objetivo

Comparar los mismos bits usando condiciones signed y unsigned.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`x1` contiene todos los bits en `1`. Signed eso significa `-1`; unsigned eso
significa el valor maximo. La misma comparacion permite que `lt` y `hi` sean
verdaderas por interpretaciones distintas.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=08_control_flujo/02_condiciones_flags run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=08_control_flujo/02_condiciones_flags run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `2`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `cset x3, lt` | Less than signed: verdadero si `N != V`; lee `-1 < 1`. |
| `hi` | `cset x4, hi` | Higher unsigned: verdadero si `C = 1` y `Z = 0`; lee `0xffff...ffff > 1`. |
| `ge` | cambio sugerido | Greater or equal signed: verdadero si `N = V`. |
| `ls` | cambio sugerido | Lower or same unsigned: verdadero si `C = 0` o `Z = 1`. |

## Que Observar

- `cmp` prepara los flags una sola vez.
- `lt` interpreta la comparacion como signed.
- `hi` interpreta la comparacion como unsigned.

## Cambios Sugeridos

1. Cambia `movn x1, #0` por `mov x1, #2`.
2. Prueba `cset x3, ge`.
3. Prueba `cset x4, ls`.
