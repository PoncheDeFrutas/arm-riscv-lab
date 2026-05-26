# 09.2 · exit Y write

## Objetivo

Formalizar `exit` y `write`, usando stdout y stderr como file descriptors
iniciales.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa escribe un mensaje en `stdout` usando fd `1`, otro en `stderr`
usando fd `2`, y termina con `exit(0)`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=09_syscalls_esenciales/02_exit_write run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=09_syscalls_esenciales/02_exit_write run
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 pc
stepi
```

## Salida Esperada

```text
stdout desde write
stderr desde write
```

El segundo mensaje sale por stderr.

## Que Observar

- `write` no usa terminador `NULL`; necesita longitud.
- `x0 = 1` escribe en stdout.
- `x0 = 2` escribe en stderr.

## Cambios Sugeridos

1. Intercambia los file descriptors.
2. Cambia la longitud y observa si se corta el mensaje.
3. Termina con `exit(7)` y revisa `echo $?`.
