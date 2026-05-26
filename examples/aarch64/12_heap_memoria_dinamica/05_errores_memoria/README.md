# 12.5 · Errores De Memoria

## Objetivo

Simular errores clasicos de memoria dinamica de forma segura: double free y
use-after-free.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa reserva un bloque simulado, lo libera correctamente, intenta
liberarlo otra vez y despues intenta usarlo. En lugar de corromper memoria, las
funciones retornan codigos de error.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=12_heap_memoria_dinamica/05_errores_memoria run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=12_heap_memoria_dinamica/05_errores_memoria run
echo $?
```

## Depurar

```gdb
break reservar
break liberar
break usar_bloque
continue
info registers x0 x1 x2 x19 pc
x/gx &owner_flag
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `6`.

El codigo `6` viene de combinar `2` por use-after-free y `4` por double free.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cbz` | `cbz x2, double_free` | Salta si no habia owner al intentar liberar. |
| `cbz` | `cbz x2, use_after_free` | Salta si se intenta usar un bloque ya liberado. |

## Que Observar

- Un puntero puede seguir teniendo una direccion aunque el ownership ya no sea valido.
- Double free es liberar un bloque que ya no pertenece al programa.
- Use-after-free es usar un bloque despues de perder ownership.

## Cambios Sugeridos

1. Elimina la segunda llamada a `liberar` y observa el codigo final.
2. Mueve `usar_bloque` antes de liberar y observa que ya no falla.
3. Revisa en GDB como cambia `owner_flag`.
