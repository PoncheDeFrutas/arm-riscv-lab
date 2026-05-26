# 04.1 · Estructura De Archivo .s

## Objetivo

Mostrar la forma minima de un archivo GNU Assembly con simbolo global, seccion
de codigo, etiqueta de entrada y metadatos para herramientas.

## Antes De Empezar

Este es el unico ejemplo inicial que usa `.type` y `.size` a proposito. En los
demas ejemplos se omiten para no convertir esas directivas en boilerplate.

## Idea Del Programa

El programa solo termina con `exit(0)`. El objetivo no es la syscall, sino ver
como un archivo `.s` puede declarar un simbolo visible y agregar metadatos que
herramientas como `readelf`, `objdump` o GDB pueden mostrar.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/01_estructura_archivo_s run
```

## Pasos De Estudio

1. Abre `src/main.s` y ubica `.global`, `.type`, `.section`, `_start` y `.size`.
2. Compila el ejemplo.
3. Ejecuta `readelf -s src/build/main` desde la carpeta del ejemplo o ajustando
   la ruta al binario.
4. Quita temporalmente `.type` o `.size` para comparar la salida de herramientas.

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Que Observar

- `.global _start` hace visible el punto de entrada.
- `.type` y `.size` ayudan a herramientas como `readelf` y GDB, pero no son
  necesarias en todos los ejemplos.
- Solo las instrucciones dentro de `.text` se ejecutan.

## Cambios Sugeridos

1. Quita `.type` y observa `readelf -s`.
2. Cambia el codigo de salida.
3. Pon breakpoint en `_start`.
