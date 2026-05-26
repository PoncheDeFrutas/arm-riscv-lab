# 14.3 · ADTs E Invariantes

## Objetivo

Construir un Buffer ADT pequeno con descriptor, capacidad, bytes usados y una
operacion que mantiene la invariante `used <= capacity`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El descriptor guarda puntero a datos, `len` y `cap`. `buffer_push_byte` valida
capacidad antes de escribir y solo entonces incrementa `len`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/03_adts_invariantes run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/03_adts_invariantes run
echo $?
```

## Depurar

```gdb
break buffer_push_byte
continue
info registers x0 x1 x2 x3 x4 pc
x/4gx &buffer_desc
x/8xb &storage
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `2`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `ne` | `b.ne error` | Not equal: una operacion retorno codigo distinto de cero. |
| `cs` | `b.cs buffer_full` | Carry set despues de comparar unsigned: `len >= cap`. |

## Que Observar

- El llamador no escribe directamente en `storage`.
- La funcion protege la invariante antes de modificar estado.
- `len` cambia de `0` a `2` despues de dos pushes.

## Cambios Sugeridos

1. Agrega mas llamadas a `buffer_push_byte`.
2. Baja la capacidad para activar `buffer_full`.
3. Cambia `strb` por `str` y observa por que el tamano de acceso importa.
