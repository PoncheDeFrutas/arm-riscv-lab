# 15.4 · main, _start, libc Y Runtime

## Objetivo

Usar `main` con runtime de C para ver que un programa con libc no empieza
directamente en tu funcion desde el kernel.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.c` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

GCC enlaza el runtime de C. El loader entra al arranque de libc, libc llama a
`main`, `printf` escribe texto y el retorno de `main` se convierte en `exit`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/04_main_start_libc_runtime run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/04_main_start_libc_runtime run
```

## Depurar

```gdb
break main
continue
info registers x0 x1 sp pc
next
```

## Salida Esperada

```text
main con runtime C
```

## Que Observar

- No hay etiqueta `_start` escrita por nosotros.
- `printf` es una funcion de libc, no una syscall directa.
- El Makefile usa GCC porque existe `main.c`.

## Cambios Sugeridos

1. Cambia el texto impreso.
2. Cambia el retorno de `main`.
3. Usa `readelf-programs` para buscar el interpreter dinamico.
