# 11.1 · Llamadas Y Retorno

## Objetivo

Usar `bl` para llamar a una funcion hoja y `ret` para regresar al caller.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` coloca `21` en `x0`, llama a `duplicar` y recibe `42` de regreso en
`x0`. La funcion no llama a nadie mas, por eso puede retornar directamente con
`ret`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=11_stack_funciones_frames/01_llamadas_retorno run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=11_stack_funciones_frames/01_llamadas_retorno run
echo $?
```

## Depurar

```gdb
break _start
break duplicar
continue
info registers x0 x30 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `bl duplicar` cambia `pc` y guarda la direccion de retorno en `x30`.
- `ret` usa `x30` para volver a la instruccion despues del `bl`.
- El valor de retorno viaja en `x0`.

## Cambios Sugeridos

1. Cambia el valor inicial `21`.
2. Cambia `add x0, x0, x0` por `add x0, x0, #5`.
3. Observa en GDB como cambia `x30` justo despues de ejecutar `bl`.
