# 10.4 · Posicion Y Metadatos

## Objetivo

Usar `fstat` para pedir metadatos y `lseek` para cambiar la posicion de lectura
de un fd.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El archivo contiene `ABCDEZ`. El programa abre el archivo, ejecuta `fstat`,
mueve la posicion al byte `5` con `lseek`, lee un byte y sale con el codigo ASCII
de `Z`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=10_linux_api_kernel/04_posicion_metadatos run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=10_linux_api_kernel/04_posicion_metadatos run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 x19 x21 pc
x/16xb &bytebuf
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `90`, que corresponde a `Z`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_fd` | Less than signed: error antes de tener fd abierto. |
| `lt` | `b.lt cleanup` | Less than signed: error con fd vivo; se debe cerrar antes de salir. |

## Que Observar

- `fstat` escribe metadatos en `statbuf`.
- `lseek` retorna la nueva posicion, no simplemente `0`.
- Despues de `close`, el programa usa `x21` para conservar el byte leido.

## Cambios Sugeridos

1. Cambia el offset de `lseek`.
2. Cambia el contenido de `entrada.txt`.
3. Inspecciona `statbuf` despues de `fstat`.
