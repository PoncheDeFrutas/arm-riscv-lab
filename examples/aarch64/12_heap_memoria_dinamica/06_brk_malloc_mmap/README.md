# 12.6 · De Brk A Malloc Y Mmap

## Objetivo

Ubicar la diferencia entre instruccion de CPU, syscall del kernel y funcion de
biblioteca antes de usar `mmap` real en la siguiente unidad.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa no implementa un allocator. Solo carga numeros de syscalls
relacionadas y escribe un mensaje para reforzar que `brk` y `mmap` pertenecen al
kernel, mientras `malloc` y `free` son funciones de biblioteca.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=12_heap_memoria_dinamica/06_brk_malloc_mmap run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=12_heap_memoria_dinamica/06_brk_malloc_mmap run
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x2 x8 x9 x10 x11 pc
stepi
```

## Salida Esperada

```text
brk/malloc/mmap: capas distintas
```

## Que Observar

- `svc #0` es la instruccion que entra al kernel.
- `x8 = 64` selecciona `write`; los numeros `214`, `222` y `215` son ejemplos
  de syscalls relacionadas con memoria en Linux AArch64.
- `malloc` y `free` no aparecen como instrucciones porque pertenecen a libc.

## Cambios Sugeridos

1. Inspecciona `x9`, `x10` y `x11` antes del `write`.
2. Cambia el mensaje para resumir la diferencia con tus palabras.
3. Usa esta leccion como puente antes de implementar `mmap` real.
