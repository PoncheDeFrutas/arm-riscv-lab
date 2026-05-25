# 01.3 · Primer Programa

## Objetivo

Compilar y ejecutar un programa AArch64 minimo que escribe `Hola ARM64` en
`stdout` y termina con codigo de salida `0`.

Este ejemplo acompana la leccion `01.3 · Primer programa` de la unidad de
laboratorio.

## Idea Del Programa

El programa hace dos syscalls directas de Linux:

| Syscall | Numero en `x8` | Argumentos principales |
|---|---:|---|
| `write` | `64` | `x0=1`, `x1=msg`, `x2=msg_len` |
| `exit` | `93` | `x0=0` |

No usa `printf`, `main` ni libc. El proceso empieza en `_start`.

## Ejecutar Con QEMU

Desde `examples/aarch64`:

```bash
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=01_laboratorio/03_primer_programa run
```

## Depurar

Abre `src/main.s` en VS Code y usa:

- `Debug ARM64 QEMU - archivo activo`, si estas en x86_64 con QEMU.
- `Debug ARM64 nativo - archivo activo`, si estas en Linux ARM64 real.

Comandos utiles en la consola de GDB:

```gdb
break _start
continue
info registers x0 x1 x2 x8 pc
x/s $x1
stepi
```

## Salida Esperada

```text
Hola ARM64
```

## Que Observar

- `x0 = 1` antes de `write`, porque `1` es `stdout`.
- `x1` apunta al primer byte del mensaje.
- `x2` contiene la cantidad de bytes a escribir.
- `x8` cambia de `64` para `write` a `93` para `exit`.

## Cambios Sugeridos

1. Cambia el texto del mensaje y ajusta nada mas; la longitud se calcula sola.
2. Cambia `x0` de `1` a `2` en la syscall `write` para escribir en `stderr`.
3. Cambia el codigo de salida final y verificalo con `echo $?`.
