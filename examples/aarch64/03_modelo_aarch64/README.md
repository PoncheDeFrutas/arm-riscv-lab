# 03 · Modelo ARMv8-A / AArch64

Bloque: Fundamentos.

Ejemplos para leer registros generales, registros especiales, flags y estado
del procesador desde GDB.

## Ejemplos

| Ejemplo | Leccion | Estado |
|---|---|---|
| `01_registros_generales` | 03.1 · Registros generales | implementado |
| `02_registros_especiales` | 03.2 · Registros especiales | implementado |
| `03_flags_nzcv` | 03.3 · PSTATE y flags | implementado |
| `06_lectura_registros_gdb` | 03.6 · Lectura de registros con GDB | implementado |

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=03_modelo_aarch64/01_registros_generales run
```
