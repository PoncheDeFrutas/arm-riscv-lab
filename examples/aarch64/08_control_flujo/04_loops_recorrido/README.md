# 08.4 · Loops Y Recorrido

## Objetivo

Recorrer un array con un loop real usando `cbz`, post-index y una rama hacia
atras.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El loop mantiene un puntero al elemento actual, un contador de elementos
restantes y un acumulador. Cada vuelta lee un `.quad`, avanza el puntero y reduce
el contador.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=08_control_flujo/04_loops_recorrido run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=08_control_flujo/04_loops_recorrido run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 pc
x/4gd &array
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `50`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cbz` | `cbz x2, fin` | Compare and branch if zero: salta si `x2 == 0`. No necesita un `cmp` separado. |

## Que Observar

- `cbz` sale del loop cuando el contador llega a cero.
- `[x1], #8` lee y avanza el puntero.
- `b loop` es la rama hacia atras que repite.

## Cambios Sugeridos

1. Cambia los valores del array.
2. Cambia la cantidad de elementos.
3. Cambia `.quad` por `.word` y ajusta el avance.
