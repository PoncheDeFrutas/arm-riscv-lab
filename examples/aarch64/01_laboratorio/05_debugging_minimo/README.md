# 01.5 · Debugging Minimo

## Objetivo

Tener un programa corto para practicar breakpoints, lectura de registros y
avance con `stepi`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=01_laboratorio/05_debugging_minimo run
```

## Depurar

Abre `src/main.s` y usa `Debug ARM64 QEMU - archivo activo`.

Comandos utiles:

```gdb
break _start
continue
info registers x0 x1 x2 x8 pc
x/6i $pc
stepi
```

## Salida Esperada

```text
Debug
```

## Que Observar

- Antes del primer `svc #0`, `x8 = 64`.
- Antes del segundo `svc #0`, `x8 = 93`.
- `pc` avanza una instruccion con `stepi`.

## Cambios Sugeridos

1. Pon un breakpoint antes del segundo `svc #0`.
2. Observa `x/s $x1`.
3. Cambia el codigo de salida final.
