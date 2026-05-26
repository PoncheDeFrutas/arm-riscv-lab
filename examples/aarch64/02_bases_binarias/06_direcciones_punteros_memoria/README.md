# 02.6 · Direcciones, Punteros Y Memoria

## Objetivo

Usar una direccion como valor: cargar la direccion de una etiqueta y luego leer
el contenido apuntado.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=02_bases_binarias/06_direcciones_punteros_memoria run
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `x1` contiene una direccion.
- `[x1]` significa leer memoria en esa direccion.
- El dato y su direccion son conceptos distintos.

## Cambios Sugeridos

1. Cambia el valor almacenado.
2. Observa `x1` y `x/1dw $x1` en GDB.
3. Cambia `ldr` por `ldrb` y compara.
