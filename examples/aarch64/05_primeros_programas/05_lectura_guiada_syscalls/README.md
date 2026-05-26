# 05.5 · Lectura Guiada De Syscalls

## Objetivo

Leer un programa pequeno preguntando siempre que hay en `x8` y que argumentos
acompanan esa syscall.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=05_primeros_programas/05_lectura_guiada_syscalls run
```

## Salida Esperada

```text
Syscall
```

## Que Observar

- Primer `svc #0`: `x8 = 64`, entonces `x0`, `x1`, `x2` son argumentos de `write`.
- Segundo `svc #0`: `x8 = 93`, entonces `x0` es codigo de salida.
- GDB permite revisar registros justo antes de cada syscall.

## Cambios Sugeridos

1. Pon breakpoint antes del primer `svc #0`.
2. Pon breakpoint antes del segundo `svc #0`.
3. Cambia el codigo de salida final.
