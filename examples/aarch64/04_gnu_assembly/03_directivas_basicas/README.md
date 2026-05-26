# 04.3 · Directivas Basicas

## Objetivo

Usar `.equ`, `.global`, `.type`, `.size` y etiquetas para comunicar informacion
al assembler y al linker.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/03_directivas_basicas run
```

## Salida Esperada

No imprime texto. Termina con codigo `7`.

## Que Observar

- `.equ` define nombres para constantes.
- `_start` es visible por `.global`.
- `.size` calcula distancia entre la posicion actual y `_start`.

## Cambios Sugeridos

1. Cambia `EXIT_CODE`.
2. Inspecciona simbolos con `readelf -s`.
3. Quita `.global _start` y observa el error de enlace.
