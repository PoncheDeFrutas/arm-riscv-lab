# 08.5 · csel Y Branches Especializados

## Objetivo

Usar `cbz`, `cbnz`, `tbnz`, `csel` y `cset` para decisiones pequenas.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa toma una decision con cero/no cero, otra decision con un bit
encendido, y luego usa `csel` para escoger el mayor sin escribir otro bloque
`if/else`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=08_control_flujo/05_csel_branches run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=08_control_flujo/05_csel_branches run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x5 x6 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `7`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cbz` | `cbz x1, es_cero` | Compare and branch if zero: salta si `x1 == 0`. |
| `cbnz` | `cbnz x2, tiene_valor` | Compare and branch if not zero: salta si `x2 != 0`. |
| `tbnz` | `tbnz x3, #3, bit_encendido` | Test bit and branch if not zero: salta si el bit 3 vale `1`. |
| `gt` | `csel x5, x4, x2, gt` | Greater than signed: elige el primer registro si `Z = 0` y `N = V`. |
| `gt` | `cset x6, gt` | La misma condicion se convierte en `1` si se cumple, o `0` si no. |
| `lt` | cambio sugerido | Less than signed: verdadero si `N != V`. |

## Que Observar

- `cbz` y `cbnz` evitan un `cmp` contra cero.
- `tbnz` prueba un bit especifico.
- `csel` elige entre dos registros sin saltar, pero depende de flags preparados por `cmp`.

## Cambios Sugeridos

1. Cambia `x1` a `1`.
2. Cambia la mascara `0b1000`.
3. Cambia `gt` por `lt` en `csel` y `cset`.
