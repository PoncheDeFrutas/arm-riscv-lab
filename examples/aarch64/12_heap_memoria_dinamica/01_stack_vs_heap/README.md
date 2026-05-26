# 12.1 · Stack Vs Heap

## Objetivo

Comparar un dato temporal en stack con un dato que vive en un bloque simulado de
heap en `.bss`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`crear_dato_stack` usa un local temporal y devuelve solo el valor. Luego
`crear_dato_heap_simulado` guarda otro valor en un bloque `.bss`, que sigue
existiendo despues de retornar.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=12_heap_memoria_dinamica/01_stack_vs_heap run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=12_heap_memoria_dinamica/01_stack_vs_heap run
echo $?
```

## Depurar

```gdb
break crear_dato_stack
break crear_dato_heap_simulado
continue
info registers x0 x1 x2 x3 sp pc
x/gx &heap_buffer
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- El dato del stack se usa antes de restaurar `sp`.
- El bloque `.bss` conserva su contenido aunque la funcion ya haya retornado.
- El ejemplo no devuelve punteros al stack; eso seria una vida util invalida.

## Cambios Sugeridos

1. Cambia el valor temporal `2`.
2. Cambia el valor persistente `40`.
3. Inspecciona `heap_buffer` antes y despues de llamar a la funcion simulada.
