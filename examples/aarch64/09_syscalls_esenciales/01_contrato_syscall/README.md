# 09.1 · Contrato De Syscall

## Objetivo

Mostrar el contrato basico de Linux AArch64: `x8` selecciona la syscall,
`x0-x5` pasan argumentos y `x0` recibe el retorno.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa prepara `write(stdout, msg, msg_len)` colocando argumentos en
`x0`, `x1`, `x2` y el numero de syscall en `x8`. Despues usa `exit(0)` con el
mismo contrato.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=09_syscalls_esenciales/01_contrato_syscall run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=09_syscalls_esenciales/01_contrato_syscall run
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
Contrato syscall
```

## Que Observar

- Antes de `svc #0`, `x8 = 64` selecciona `write`.
- Despues de `write`, `x0` ya no es fd: contiene retorno.
- `exit` reutiliza `x0` como codigo de salida.

## Cambios Sugeridos

1. Cambia el mensaje.
2. Cambia `x0` de `1` a `2` para escribir en stderr.
3. Observa `x0` justo despues de `write`.
