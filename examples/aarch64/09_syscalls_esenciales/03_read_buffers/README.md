# 09.3 · read Y Buffers

## Objetivo

Leer bytes desde stdin hacia un buffer `.bss` y escribir exactamente la cantidad
real recibida.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`read` recibe fd `0`, direccion del buffer y maximo de bytes. Al volver, `x0`
contiene cuantos bytes llegaron; esa cantidad se copia a `x2` para `write`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=09_syscalls_esenciales/03_read_buffers
printf 'abc\n' | qemu-aarch64 09_syscalls_esenciales/03_read_buffers/src/build/main
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=09_syscalls_esenciales/03_read_buffers
printf 'abc\n' | 09_syscalls_esenciales/03_read_buffers/src/build/main
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 pc
x/16xb &buffer
stepi
```

## Salida Esperada

```text
abc
```

## Que Observar

- `read` escribe en memoria, no crea el buffer.
- Despues de `read`, `x0` es cantidad real leida.
- `write` debe usar la cantidad real, no siempre `64`.

## Cambios Sugeridos

1. Cambia el tamano maximo de lectura.
2. Prueba una entrada mas larga.
3. Inspecciona `buffer` antes y despues de `read`.
