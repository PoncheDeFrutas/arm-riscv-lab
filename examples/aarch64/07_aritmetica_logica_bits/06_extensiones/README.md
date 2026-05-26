# 07.6 · Extensiones

## Objetivo

Mostrar la diferencia entre extender un byte como unsigned y como signed.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El byte `0xff` puede significar `255` si se extiende con ceros o `-1` si se
extiende con signo. El programa deja ambas interpretaciones en registros.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/06_extensiones run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/06_extensiones run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers w1 w2 w3 w0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `254`.

## Que Observar

- `uxtb` rellena con ceros.
- `sxtb` replica el bit de signo.
- El byte original no cambia; cambia la interpretacion al extenderlo.

## Cambios Sugeridos

1. Cambia `0xff` por `0x7f`.
2. Prueba `uxth` y `sxth` con un valor de 16 bits.
3. Observa los registros en hexadecimal.
