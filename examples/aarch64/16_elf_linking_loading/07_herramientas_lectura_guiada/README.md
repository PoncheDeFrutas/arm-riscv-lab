# 16.7 · Herramientas Y Lectura Guiada De Binarios

## Objetivo

Practicar una rutina de inspeccion: identidad, entry point, segmentos,
secciones, instrucciones, simbolos y efecto de `strip`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa imprime un mensaje y termina. El foco es ejecutar una secuencia de
herramientas sobre el mismo binario y responder una pregunta por comando.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada run
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada readelf-header
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada readelf-programs
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada readelf-sections
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada objdump
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada nm
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/07_herramientas_lectura_guiada strip-copy
```

## Salida Esperada

```text
lectura guiada
```

## Que Observar

- `readelf -h` responde que archivo es y donde empieza.
- `readelf -l` responde como se carga.
- `readelf -S` responde como se organiza para herramientas.
- `strip` puede quitar simbolos sin romper la ejecucion.

## Cambios Sugeridos

1. Ejecuta `nm` sobre `main.stripped`.
2. Ejecuta QEMU sobre `main.stripped`.
3. Compara direcciones de `objdump` con el entry point.
