# 09.4 · openat Y close

## Objetivo

Crear un archivo con `openat`, escribir un mensaje y cerrar el file descriptor.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`openat` devuelve un fd en `x0`. El ejemplo lo guarda en `x19`, porque `write`
tambien usa `x0` y sobrescribe el retorno. Finalmente `close` recibe el fd
guardado.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=09_syscalls_esenciales/04_openat_close run
cat 09_syscalls_esenciales/04_openat_close/salida.txt
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=09_syscalls_esenciales/04_openat_close run
cat 09_syscalls_esenciales/04_openat_close/salida.txt
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 x8 x19 pc
stepi
```

## Salida Esperada

No imprime texto. Crea `09_syscalls_esenciales/04_openat_close/salida.txt` con:

```text
Archivo creado desde openat
```

## Que Observar

- `AT_FDCWD` indica ruta relativa al directorio actual.
- `x19` conserva el fd entre syscalls.
- `close` recibe fd, no ruta ni puntero.

## Cambios Sugeridos

1. Cambia el texto escrito.
2. Quita `O_TRUNC` y observa el archivo.
3. Cambia el nombre de salida.
