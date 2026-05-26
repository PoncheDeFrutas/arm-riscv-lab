# 07.5 · Shifts Y Rotates

## Objetivo

Comparar `lsl`, `lsr`, `asr` y `ror` sobre valores faciles de reconocer.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa desplaza `8` hacia la izquierda, luego hacia la derecha, y contrasta
eso con un desplazamiento aritmetico sobre un valor negativo. Finalmente rota un
valor y devuelve su byte bajo.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/05_shifts_rotates run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/05_shifts_rotates run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x5 x6 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `16`.

## Que Observar

- `lsl` equivale a multiplicar por potencias de dos si no hay overflow.
- `lsr` rellena con ceros.
- `asr` conserva el bit de signo.
- `ror` rota bits en vez de descartarlos.

## Cambios Sugeridos

1. Cambia el valor inicial `8`.
2. Cambia la cantidad de desplazamiento.
3. Observa `x5` en hexadecimal despues de `asr`.
