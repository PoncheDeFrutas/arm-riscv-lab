# 11.6 · Debugging De Frames Con GDB

## Objetivo

Preparar un programa con llamadas anidadas para observar `sp`, `x29`, `x30`,
frames enlazados y backtrace en GDB.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` llama a `funcion_a`, que llama a `funcion_b`, que llama a
`funcion_c`. Las tres funciones crean frame para que GDB pueda mostrar una
cadena clara de llamadas.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=11_stack_funciones_frames/06_debugging_frames_gdb run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=11_stack_funciones_frames/06_debugging_frames_gdb run
echo $?
```

## Depurar

```gdb
break funcion_c
continue
bt
info registers sp x29 x30 x0 pc
x/4gx $x29
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `bt` debe mostrar la cadena `_start -> funcion_a -> funcion_b -> funcion_c`.
- En cada frame, `[x29]` apunta al frame anterior y `[x29, #8]` guarda retorno.
- Al salir de cada funcion, `ldp x29, x30, [sp], #16` recupera el contexto del caller.

## Cambios Sugeridos

1. Cambia el breakpoint a `funcion_b`.
2. Ejecuta `finish` para ver como se deshace un frame.
3. Usa `x/6gx $sp` dentro de `funcion_b` y compara con `x/4gx $x29`.
