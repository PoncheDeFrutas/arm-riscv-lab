# 10.3 · Errores Y cleanup

## Objetivo

Practicar rutas separadas de error: una antes de tener fd y otra cuando hay que
cerrar un recurso ya abierto.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa abre un archivo valido, luego provoca un error de `read` usando un
buffer `NULL`. Como ya existe un fd en `x19`, salta a `cleanup`, cierra el fd,
escribe un mensaje a stderr y sale con codigo `1`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=10_linux_api_kernel/03_errores_cleanup
qemu-aarch64 10_linux_api_kernel/03_errores_cleanup/src/build/main
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=10_linux_api_kernel/03_errores_cleanup
10_linux_api_kernel/03_errores_cleanup/src/build/main
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 x19 pc
stepi
```

## Salida Esperada

Escribe en stderr:

```text
Error con cleanup
```

Termina con codigo `1`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_fd` | Less than signed: `openat` fallo y no hay fd que cerrar. |
| `lt` | `b.lt cleanup` | Less than signed: `read` fallo despues de abrir, entonces hay que cerrar fd. |

## Que Observar

- `cleanup` solo se usa cuando `x19` contiene un fd valido.
- El bloque de error escribe a stderr con fd `2`.
- El valor negativo de `read` no se convierte a `errno` todavia.

## Cambios Sugeridos

1. Cambia el buffer `NULL` por `buffer` y agrega una seccion `.bss`.
2. Borra `entrada.txt` y observa que no se ejecuta `cleanup`.
3. Agrega `strace` para ver `openat`, `read`, `close` y `write`.
