# 15.2 · Argumentos, Retornos Y Stack

## Objetivo

Mostrar los primeros ocho argumentos en registros y los argumentos adicionales
en el stack.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` llama a `sumar10`. Los argumentos `1..8` van en `x0..x7`; los
argumentos `9` y `10` se colocan en el stack antes del `bl`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/02_argumentos_retornos_stack run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/02_argumentos_retornos_stack run
echo $?
```

## Depurar

```gdb
break sumar10
continue
info registers x0 x1 x2 x3 x4 x5 x6 x7 sp pc
x/4gx $sp
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `55`.

## Que Observar

- `sp` se mantiene alineado a 16 bytes.
- `sumar10` lee el noveno argumento desde `[sp]`.
- El retorno entero vuelve en `x0`.

## Cambios Sugeridos

1. Cambia el noveno y decimo argumento.
2. Quita la restauracion de `sp` y razona por que seria incorrecto.
3. Reescribe la funcion para sumar solo los primeros ocho argumentos.
