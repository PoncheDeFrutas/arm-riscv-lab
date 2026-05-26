# 04.2 · Secciones

## Objetivo

Separar codigo, datos modificables, datos de solo lectura y espacio reservado en
secciones distintas.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/02_secciones run
```

## Salida Esperada

```text
Secciones
```

## Que Observar

- `.text` contiene instrucciones.
- `.rodata` contiene el mensaje constante.
- `.data` y `.bss` existen para datos modificables o reservados.

## Cambios Sugeridos

1. Mueve el mensaje a `.data`.
2. Inspecciona secciones con `readelf -S`.
3. Observa direcciones de `contador`, `buffer` y `msg`.
