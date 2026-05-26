# 07.8 · Lectura Guiada

## Objetivo

Leer un programa corto que combina constantes, mascara, shift, aritmetica y
bitfield.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El ejemplo construye `0x1234`, aísla su byte bajo, lo desplaza, suma un valor
pequeno y agrega un campo extraido desde el mismo registro.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/08_lectura_guiada run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/08_lectura_guiada run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x1 x2 x3 x4 x5 x0 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `107`.

## Que Observar

- Cada instruccion deja un valor intermedio que se puede explicar.
- `and` se usa como mascara.
- `ubfx` extrae un campo sin leer memoria.

## Cambios Sugeridos

1. Cambia la constante base.
2. Cambia el shift de `#1` a `#2`.
3. Calcula a mano el nuevo codigo de salida.
