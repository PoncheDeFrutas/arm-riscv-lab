# 17.4 · Stack Frames En GDB

## Objetivo

Inspeccionar `sp`, `x29`, `x30`, frame pointer y backtrace en llamadas anidadas.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` llama a `funcion_a`, que llama a `funcion_b`, que llama a
`funcion_c`. Cada funcion crea frame para que GDB pueda reconstruir la cadena.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/04_stack_frames_gdb run
echo $?
```

## Depurar

```gdb
break funcion_c
continue
bt
info registers sp x29 x30 x0 pc
x/8gx $sp
x/4gx $x29
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `x29` enlaza el frame actual con el anterior.
- `[x29, #8]` contiene el retorno guardado en el patron usado.
- `bt` mejora cuando hay simbolos y frames claros.

## Cambios Sugeridos

1. Quita un frame y observa como cambia `bt`.
2. Detente en `funcion_b`.
3. Usa `finish` para salir de una funcion.
