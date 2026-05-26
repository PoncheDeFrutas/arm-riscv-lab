# 12.4 · Buffer Dinamico

## Objetivo

Simular un buffer dinamico con capacidad fija, contador de bytes usados y una
funcion `push_byte` que valida espacio antes de escribir.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa agrega `A`, `B`, `C` y salto de linea al buffer simulado. Luego usa
`write` para imprimir exactamente la cantidad de bytes usados.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=12_heap_memoria_dinamica/04_buffer_dinamico run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=12_heap_memoria_dinamica/04_buffer_dinamico run
```

## Depurar

```gdb
break push_byte
continue
info registers x0 x1 x2 x3 x4 x5 x8 pc
x/16xb &buffer
x/gx &buffer_used
stepi
```

## Salida Esperada

```text
ABC
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `cbnz` | `cbnz x0, error_buffer` | Salta si `push_byte` retorno un codigo distinto de cero. |
| `cs` | `b.cs buffer_lleno` | Carry set despues de `cmp x2, x4`; para valores unsigned significa `used >= capacity`. |

## Que Observar

- El buffer tiene capacidad reservada, pero solo `buffer_used` indica cuantos
  bytes son validos.
- `write` usa `buffer_used`, no la capacidad total.
- `push_byte` evita escribir fuera del bloque simulado.

## Cambios Sugeridos

1. Agrega mas caracteres y observa como crece `buffer_used`.
2. Baja `buffer_capacity` para provocar `error_buffer`.
3. Cambia el texto y confirma que `write` imprime solo los bytes usados.
