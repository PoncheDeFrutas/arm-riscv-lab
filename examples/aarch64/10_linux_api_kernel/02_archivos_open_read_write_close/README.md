# 10.2 · Archivos Con openat, read, write Y close

## Objetivo

Abrir un archivo local, leer bytes reales, escribirlos a stdout y cerrar el fd.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El ejemplo abre `entrada.txt`, lee hasta 128 bytes hacia `.bss`, guarda la
cantidad real en `x20`, escribe exactamente esa cantidad a stdout y cierra el fd.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=10_linux_api_kernel/02_archivos_open_read_write_close run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=10_linux_api_kernel/02_archivos_open_read_write_close run
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 x19 x20 pc
x/32xb &buffer
stepi
```

## Salida Esperada

```text
Contenido de unidad 10.2
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_fd` | Less than signed: error antes de tener fd abierto. |
| `lt` | `b.lt cleanup` | Less than signed: error despues de abrir, por lo que primero se cierra el fd. |

## Que Observar

- `read` puede devolver menos que el maximo pedido.
- `write` usa `x20`, la cantidad real leida.
- `cleanup` cierra el fd si falla una syscall posterior a `openat`.

## Cambios Sugeridos

1. Cambia el contenido de `entrada.txt`.
2. Reduce el maximo de lectura.
3. Borra temporalmente `entrada.txt` para probar `error_sin_fd`.
