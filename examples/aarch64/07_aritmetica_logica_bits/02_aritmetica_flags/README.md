# 07.2 · Aritmetica Y Flags

## Objetivo

Ver como `adds`, `cmp` y `cset` permiten convertir flags en resultados
observables.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa provoca carry unsigned con `0xffffffffffffffff + 1`, luego compara
dos valores iguales. Cada condicion verdadera se convierte en `1` con `cset`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/02_aritmetica_flags run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/02_aritmetica_flags run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x5 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `2`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cs` | `cset x4, cs` | Carry set: produce `1` si `C = 1`. En este ejemplo aparece por el carry unsigned de la suma. |
| `eq` | `cset x5, eq` | Equal: produce `1` si `Z = 1`, resultado de comparar valores iguales. |
| `ne` | cambio sugerido | Not equal: produce `1` si `Z = 0`. |

## Que Observar

- `adds` guarda resultado y actualiza NZCV.
- `cmp` actualiza flags y descarta el resultado.
- `cset` transforma una condicion como `cs` o `eq` en `0` o `1`.

## Cambios Sugeridos

1. Cambia `adds` por `add` y observa que el razonamiento sobre flags cambia.
2. Cambia uno de los valores comparados.
3. Prueba `cset x5, ne`.
