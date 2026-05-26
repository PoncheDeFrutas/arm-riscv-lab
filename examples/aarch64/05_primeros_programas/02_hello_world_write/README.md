# 05.2 · Hello World Con Write

## Objetivo

Escribir bytes en `stdout` usando la syscall `write`, sin `printf` y sin libc.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=05_primeros_programas/02_hello_world_write run
```

## Salida Esperada

```text
Hola AArch64
```

## Que Observar

- `x0 = 1` selecciona `stdout`.
- `x1` apunta al mensaje.
- `x2` contiene la longitud.
- `x8 = 64` selecciona `write`.

## Cambios Sugeridos

1. Cambia el mensaje.
2. Cambia `stdout` por `stderr`.
3. Observa el retorno de `write` en `x0` despues de `svc #0`.
