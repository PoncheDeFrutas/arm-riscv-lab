# 17.6 · strace Y Syscalls

## Objetivo

Observar syscalls, argumentos, retornos y una ruta de error con `strace`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa abre `entrada.txt`, lee una parte, la escribe en stdout, cierra el
fd y luego intenta abrir un archivo inexistente para producir un error esperado.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/06_strace_syscalls run
echo $?
```

## Ver Syscalls

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/06_strace_syscalls strace
```

## Salida Esperada

```text
strace visible
```

Termina con codigo `0` porque el segundo `openat` falla como se esperaba.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: una syscall fallo antes de lo esperado. |
| `lt` | `b.lt error_esperado` | Less than signed: el archivo inexistente produjo el error buscado. |

## Que Observar

- `openat`, `read`, `write` y `close` deben aparecer en la traza de QEMU.
- Un retorno negativo esperado tambien se valida.
- No todo error implica que el programa falle; depende de la hipotesis.

## Cambios Sugeridos

1. Borra temporalmente `entrada.txt`.
2. Cambia la cantidad leida.
3. Agrega otro `write` a stderr y observa fd `2`.
