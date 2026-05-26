# 08.3 · if/else

## Objetivo

Construir un `if/else` con comparacion, rama condicional, etiquetas y salto al
final del bloque.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa evalua si `7 < 10`. Si la condicion es verdadera, salta al bloque
`menor`; si no, ejecuta `mayor_o_igual` y luego salta a `fin_if` para no caer al
otro bloque.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=08_control_flujo/03_if_else run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=08_control_flujo/03_if_else run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 pc
x/10i $pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt menor` | Less than signed: salta si `N != V`; aqui representa `x1 < 10`. |
| `le` | cambio sugerido | Less or equal signed: salta si `Z = 1` o `N != V`. |

## Que Observar

- `cmp` prepara la decision.
- `b.lt menor` selecciona el bloque verdadero usando la condicion `lt`.
- `b fin_if` evita ejecutar ambos bloques.

## Cambios Sugeridos

1. Cambia `x1` a `10`.
2. Cambia la condicion a `b.le`.
3. Invierte los valores de salida.
