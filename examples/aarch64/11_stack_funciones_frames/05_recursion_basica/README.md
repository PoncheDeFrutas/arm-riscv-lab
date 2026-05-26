# 11.5 · Recursion Basica

## Objetivo

Usar recursion pequena para ver que cada llamada necesita su propio frame, su
propio retorno y su propio valor temporal.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`suma(4)` calcula `4 + 3 + 2 + 1 + 0`. Cada llamada guarda su `n` local antes de
llamar a `suma(n - 1)`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=11_stack_funciones_frames/05_recursion_basica run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=11_stack_funciones_frames/05_recursion_basica run
echo $?
```

## Depurar

```gdb
break suma
continue
bt
info registers x0 x1 sp x29 x30 pc
x/4gx $sp
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `10`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cbz` | `cbz x0, caso_base` | Compare and branch if zero: salta cuando `n == 0`. |

## Que Observar

- El caso base evita que la recursion continue para siempre.
- Cada llamada guarda su propio `x30`; no hay un unico retorno global.
- Cada frame guarda su copia de `n` antes de llamar a la siguiente recursion.

## Cambios Sugeridos

1. Cambia el argumento inicial `4`.
2. Usa `bt` en GDB cuando estes dentro del caso base.
3. Comenta el `str x0, [sp]` para ver por que se necesita conservar `n`.
