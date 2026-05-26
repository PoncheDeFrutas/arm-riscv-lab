# 16.6 · GOT, PLT Y PIE

## Objetivo

Generar un binario PIE que llama a `printf` para observar senales de PLT,
relocations dinamicas y carga dependiente del loader.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.c` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El ejemplo fuerza `-fPIE -pie`. La llamada a `printf` permite buscar referencias
a PLT/GOT con `objdump` y `readelf`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/06_got_plt_pie run
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/06_got_plt_pie readelf-header
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/06_got_plt_pie readelf-dynamic
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/06_got_plt_pie objdump
```

## Salida Esperada

```text
plt pie 42
```

## Que Observar

- Un PIE suele aparecer como `Type: DYN` aunque sea ejecutable.
- `printf` no queda como instruccion unica; pasa por simbolos y stubs.
- Las direcciones finales pueden cambiar al cargar.

## Cambios Sugeridos

1. Compila con `-no-pie` y compara `readelf -h`.
2. Busca `printf` en `objdump`.
3. Revisa relocations dinamicas con `readelf -r`.
