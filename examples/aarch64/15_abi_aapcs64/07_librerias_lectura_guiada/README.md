# 15.7 · Librerias Y Lectura Guiada

## Objetivo

Construir una libreria estatica pequena con una funcion assembly ABI-correcta y
usarla desde C.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.c` o `src/operaciones.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`operaciones.s` exporta `suma_lib`. `example.mk` crea
`src/build/liboperaciones.a` con `ar`, y GCC enlaza `main.c` contra esa libreria.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/07_librerias_lectura_guiada run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/07_librerias_lectura_guiada run
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/07_librerias_lectura_guiada nm
aarch64-linux-gnu-nm 15_abi_aapcs64/07_librerias_lectura_guiada/src/build/liboperaciones.a
```

## Salida Esperada

```text
lib = 42
```

## Que Observar

- La libreria estatica contiene un objeto relocatable.
- El ejecutable final tiene resuelto el simbolo `suma_lib`.
- El contrato ABI sigue siendo el mismo aunque la funcion venga de una libreria.

## Cambios Sugeridos

1. Agrega otra funcion a `operaciones.s`.
2. Inspecciona la libreria con `ar t`.
3. Cambia el prototipo C y observa por que el contrato debe coincidir.
