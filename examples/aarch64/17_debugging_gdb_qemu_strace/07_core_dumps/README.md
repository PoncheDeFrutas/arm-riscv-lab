# 17.7 · Core Dumps

## Objetivo

Preparar un programa seguro por defecto y un binario opcional de fallo para
practicar diagnostico post-mortem con GDB.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`main.s` termina correctamente. `fault.s` es opt-in: escribe en direccion cero
para producir un fallo cuando ejecutes `run-fault`.

## Ejecutar Seguro

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/07_core_dumps run
echo $?
```

## Construir Binario De Fallo

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/07_core_dumps fault
```

## Ejecutar Fallo Opcional

```bash
ulimit -c unlimited
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/07_core_dumps run-fault
```

## Salida Esperada

`run` termina con codigo `0`. `run-fault` puede terminar con una senal; eso es
esperado y no forma parte de la prueba normal.

## Que Observar

- Un core dump depende de configuracion del sistema.
- GDB post-mortem no ejecuta; solo lee estado final.
- El binario que abres en GDB debe coincidir con el que produjo el fallo.

## Cambios Sugeridos

1. Abre el core con `gdb-multiarch src/build/fault core`.
2. Ejecuta `bt`, `info registers` y `x/i $pc`.
3. Cambia la direccion invalida para ver otro tipo de fallo.
