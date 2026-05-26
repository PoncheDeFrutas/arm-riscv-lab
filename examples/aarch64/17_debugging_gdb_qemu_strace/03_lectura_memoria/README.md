# 17.3 · Lectura De Memoria

## Objetivo

Inspeccionar `.rodata`, `.data`, `.bss`, strings y punteros con GDB.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa tiene un string, un valor inicializado y un buffer `.bss`. Copia un
byte al buffer y termina con `42`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/03_lectura_memoria run
echo $?
```

## Depurar

```gdb
break _start
continue
x/s &mensaje
x/gx &valor
x/16xb &buffer
info registers x0 x1 x2 x3 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `.rodata` contiene bytes de solo lectura.
- `.data` contiene datos inicializados.
- `.bss` inicia en cero y cambia cuando el programa escribe.

## Cambios Sugeridos

1. Cambia `.asciz` por `.ascii` y observa `x/s`.
2. Escribe mas bytes en `buffer`.
3. Usa `x/8gx` y `x/16xb` sobre la misma direccion.
