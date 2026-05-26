# 04.4 · Definicion De Datos

## Objetivo

Declarar bytes, halfwords, words y quads, y leer uno de esos datos desde codigo.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/04_definicion_datos run
```

## Salida Esperada

No imprime texto. Termina con codigo `65`, el valor ASCII de `A`.

## Que Observar

- `.byte`, `.hword`, `.word` y `.quad` reservan tamanos distintos.
- La etiqueta nombra una direccion.
- `ldrb` lee solo un byte.

## Cambios Sugeridos

1. Cambia el byte inicial.
2. Usa `ldrh` para leer `h`.
3. Inspecciona los bytes con `x/16xb datos`.
