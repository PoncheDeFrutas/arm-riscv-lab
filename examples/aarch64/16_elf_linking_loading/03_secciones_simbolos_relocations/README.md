# 16.3 · Secciones, Simbolos Y Relocations

## Objetivo

Crear un binario con `.text`, `.rodata`, `.data` y `.bss` para inspeccionar
secciones, simbolos y relocations en el objeto.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa carga un valor desde `.data`, escribe un byte en `.bss`, lee una
constante y termina con `42`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/03_secciones_simbolos_relocations run
echo $?
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/03_secciones_simbolos_relocations readelf-sections
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/03_secciones_simbolos_relocations nm
aarch64-linux-gnu-readelf -r 16_elf_linking_loading/03_secciones_simbolos_relocations/src/build/main.o
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- Las secciones ordenan contenido para herramientas y linker.
- `nm` muestra nombres como `_start`, `valor` y `scratch`.
- El objeto `.o` puede contener relocations pendientes antes del link.

## Cambios Sugeridos

1. Agrega otro simbolo en `.data`.
2. Inspecciona `readelf -r` en el objeto y en el ejecutable.
3. Cambia `adr` por otra forma de cargar direcciones.
