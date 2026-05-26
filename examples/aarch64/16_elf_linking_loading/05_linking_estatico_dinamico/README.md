# 16.5 · Linking Estatico, Dinamico Y Dynamic Loader

## Objetivo

Crear un binario dinamico con libc y observar interpreter, dynamic section y
dependencias.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.c` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

GCC enlaza contra libc. El ejecutable usa `puts`, por lo que tiene interpreter,
dynamic section y dependencia `NEEDED` de libc.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/05_linking_estatico_dinamico run
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/05_linking_estatico_dinamico readelf-programs
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/05_linking_estatico_dinamico readelf-dynamic
```

## Salida Esperada

```text
link dinamico
```

## Que Observar

- `INTERP` indica el dynamic loader.
- `NEEDED` indica dependencias dinamicas.
- En host cruzado, `readelf -d` es mas confiable que `ldd`.

## Cambios Sugeridos

1. Inspecciona el binario con `objdump`.
2. Cambia `puts` por `printf`.
3. Prueba `LDFLAGS=-static` y compara el resultado.
