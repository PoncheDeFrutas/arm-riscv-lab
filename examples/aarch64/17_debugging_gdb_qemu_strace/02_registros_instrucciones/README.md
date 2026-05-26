# 17.2 · Registros E Instrucciones

## Objetivo

Leer registros, `pc`, instruccion actual y desensamblado mientras el programa
prepara un resultado.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa mueve constantes, aplica un shift y una suma. Sirve para comparar
lo que escribiste con lo que `objdump` y GDB muestran.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/02_registros_instrucciones run
echo $?
```

## Inspeccionar

```bash
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/02_registros_instrucciones objdump
make -f Makefile.qemu EXAMPLE=17_debugging_gdb_qemu_strace/02_registros_instrucciones gdb-batch
```

## Depurar

```gdb
break _start
continue
x/i $pc
info registers x0 x1 x2 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `pc` apunta a la instruccion actual, no a la anterior.
- `objdump` muestra direccion, encoding e instruccion.
- Los registros solo cambian cuando ejecutas la instruccion que los escribe.

## Cambios Sugeridos

1. Cambia el desplazamiento `lsl`.
2. Desensambla solo `_start`.
3. Repite la lectura mirando `x/i $pc` antes de cada `stepi`.
