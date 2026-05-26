# 12.3 · Allocation Y Deallocation

## Objetivo

Simular reserva y liberacion de un bloque, incluyendo puntero, capacidad,
ownership y limpieza de estado.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`reservar_bloque` marca el bloque como ocupado y retorna un puntero. Despues de
usar el bloque, `liberar_bloque` borra ownership, puntero y capacidad.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=12_heap_memoria_dinamica/03_allocation_deallocation run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=12_heap_memoria_dinamica/03_allocation_deallocation run
echo $?
```

## Depurar

```gdb
break reservar_bloque
break liberar_bloque
continue
info registers x0 x1 x2 x3 x4 x5 x19 pc
x/gx &block_state
x/gx &block_ptr
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cbz` | `cbz x0, error_reserva` | Salta si la reserva simulada retorno puntero cero. |
| `cbnz` | `cbnz x2, reserva_falla` | Salta si el bloque ya estaba ocupado. |
| `cbz` | `cbz x2, liberar_falla` | Salta si se intenta liberar un bloque sin owner. |
| `ne` | `b.ne error_liberar` | Not equal: salta si el retorno de liberar no fue `0`. |

## Que Observar

- Reservar no es solo recibir un puntero; tambien cambia ownership.
- Liberar limpia la metadata para no dejar punteros obsoletos.
- Las rutas de error tienen codigos distintos para ubicarlas rapido.

## Cambios Sugeridos

1. Llama dos veces a `reservar_bloque` sin liberar entre llamadas.
2. Llama a `liberar_bloque` dos veces y observa el codigo de error.
3. Inspecciona `block_ptr` antes y despues de liberar.
