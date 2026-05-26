# Ejemplos AArch64

Workspace principal de ejemplos ejecutables para la ruta AArch64. Abre esta
carpeta en VS Code para usar la configuracion compartida de depuracion.

## Flujo rapido

```bash
cd examples/aarch64
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa run
```

En ARM64 nativo:

```bash
make -f Makefile.native EXAMPLE=01_laboratorio/03_primer_programa run
```

Para depurar, abre el `src/main.s` del ejemplo y usa `Debug ARM64 QEMU - archivo
activo` o `Debug ARM64 nativo - archivo activo`.

## Unidades

| Unidad | Bloque | Estado | Ejemplos |
|---|---|---|---:|
| [01 · Laboratorio](01_laboratorio/README.md) | Fundamentos | implementado | 3 |
| [02 · Bases binarias](02_bases_binarias/README.md) | Fundamentos | implementado | 6 |
| [03 · Modelo AArch64](03_modelo_aarch64/README.md) | Fundamentos | implementado | 4 |
| [04 · GNU Assembly](04_gnu_assembly/README.md) | Fundamentos | implementado | 7 |
| [05 · Primeros programas](05_primeros_programas/README.md) | Programas Linux | implementado | 5 |
| [06 · Memoria y direccionamiento](06_memoria_direccionamiento/README.md) | Programas Linux | implementado | 6 |
| [07 · Aritmetica, logica y bits](07_aritmetica_logica_bits/README.md) | Programas Linux | implementado | 8 |
| [08 · Control de flujo](08_control_flujo/README.md) | Programas Linux | implementado | 6 |
| [09 · Syscalls esenciales](09_syscalls_esenciales/README.md) | Programas Linux | implementado | 6 |
| [10 · Linux API kernel](10_linux_api_kernel/README.md) | Programas Linux | implementado | 6 |
| [11 · Stack y funciones](11_stack_funciones_frames/README.md) | Memoria y estructuras | implementado | 6 |
| [12 · Heap y memoria dinamica](12_heap_memoria_dinamica/README.md) | Memoria y estructuras | implementado | 6 |
| [13 · mmap y permisos](13_mmap_paginas_permisos/README.md) | Memoria y estructuras | implementado | 7 |
| [14 · Layout de datos y structs](14_layout_datos_structs/README.md) | Memoria y estructuras | implementado | 8 |
| [15 · ABI y C](15_abi_aapcs64/README.md) | ABI, binarios y debugging | implementado | 7 |
| [16 · ELF, linking y loading](16_elf_linking_loading/README.md) | ABI, binarios y debugging | implementado | 7 |
| [17 · Debugging](17_debugging_gdb_qemu_strace/README.md) | ABI, binarios y debugging | implementado | 8 |

## Convenciones

- Las carpetas principales son unidades numeradas: `01_laboratorio`, `02_bases_binarias`, etc.
- Cada ejemplo tiene `README.md` y `src/main.s`.
- Los artefactos generados viven en `src/build/`.
- Si un ejemplo necesita reglas especiales, puede agregar `src/example.mk`.
- Los bloques pedagogicos aparecen en tablas y README, no como carpetas.
- Los comentarios de `src/main.s` son parte obligatoria del material; revisa
  [COMMENTING_GUIDE.md](COMMENTING_GUIDE.md).
