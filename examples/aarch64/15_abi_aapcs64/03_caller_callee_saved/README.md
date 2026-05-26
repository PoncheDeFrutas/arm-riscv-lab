# 15.3 · Caller-Saved, Callee-Saved Y Funciones Correctas

## Objetivo

Preservar un registro callee-saved (`x19`) dentro de una funcion que lo usa como
temporal.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` guarda `40` en `x19`. La funcion `usar_x19` tambien usa `x19`, pero lo
guarda y restaura. Si la preservacion es correcta, el resultado final es `42`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/03_caller_callee_saved run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/03_caller_callee_saved run
echo $?
```

## Depurar

```gdb
break usar_x19
continue
info registers x0 x19 sp x30 pc
x/4gx $sp
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `x19` pertenece al grupo callee-saved.
- La funcion puede usarlo, pero debe restaurarlo antes de retornar.
- El resultado correcto no basta si el entorno del caller queda corrupto.

## Cambios Sugeridos

1. Comenta la restauracion de `x19` y observa el efecto.
2. Cambia el valor inicial guardado por `_start`.
3. Agrega preservacion de otro registro callee-saved.
