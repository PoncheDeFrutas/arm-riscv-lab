# 16.2 · ELF Header Y Entry Point

## Objetivo

Inspeccionar el header ELF y conectar el entry point con la etiqueta `_start`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El ejecutable imprime un mensaje corto y sale. La inspeccion importante es
`readelf -h`, donde aparece arquitectura AArch64 y el punto de entrada.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/02_elf_header_entry_point run
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/02_elf_header_entry_point readelf-header
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/02_elf_header_entry_point nm
```

## Salida Esperada

```text
entry point
```

## Que Observar

- El header dice que el archivo es ELF64 para AArch64.
- El entry point apunta al codigo de arranque, no a `main`.
- `nm` muestra `_start` como simbolo del ejecutable minimo.

## Cambios Sugeridos

1. Compara el entry point con la direccion de `_start` en `nm`.
2. Inspecciona el objeto `.o` antes del link.
3. Cambia el mensaje y recompila.
