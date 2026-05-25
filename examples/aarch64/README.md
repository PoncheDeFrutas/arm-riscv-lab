# Ejemplos AArch64

Esta carpeta funciona como el workspace principal para ejemplos ejecutables de
la ruta AArch64. Abre `examples/aarch64` en VS Code para usar la configuracion
compartida de depuracion.

## Estructura

```text
examples/aarch64/
|- Makefile.qemu
|- Makefile.native
|- .vscode/
|- 01_laboratorio/
|  `- 03_primer_programa/
|     |- README.md
|     `- src/
|        `- main.s
`- 05_primeros_programas/
   `- 01_programa_minimo_exit/
      `- src/
         `- main.s
```

Cada ejemplo mantiene su propio `README.md` y su fuente principal en
`src/main.s`. Los Makefiles y la configuracion de VS Code se comparten desde
esta carpeta para evitar duplicacion.

## Ejecutar con QEMU

Desde `examples/aarch64`:

```bash
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa run
make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa gdb
```

Tambien puedes pasar directamente la carpeta `src`:

```bash
make -f Makefile.qemu SRC_DIR=01_laboratorio/03_primer_programa/src run
```

## Ejecutar en ARM64 nativo

En una maquina Linux ARM64 real:

```bash
make -f Makefile.native EXAMPLE=01_laboratorio/03_primer_programa run
```

## Depurar en VS Code

1. Abre `examples/aarch64` como workspace.
2. Abre el archivo `src/main.s` del ejemplo que quieres estudiar.
3. Elige `Debug ARM64 QEMU - archivo activo` o `Debug ARM64 nativo - archivo activo`.
4. Presiona F5.

La configuracion usa `${fileDirname}`, por lo que el binario esperado siempre es
`src/build/main` relativo al archivo `main.s` que esta abierto.

## Convenciones

- Carpetas de unidad con prefijo numerico: `05_primeros_programas`.
- Carpetas de ejemplo/leccion con prefijo numerico: `01_programa_minimo_exit`.
- Entrada principal obligatoria: `src/main.s`.
- Artefactos generados solo en `src/build/`.
- Si un ejemplo necesita reglas especiales, agrega `src/example.mk` y conserva
  los Makefiles compartidos.
