# 02.4 · Bytes Y Texto

## Objetivo

Mostrar que un texto ASCII es una secuencia de bytes que `write` envia a
`stdout`.

## Ejecutar

```bash
make -f Makefile.qemu EXAMPLE=02_bases_binarias/04_bytes_texto run
```

## Salida Esperada

```text
ABC
```

## Que Observar

- Cada caracter ASCII ocupa un byte.
- `texto_len` se calcula con la posicion actual menos la etiqueta.
- `write` no necesita terminador NULL.

## Cambios Sugeridos

1. Cambia `ABC` por otro texto corto.
2. Agrega bytes con `.byte`.
3. Observa los bytes con `x/8xb texto` en GDB.
