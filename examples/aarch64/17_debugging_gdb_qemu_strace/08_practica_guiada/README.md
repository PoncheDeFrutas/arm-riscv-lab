# 17.8 · Practica Guiada De Depuracion

## Objetivo

Integrar lectura de registros, memoria, stack, syscalls y diagnostico breve en
un solo programa.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa llama funciones con frames, escribe un mensaje en `.bss`, imprime
ese mensaje con `write` y termina con `0`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/08_practica_guiada run
```

## Depurar

```gdb
break preparar_mensaje
break escribir_stdout
continue
info registers x0 x1 x2 sp x29 x30 pc
x/16xb &buffer
bt
```

## Ver Syscalls

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/08_practica_guiada strace
```

## Salida Esperada

```text
debug guiado
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: `write` retorno error negativo. |

## Que Observar

- `preparar_mensaje` modifica memoria en `.bss`.
- `escribir_stdout` usa registros de syscall antes de `svc #0`.
- Los frames permiten usar `bt` durante la ejecucion.

## Cambios Sugeridos

1. Cambia el mensaje byte por byte.
2. Fuerza `fd = 2` para escribir en stderr.
3. Usa `strace` y compara argumentos con los registros antes de `svc`.
