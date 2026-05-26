# 10.1 · File Descriptors Y Recursos

## Objetivo

Entender que un file descriptor es un entero que representa un recurso abierto,
no un puntero a memoria.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa abre `entrada.txt`, guarda el fd en `x19` y lo cierra. No lee el
archivo: el foco es observar el ciclo abrir recurso, guardar fd, cerrar recurso.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=10_linux_api_kernel/01_file_descriptors run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=10_linux_api_kernel/01_file_descriptors run
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

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: salta si `openat` devolvio un error negativo. |

## Que Observar

- `x0` contiene fd si `openat` funciona.
- `x19` guarda el fd antes de llamar otras syscalls.
- `close` recibe el entero fd.

## Cambios Sugeridos

1. Cambia la ruta para provocar error.
2. Observa el fd devuelto en `x0`.
3. Intenta explicar por que `ldr x1, [x19]` seria incorrecto.
