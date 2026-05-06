# Lección 00 - Hello mínimo ARM64

## Objetivo

Compilar y ejecutar un programa AArch64 mínimo en Linux. El programa imprime un
mensaje con `write` y termina con `exit`.

## Prerrequisitos

- Ruta elegida: Raspberry Pi ARM64 o x86_64 con QEMU user mode.
- Toolchain instalado según la Unidad 01.
- `make` disponible.

## Archivos

```bash
00-hello-minimo/
|- .vscode/
|  |- launch.json
|  `- settings.json
|- README.md
`- src/
   |- Makefile
   |- Makefile.arm64
   `- main.s
```

| Archivo | Rol |
|---|---|
| `src/main.s` | Fuente AArch64 mínimo |
| `src/Makefile` | Flujo x86_64 con QEMU user mode |
| `src/Makefile.arm64` | Flujo Raspberry Pi / ARM64 nativo |
| `src/build/main` | Binario generado |

## Flujo x86_64 con QEMU

```bash
make -C src
make -C src run
make -C src gdb
```

## Flujo Raspberry Pi ARM64

```bash
make -C src -f Makefile.arm64
make -C src -f Makefile.arm64 run
make -C src -f Makefile.arm64 gdb
```

## Salida esperada

```bash
Hola ARM64
```

## Inspección rápida

```bash
file src/build/main
aarch64-linux-gnu-objdump -d src/build/main
aarch64-linux-gnu-nm src/build/main
```

En Raspberry Pi puedes usar `objdump` y `nm` sin prefijo si están instalados.

## Checklist

- [ ] `make -C src` genera `src/build/main`.
- [ ] `make -C src run` imprime `Hola ARM64`.
- [ ] `file src/build/main` identifica AArch64.
- [ ] Puedo iniciar `make -C src gdb` según mi ruta.

## Ejercicios cortos

1. Cambia el mensaje impreso.
2. Agrega una segunda línea con otra syscall `write`.
3. Cambia el código de salida de `0` a `7` y verifícalo con `echo $?`.
