# 05.3 · stdout, stderr Y Codigos De Salida

## Objetivo

Distinguir entre file descriptor de `write` y codigo de salida de `exit`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=05_primeros_programas/03_stdout_stderr_exit_codes run
echo $?
```

## Salida Esperada

El mensaje se escribe en `stderr` y el proceso termina con codigo `2`.

## Que Observar

- En `write`, `x0 = 2` significa `stderr`.
- En `exit`, `x0 = 2` significa codigo de salida.
- El significado de `x0` depende de `x8`.

## Cambios Sugeridos

1. Cambia `x0` del `write` a `1`.
2. Cambia el codigo final de salida.
3. Redirige stderr con `2>/tmp/error.txt`.
