# 08.6 · Branch Link Register

## Objetivo

Introducir `bl`, `ret` y `x30/lr` con una funcion hoja simple.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`bl funcion_simple` salta a una etiqueta y guarda la direccion de retorno en
`x30`. La funcion coloca `41` en `x0` y usa `ret` para volver. `_start` suma uno
y termina con `42`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=08_control_flujo/06_branch_link_register run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=08_control_flujo/06_branch_link_register run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x30 pc
x/8i $pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `bl` guarda retorno en `x30`.
- `ret` vuelve a la direccion guardada.
- No hay stack frame todavia; eso queda para la unidad 11.

## Cambios Sugeridos

1. Cambia el valor que retorna la funcion.
2. Agrega una segunda llamada a la funcion.
3. Observa `x30` justo despues de ejecutar `bl`.
