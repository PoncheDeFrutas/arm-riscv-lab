# 14.8 · Lectura Guiada De Un Buffer ADT

## Objetivo

Leer un Buffer ADT completo: descriptor, `push_byte`, `clear`, error por
capacidad e invariantes antes/despues de cada operacion.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El buffer tiene capacidad `2`. Se insertan `A` y `B`, el tercer push falla como
se espera, luego `buffer_clear` vuelve `len` a cero.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/08_lectura_guiada_buffer_adt run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/08_lectura_guiada_buffer_adt run
echo $?
```

## Depurar

```gdb
break buffer_push_byte
break buffer_clear
continue
info registers x0 x1 x2 x3 x4 pc
x/4gx &buffer_desc
x/4xb &storage
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `ne` | `b.ne error` | Not equal: una operacion que debia ser exitosa fallo. |
| `lt` | `b.lt error_esperado` | Less than signed: el tercer push retorno `-1` como se esperaba. |
| `cs` | `b.cs buffer_full` | Carry set: `len >= cap`, no hay espacio. |

## Que Observar

- El llamador recarga `x0` con `buffer_desc` antes de cada llamada.
- `push_byte` retorna `0` si inserta y `-1` si no hay capacidad.
- `clear` no borra bytes; borra la longitud logica.

## Cambios Sugeridos

1. Sube la capacidad a `3` y observa que el tercer push ya no falla.
2. Inspecciona `storage` despues de `buffer_clear`.
3. Agrega un cuarto push para probar otra vez la ruta llena.
