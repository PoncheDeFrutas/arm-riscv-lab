# 04.6 · Include Y Macros

## Objetivo

Separar constantes y una macro simple en un archivo incluido con `.include`.

## Antes De Empezar

Este ejemplo tiene dos archivos en `src/`:

```text
src/main.s
src/constantes.inc
```

El archivo `.inc` no se ejecuta solo; el assembler lo inserta cuando procesa
`.include "constantes.inc"`.

## Pasos De Estudio

1. Abre primero `src/constantes.inc` y revisa las constantes.
2. Abre `src/main.s` y ubica la linea `.include`.
3. Compila y ejecuta.
4. Desensambla el binario para ver que la macro ya fue expandida.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/06_include_macros run
```

## Salida Esperada

```text
Include
```

## Que Observar

- `.include "constantes.inc"` se resuelve durante el ensamblado.
- La macro `exit_ok` se expande en instrucciones reales.
- El Makefile agrega `-I src` para encontrar includes del ejemplo.

## Cambios Sugeridos

1. Cambia `STDOUT` temporalmente a `2`.
2. Agrega otra constante en `constantes.inc`.
3. Desensambla para ver la macro expandida.
