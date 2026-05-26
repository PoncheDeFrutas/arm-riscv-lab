# 12 · Heap Y Memoria Dinamica

Bloque: Memoria y estructuras.

Esta unidad introduce memoria dinamica desde la disciplina de uso: vida util,
punteros, bloques, ownership, cleanup y errores comunes. Los ejemplos usan
`.bss` para simular bloques tipo heap; `mmap` real queda para la unidad
siguiente.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre el `src/main.s` del ejemplo antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_stack_vs_heap](01_stack_vs_heap/README.md) | 12.1 | vida util de stack frente a bloque simulado |
| [02_bloques_ownership](02_bloques_ownership/README.md) | 12.2 | puntero, capacidad, usado y propietario |
| [03_allocation_deallocation](03_allocation_deallocation/README.md) | 12.3 | reservar, liberar y limpiar estado |
| [04_buffer_dinamico](04_buffer_dinamico/README.md) | 12.4 | buffer con capacidad y bytes usados |
| [05_errores_memoria](05_errores_memoria/README.md) | 12.5 | double free y use-after-free simulados |
| [06_brk_malloc_mmap](06_brk_malloc_mmap/README.md) | 12.6 | capas: syscall, libc y allocator |

## Recorrido Sugerido

1. Usa `01_stack_vs_heap` para separar ubicacion de vida util.
2. Sigue con `02_bloques_ownership` antes de hablar de liberar memoria.
3. Practica rutas de cleanup en `03_allocation_deallocation`.
4. Cierra con `06_brk_malloc_mmap` para ubicar que es instruccion, syscall y
   funcion de biblioteca.
