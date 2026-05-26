# 08.1 · Branching Y Etiquetas

## Objetivo

Entender que una etiqueta nombra una posicion y que una rama cambia el flujo de
ejecucion hacia esa posicion.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Primero se usa un salto hacia adelante para omitir una instruccion. Despues se
usa una rama hacia atras para repetir un contador hasta llegar a `3`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=08_control_flujo/01_branching_etiquetas run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=08_control_flujo/01_branching_etiquetas run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 pc
x/8i $pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `3`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt loop` | Less than signed: salta si `N != V`, es decir, si la comparacion signed indica menor que. |
| `le` | cambio sugerido | Less or equal signed: salta si `Z = 1` o `N != V`. |

## Que Observar

- El salto hacia adelante omite `mov x0, #1`.
- El salto hacia atras forma un loop.
- La etiqueta no ejecuta nada por si misma.

## Cambios Sugeridos

1. Cambia el limite del contador.
2. Quita el primer `b` y observa el resultado.
3. Cambia `b.lt` por `b.le`.
