# 17.1 · Flujo Basico De GDB

## Objetivo

Practicar `break`, `continue`, `stepi` y `nexti` sobre un programa pequeno.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa carga `20`, suma `22` y termina con `42`. Es intencionalmente simple
para que cada instruccion tenga un cambio facil de predecir.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/01_gdb_flujo_basico run
echo $?
```

## Depurar

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/01_gdb_flujo_basico gdb
```

En otra terminal:

```gdb
gdb-multiarch src/build/main
target remote :1234
break _start
continue
x/i $pc
info registers x0 x1 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- Antes de `stepi`, predice que registro cambiara.
- `pc` avanza despues de cada instruccion.
- `nexti` y `stepi` se comportan igual mientras no haya llamada.

## Cambios Sugeridos

1. Cambia los valores `20` y `22`.
2. Agrega una funcion y compara `stepi` contra `nexti`.
3. Usa el target `gdb-batch` para ver simbolos sin abrir una sesion interactiva.
