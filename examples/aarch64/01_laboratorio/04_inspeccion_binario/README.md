# 01.4 · Inspeccion Basica Del Binario

## Objetivo

Generar un binario pequeno para inspeccionarlo con `file`, `readelf`, `objdump`
y `nm`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=01_laboratorio/04_inspeccion_binario
file 01_laboratorio/04_inspeccion_binario/src/build/main
```

## Salida Esperada

El programa imprime:

```text
Inspeccion
```

## Que Observar

- `file` debe identificar un ELF AArch64.
- `nm` debe mostrar `_start`.
- `objdump -d` debe mostrar instrucciones A64.

## Cambios Sugeridos

1. Ejecuta `readelf -h src/build/main`.
2. Ejecuta `readelf -S src/build/main`.
3. Cambia el mensaje y recompila.
