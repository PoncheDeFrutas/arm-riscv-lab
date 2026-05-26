# 15 · ABI, AAPCS64 E Interoperabilidad Con C

Bloque: ABI, binarios y debugging.

Esta unidad formaliza la calling convention: que registros llevan argumentos,
que registros debe preservar una funcion, como cambia el arranque con libc y
como cruzar la frontera entre C y assembly.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre un archivo dentro de `src/` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.
- Los ejemplos con libc usan `aarch64-linux-gnu-gcc` y QEMU con sysroot.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_abi_aapcs64_registros](01_abi_aapcs64_registros/README.md) | 15.1 | mapa de registros ABI |
| [02_argumentos_retornos_stack](02_argumentos_retornos_stack/README.md) | 15.2 | argumentos por registros y stack |
| [03_caller_callee_saved](03_caller_callee_saved/README.md) | 15.3 | preservar `x19-x28` |
| [04_main_start_libc_runtime](04_main_start_libc_runtime/README.md) | 15.4 | `main`, runtime y libc |
| [05_assembly_desde_c](05_assembly_desde_c/README.md) | 15.5 | C llama assembly |
| [06_c_desde_assembly_printf](06_c_desde_assembly_printf/README.md) | 15.6 | assembly llama `printf` |
| [07_librerias_lectura_guiada](07_librerias_lectura_guiada/README.md) | 15.7 | libreria estatica y herramientas |

## Recorrido Sugerido

1. Lee primero los ejemplos puros de registros, stack y preservacion.
2. Pasa despues a `main` con libc para separar `_start` de runtime.
3. Cruza C -> assembly antes de assembly -> C.
4. Usa la libreria estatica como cierre para inspeccionar simbolos y objetos.
