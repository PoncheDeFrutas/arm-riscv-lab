# 09.6 · Programa Guiado

## Objetivo

Unir `openat`, `write`, `close`, `exit` y manejo minimo de error en un archivo
completo.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa crea `salida_guiada.txt`, escribe un mensaje, cierra el fd guardado
en `x19` y revisa retornos negativos con `b.lt`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=09_syscalls_esenciales/06_programa_guiado run
cat 09_syscalls_esenciales/06_programa_guiado/salida_guiada.txt
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=09_syscalls_esenciales/06_programa_guiado run
cat 09_syscalls_esenciales/06_programa_guiado/salida_guiada.txt
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x3 x8 x19 pc
stepi
```

## Salida Esperada

Crea `09_syscalls_esenciales/06_programa_guiado/salida_guiada.txt` con:

```text
Creado con syscalls AArch64
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: salta si el retorno de syscall es negativo. |

## Que Observar

- `x19` conserva el fd entre `openat`, `write` y `close`.
- Cada syscall importante revisa si `x0 < 0`.
- El bloque `error` escribe a stderr con fd `2`.

## Cambios Sugeridos

1. Quita `O_CREAT` y borra el archivo para provocar error.
2. Cambia el mensaje escrito al archivo.
3. Observa con `strace` el orden de syscalls.
