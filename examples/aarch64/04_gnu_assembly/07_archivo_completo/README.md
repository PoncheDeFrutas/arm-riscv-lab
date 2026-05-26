# 04.7 · Archivo Completo

## Objetivo

Leer un archivo `.s` completo que combina constantes, secciones, etiquetas,
datos, instrucciones y syscalls.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/07_archivo_completo run
```

## Salida Esperada

```text
Hola GNU Assembly
```

## Que Observar

- Constantes al inicio con `.equ`.
- Codigo en `.text` y texto en `.rodata`.
- La longitud se calcula con `. - msg`.

## Cambios Sugeridos

1. Cambia el mensaje.
2. Cambia `STDOUT` por `2`.
3. Clasifica cada linea como directiva, etiqueta, dato o instruccion.
