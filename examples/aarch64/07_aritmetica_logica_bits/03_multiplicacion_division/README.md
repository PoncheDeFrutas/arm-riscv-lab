# 07.3 · Multiplicacion Y Division

## Objetivo

Usar `mul`, `udiv` y `msub` para calcular producto, cociente y residuo.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa calcula `37 * 5`, divide el producto entre `5` y usa `msub` para
comprobar que el residuo es `0`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=07_aritmetica_logica_bits/03_multiplicacion_division run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=07_aritmetica_logica_bits/03_multiplicacion_division run
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

No imprime texto. Termina con codigo `37`.

## Que Observar

- `mul` produce el producto.
- `udiv` produce el cociente entero sin signo.
- `msub` permite calcular `dividendo - cociente * divisor`.

## Cambios Sugeridos

1. Cambia `37` por `38` y observa el residuo.
2. Cambia el divisor.
3. Compara `msub` con una secuencia `mul` + `sub`.
