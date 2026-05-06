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
   `- main.s
```

| Archivo | Rol |
|---|---|
| `src/main.s` | Fuente AArch64 mínimo |
| `src/Makefile` | Makefile activo según tu entorno |
| `src/build/main` | Binario generado |

## Flujo x86_64 con QEMU

```bash
cd src
make
make run
make gdb
```

## Flujo Raspberry Pi ARM64

Primero copia el template ARM64 como `src/Makefile`. Luego usa los mismos
comandos:

```bash
cd src
make
make run
make gdb
```

## Salida esperada

```bash
Hola ARM64
```

## Inspección rápida

```bash
file build/main
aarch64-linux-gnu-objdump -d build/main
aarch64-linux-gnu-nm build/main
```

En Raspberry Pi puedes usar `objdump` y `nm` sin prefijo si están instalados.

## Checklist

- [ ] `make` genera `build/main`.
- [ ] `make run` imprime `Hola ARM64`.
- [ ] `file build/main` identifica AArch64.
- [ ] Puedo iniciar `make gdb` según mi ruta.

## Ejercicios cortos

1. Cambia el mensaje impreso.
2. Agrega una segunda línea con otra syscall `write`.
3. Cambia el código de salida de `0` a `7` y verifícalo con `echo $?`.
