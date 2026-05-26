# 11.4 · Funciones No Hoja

## Objetivo

Entender por que una funcion que llama a otra debe proteger su `x30` y los
temporales que necesitara despues del `bl`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` llama a `funcion_no_hoja`. Esa funcion guarda su retorno, conserva el
argumento original en stack, llama a `duplicar` y luego combina ambos valores.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=11_stack_funciones_frames/04_funciones_no_hoja run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=11_stack_funciones_frames/04_funciones_no_hoja run
echo $?
```

## Depurar

```gdb
break funcion_no_hoja
break duplicar
continue
info registers x0 x1 sp x29 x30 pc
x/4gx $sp
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `62`.

## Que Observar

- El primer `bl` coloca en `x30` el retorno hacia `_start`.
- El segundo `bl`, dentro de `funcion_no_hoja`, sobrescribe `x30`.
- Por eso el prologo guarda `x30` antes de llamar a `duplicar`.

## Cambios Sugeridos

1. Cambia el argumento inicial `20`.
2. Quita el `str x0, [sp]` y observa que se pierde el valor original.
3. Compara esta funcion con `duplicar`, que si es funcion hoja.
