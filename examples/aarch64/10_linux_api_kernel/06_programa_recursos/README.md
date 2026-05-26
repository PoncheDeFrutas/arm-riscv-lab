# 10.6 · Programa Guiado Con Recursos

## Objetivo

Leer un archivo, escribir a stdout, cerrar el fd y usar `cleanup` si falla una
syscall despues de abrir.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Este ejemplo junta el flujo completo: `openat`, `read`, `write`, `close`,
`cleanup` y `error_sin_fd`. El fd vive en `x19`; la cantidad real leida vive en
`x20`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=10_linux_api_kernel/06_programa_recursos run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=10_linux_api_kernel/06_programa_recursos run
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
Contenido de recursos
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error_sin_fd` | Less than signed: error antes de tener fd o despues de intentar cerrar. |
| `lt` | `b.lt cleanup` | Less than signed: error con fd vivo; cerrar antes de salir. |

## Que Observar

- Hay dos rutas de error: con fd y sin fd.
- `write` usa la cantidad real de `read`.
- El bloque `error_sin_fd` escribe a stderr y termina con codigo `1`.

## Cambios Sugeridos

1. Cambia el contenido de `entrada.txt`.
2. Borra temporalmente `entrada.txt` para probar error.
3. Usa `strace` para verificar `openat`, `read`, `write` y `close`.
