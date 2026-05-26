# 16.4 · Program Headers, Segmentos, Loader Y Permisos

## Objetivo

Distinguir secciones de segmentos y observar permisos de carga con program
headers.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa usa `.text`, `.rodata`, `.data` y `.bss`. `readelf -l` muestra como
el linker agrupa contenido en segmentos `LOAD` con permisos.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/04_segmentos_loader_permisos run
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/04_segmentos_loader_permisos readelf-programs
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/04_segmentos_loader_permisos readelf-sections
```

## Salida Esperada

```text
segmentos
```

## Que Observar

- Secciones sirven para organizar el archivo.
- Segmentos indican que carga el loader en memoria.
- Permisos como `R`, `W` y `E` pertenecen a segmentos.

## Cambios Sugeridos

1. Compara `.rodata` con el segmento donde queda cargada.
2. Agrega mas datos en `.bss` y mira `MemSiz`.
3. Usa `objdump` para ubicar instrucciones dentro del segmento ejecutable.
