# Ejecutar Ejemplos

## Flujo de ejecución

Cuando los ejemplos ejecutables estén disponibles, el flujo recomendado será:

```bash
cd examples/aarch64
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa run
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa gdb
```

Cada ejemplo AArch64 debe tener `README.md` y `src/main.s`. Los Makefiles y la
configuración de VS Code se comparten desde `examples/aarch64`.

Para ARM64 nativo:

```bash
cd examples/aarch64
make -f Makefile.native EXAMPLE=01_laboratorio/03_primer_programa run
```

Las plantillas de `tooling/make/makefile-templates/` quedan para proyectos
aislados o prácticas que necesiten una estructura propia.

## Qué debe incluir cada ejemplo

Cada ejemplo en `examples/aarch64` o `projects/` deberá indicar:

- Qué hace el programa
- Cómo compilarlo
- Cómo ejecutarlo
- Qué salida esperar
- Qué observar con herramientas como GDB, `objdump`, `readelf` o `strace`

## Flujo de estudio recomendado

1. **Leer**: entender la idea principal en la unidad
2. **Ejecutar**: correr el ejemplo cuando exista
3. **Inspeccionar**: usar `objdump`, `readelf`, `strace` o GDB según la lección
4. **Modificar**: cambiar registros, valores o mensajes
5. **Depurar**: observar registros y memoria paso a paso
6. **Explicar**: describir qué hace el programa
7. **Practicar**: resolver ejercicios cuando existan
