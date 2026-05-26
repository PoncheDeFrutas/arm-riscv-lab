# 11.3 · Stack Frames

## Objetivo

Construir una funcion con prologo, epilogo, `x29` como frame pointer y una
variable local en stack.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` llama a `calcular`. La funcion guarda `x29` y `x30`, crea un frame,
reserva 16 bytes para un local, calcula `40 + 2` y retorna `42`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=11_stack_funciones_frames/03_stack_frames run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=11_stack_funciones_frames/03_stack_frames run
echo $?
```

## Depurar

```gdb
break calcular
continue
info registers sp x29 x30 x0 pc
x/4gx $sp
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `stp x29, x30, [sp, #-16]!` reserva 16 bytes y guarda frame anterior y retorno.
- `mov x29, sp` fija el frame pointer de la funcion actual.
- Los locales se liberan antes de restaurar `x29` y `x30`.

## Cambios Sugeridos

1. Cambia el local `40`.
2. Inspecciona `[x29]` y `[x29, #8]` en GDB.
3. Comenta temporalmente `add sp, sp, #16` para ver por que el epilogo depende
   de restaurar los locales primero.
