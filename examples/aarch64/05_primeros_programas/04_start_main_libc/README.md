# 05.4 · _start, main Y libc

## Objetivo

Mostrar que sin runtime de C el proceso entra en `_start`; si queremos una
rutina llamada `main`, debemos llamarla explicitamente.

## Antes De Empezar

Este ejemplo no usa libc. El nombre `main` aqui es solo una etiqueta que
nosotros llamamos con `bl main`; no hay runtime de C preparando argumentos ni
llamando a `main` automaticamente.

## Idea Del Programa

1. Linux entra al binario por `_start`.
2. `_start` llama a `main` con `bl main`.
3. `main` deja su retorno en `x0` y vuelve con `ret`.
4. `_start` usa ese `x0` como codigo de salida para `exit`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=05_primeros_programas/04_start_main_libc run
```

Luego verifica:

```bash
echo $?
```

## Depurar

Abre `src/main.s` y usa F5. En GDB:

```gdb
break _start
break main
continue
info registers x0 x30 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `5`.

## Que Observar

- `_start` es el punto real de entrada.
- `bl main` guarda retorno en `x30`.
- `main` devuelve su resultado en `x0`.

## Cambios Sugeridos

1. Cambia el valor que devuelve `main`.
2. Pon breakpoints en `_start` y `main`.
3. Observa `x30` despues de `bl main`.
