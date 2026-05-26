# 14.6 · Buffer, String Y Matrix

## Objetivo

Mostrar tres layouts concretos: un Buffer, un String dinamico y una Matrix con
filas, columnas y datos contiguos.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El String dinamico se llena con `OK\n`, se valida un elemento de la matriz y se
imprime el string. Si el elemento no coincide, sale por error.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/06_buffer_string_matrix run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/06_buffer_string_matrix run
echo $?
```

## Depurar

```gdb
break string_push_byte
break matrix_get
continue
info registers x0 x1 x2 x3 x4 x5 x6 pc
x/4gx &string_desc
x/4gx &matrix_desc
stepi
```

## Salida Esperada

```text
OK
```

Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `ne` | `b.ne error` | Not equal: retorno o valor validado no coincide. |
| `cs` | `b.cs string_full` | Carry set: `len >= cap` en comparacion unsigned. |

## Que Observar

- String guarda longitud explicita, no depende solo de terminador cero.
- Matrix calcula indice lineal con `row * cols + col`.
- Cada layout tiene offsets propios y no deben mezclarse.

## Cambios Sugeridos

1. Cambia el texto `OK`.
2. Consulta otro elemento de la matriz.
3. Baja la capacidad del string para disparar `string_full`.
