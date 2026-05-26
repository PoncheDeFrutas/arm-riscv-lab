# 04.5 · Pseudo-Instrucciones

## Objetivo

Usar `ldr xN, =valor` para cargar una constante grande que no cabe como
inmediato simple.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=04_gnu_assembly/05_pseudo_instrucciones run
```

## Salida Esperada

No imprime texto. Termina con codigo `240`, el byte bajo de la constante.

## Que Observar

- `ldr x0, =...` puede generar un literal cercano.
- El valor completo queda en `x0` antes de salir.
- El shell solo conserva el byte bajo del codigo de salida.

## Cambios Sugeridos

1. Desensambla con `objdump -d`.
2. Cambia la constante.
3. Compara con `movz`/`movk`.
