# 02.5 · Endianness Y Alineacion

## Objetivo

Guardar un word en memoria y leer su primer byte para observar little endian.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=02_bases_binarias/05_endianness_alineacion run
```

## Salida Esperada

No imprime texto. Termina con codigo `120`, que es `0x78`.

## Que Observar

- `0x12345678` se guarda como bytes `78 56 34 12`.
- `ldrb` lee solo el primer byte.
- La etiqueta esta alineada con `.balign 4`.

## Cambios Sugeridos

1. Cambia el word por `0xaabbccdd`.
2. Usa `ldrh` para leer dos bytes.
3. Inspecciona memoria con `x/4xb valor`.
