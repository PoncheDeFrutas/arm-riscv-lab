# 09.5 · Errores Minimos

## Objetivo

Detectar un retorno negativo de syscall con `cmp x0, #0` y `b.lt error`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa intenta abrir una ruta inexistente. `openat` devuelve un valor
negativo en `x0`; el codigo lo detecta y salta al bloque `error`, que escribe en
stderr y termina con codigo `1`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=09_syscalls_esenciales/05_errores_minimos
qemu-aarch64 09_syscalls_esenciales/05_errores_minimos/src/build/main
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=09_syscalls_esenciales/05_errores_minimos
09_syscalls_esenciales/05_errores_minimos/src/build/main
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 pc
stepi
```

## Salida Esperada

Escribe en stderr:

```text
Error minimo: openat fallo
```

Termina con codigo `1`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: salta si `x0 < 0`, es decir, si la syscall devolvio error negativo. |

## Que Observar

- El retorno negativo se revisa antes de usarlo como fd.
- El mensaje de error usa fd `2`.
- No se implementa `errno`; solo se detecta fallo.

## Cambios Sugeridos

1. Cambia la ruta para que exista.
2. Cambia el mensaje de error.
3. Observa el valor negativo exacto que devuelve `openat`.
