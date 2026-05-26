# 17 · Debugging Con GDB, QEMU Y strace

Bloque: ABI, binarios y debugging.

Esta unidad cierra la ruta AArch64 con lectura de estado real: GDB, registros,
instrucciones, memoria, stack frames, QEMU gdbserver, syscalls con `strace` y
core dumps de forma segura.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre el `src/main.s` del ejemplo antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.
- Usa `make -f Makefile.qemu EXAMPLE=... gdb` para abrir QEMU esperando GDB.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_gdb_flujo_basico](01_gdb_flujo_basico/README.md) | 17.1 | break, continue, stepi y nexti |
| [02_registros_instrucciones](02_registros_instrucciones/README.md) | 17.2 | registros, `pc` y desensamblado |
| [03_lectura_memoria](03_lectura_memoria/README.md) | 17.3 | `.rodata`, `.data`, `.bss` y punteros |
| [04_stack_frames_gdb](04_stack_frames_gdb/README.md) | 17.4 | `sp`, `x29`, `x30` y backtrace |
| [05_qemu_gdbserver](05_qemu_gdbserver/README.md) | 17.5 | QEMU esperando GDB por puerto |
| [06_strace_syscalls](06_strace_syscalls/README.md) | 17.6 | syscalls y errores con `strace` |
| [07_core_dumps](07_core_dumps/README.md) | 17.7 | fallo opcional y post-mortem |
| [08_practica_guiada](08_practica_guiada/README.md) | 17.8 | practica integradora |

## Recorrido Sugerido

1. Empieza con el flujo minimo de GDB antes de leer memoria o stack.
2. Practica `gdb-batch` para confirmar que el binario tiene simbolos.
3. Usa `strace` solo despues de entender que syscall esperas ver.
4. El ejemplo de core dump no falla en `run`; el fallo real es opt-in.
