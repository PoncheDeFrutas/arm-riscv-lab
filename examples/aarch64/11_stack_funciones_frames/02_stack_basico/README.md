# 11.2 · Stack Basico

## Objetivo

Reservar espacio en el stack, guardar valores temporales, leerlos de vuelta y
restaurar `sp`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa baja `sp` 16 bytes, guarda dos valores dentro de ese espacio y luego
recupera uno para usarlo como codigo de salida. Al final restaura `sp` antes de
salir.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=11_stack_funciones_frames/02_stack_basico run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=11_stack_funciones_frames/02_stack_basico run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers sp x1 x2 x3 x0 pc
x/4gx $sp
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `33`.

## Que Observar

- El stack crece hacia direcciones menores cuando se resta a `sp`.
- Se reserva un bloque de 16 bytes para mantener la alineacion esperada.
- Si no se restaura `sp`, las siguientes operaciones que dependan del stack
  leeran desde una direccion incorrecta.

## Cambios Sugeridos

1. Cambia el valor `33` por otro codigo de salida.
2. Cambia el offset `[sp, #8]` y revisa que valor recuperas.
3. Usa `x/4gx $sp` antes y despues de los `str`.
