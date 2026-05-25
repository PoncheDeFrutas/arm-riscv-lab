# 05.1 · Programa Minimo Con `exit`

## Objetivo

Construir el programa AArch64 mas pequeno util en Linux: entrar por `_start`,
pedir la syscall `exit` y devolver un codigo de salida al sistema operativo.

Este ejemplo acompana la leccion `05.1 · Programa minimo con exit`.

## Idea Del Programa

El programa no imprime texto. Solo prepara dos registros y ejecuta `svc #0`:

| Registro | Valor | Significado |
|---|---:|---|
| `x0` | `0` | codigo de salida |
| `x8` | `93` | syscall `exit` en Linux AArch64 |

`svc #0` no significa "salir" por si sola. La instruccion entra al kernel, y el
kernel decide que hacer leyendo el numero de syscall en `x8`.

## Archivos

```text
05_primeros_programas/01_programa_minimo_exit/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

Desde `examples/aarch64`:

```bash
make -f Makefile.qemu EXAMPLE=05_primeros_programas/01_programa_minimo_exit run
echo $?
```

## Ejecutar En ARM64 Nativo

En una maquina Linux ARM64 real:

```bash
make -f Makefile.native EXAMPLE=05_primeros_programas/01_programa_minimo_exit run
echo $?
```

## Depurar

Abre `src/main.s` en VS Code y usa:

- `Debug ARM64 QEMU - archivo activo`, si estas en x86_64 con QEMU.
- `Debug ARM64 nativo - archivo activo`, si estas en Linux ARM64 real.

En la consola de GDB observa:

```gdb
break _start
continue
info registers x0 x8 pc
x/4i $pc
stepi
```

## Salida Esperada

El programa no imprime nada. El codigo de salida esperado es `0`:

```text
0
```

## Que Observar

- Antes de `svc #0`, `x0` contiene el codigo que vera el shell.
- Antes de `svc #0`, `x8` contiene `93`, el numero de `exit`.
- Despues de `svc #0`, el proceso termina; no hay una siguiente instruccion
  util del programa.

## Errores Comunes

- Olvidar `.global _start`: el linker puede no encontrar un punto de entrada
  claro.
- Confundir `x0` con `x8`: `x0` es argumento, `x8` selecciona la syscall.
- Esperar salida visible: este programa solo devuelve un codigo de salida.

## Cambios Sugeridos

1. Cambia `mov x0, #0` por `mov x0, #7` y verifica `echo $?`.
2. Pon un breakpoint en `_start` y avanza instruccion por instruccion.
3. Explica por que `svc #0` cambia de significado si cambia el valor de `x8`.
