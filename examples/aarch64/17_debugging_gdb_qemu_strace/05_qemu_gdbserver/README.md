# 17.5 · QEMU Y gdbserver

## Objetivo

Usar QEMU user mode esperando una conexion remota de GDB en un puerto.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa imprime `qemu gdbserver` y termina. El punto de la leccion es
ejecutarlo con `make gdb` para que QEMU espere en el puerto `1234`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/05_qemu_gdbserver run
```

## Depurar Con Dos Terminales

Terminal 1:

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/05_qemu_gdbserver gdb
```

Terminal 2:

```gdb
gdb-multiarch 17_debugging_gdb_qemu_strace/05_qemu_gdbserver/src/build/main
target remote :1234
break _start
continue
```

## Salida Esperada

```text
qemu gdbserver
```

## Que Observar

- QEMU ejecuta el binario AArch64.
- GDB corre en el host y se conecta por puerto.
- No uses `run` dentro de GDB remoto; el proceso ya esta bajo QEMU.

## Cambios Sugeridos

1. Cambia `PORT=1235`.
2. Usa `gdb-vscode` desde VS Code.
3. Agrega un breakpoint antes de `svc`.
