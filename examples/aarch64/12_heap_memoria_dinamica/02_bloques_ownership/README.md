# 12.2 · Bloques Y Ownership

## Objetivo

Representar un bloque simulado con puntero, capacidad, bytes usados y una bandera
de ownership.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa toma ownership del bloque, escribe dos bytes (`A` y `B`) y actualiza
el contador de bytes usados. El codigo de salida es la cantidad usada.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=12_heap_memoria_dinamica/02_bloques_ownership run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=12_heap_memoria_dinamica/02_bloques_ownership run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x5 x6 x7 x0 pc
x/8xb &heap_block
x/gx &block_used
x/gx &block_owner
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `2`.

## Que Observar

- Puntero, capacidad y bytes usados no son lo mismo.
- Tener una direccion no significa tener ownership.
- El contador `block_used` describe cuanto del bloque esta ocupado.

## Cambios Sugeridos

1. Escribe un tercer byte y actualiza `block_used`.
2. Cambia `block_capacity` y revisa que parte es metadata.
3. Cambia `block_owner` a `0` y piensa que operacion deberia impedirse.
