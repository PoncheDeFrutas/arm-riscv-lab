# 16.1 · Del .s Al .o Y Del .o Al ELF

## Objetivo

Construir un ejecutable ELF minimo desde assembly y distinguir fuente, objeto y
ejecutable.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa solo ejecuta `exit(0)`. Su valor esta en inspeccionar los archivos
que producen assembler y linker.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/01_flujo_assembly_objeto_ejecutable run
echo $?
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/01_flujo_assembly_objeto_ejecutable readelf-header
make -f Makefile.qemu EXAMPLE=16_elf_linking_loading/01_flujo_assembly_objeto_ejecutable objdump
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Que Observar

- `src/main.s` es texto fuente.
- `src/build/main.o` es relocatable.
- `src/build/main` es el ejecutable ELF.

## Cambios Sugeridos

1. Ejecuta `readelf -h` sobre `main.o` y sobre `main`.
2. Usa `objdump -d` para ver el encoding de instrucciones.
3. Cambia el codigo de salida y recompila.
