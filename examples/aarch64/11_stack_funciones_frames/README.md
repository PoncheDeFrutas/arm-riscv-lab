# 11 · Stack, Funciones Y Stack Frames

Bloque: Memoria y estructuras.

Esta unidad convierte los saltos con retorno en funciones reales: primero con
`bl` y `ret`, despues con stack, frames, funciones no hoja y recursion pequena.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre el `src/main.s` del ejemplo antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_llamadas_retorno](01_llamadas_retorno/README.md) | 11.1 | `bl`, `x30/LR` y `ret` |
| [02_stack_basico](02_stack_basico/README.md) | 11.2 | reservar, usar y restaurar `sp` |
| [03_stack_frames](03_stack_frames/README.md) | 11.3 | prologo, epilogo, `x29` y locales |
| [04_funciones_no_hoja](04_funciones_no_hoja/README.md) | 11.4 | proteger retorno y temporales |
| [05_recursion_basica](05_recursion_basica/README.md) | 11.5 | frames repetidos y caso base |
| [06_debugging_frames_gdb](06_debugging_frames_gdb/README.md) | 11.6 | inspeccion de frames con GDB |

## Recorrido Sugerido

1. Empieza con `01_llamadas_retorno` para ver que `bl` guarda el retorno en
   `x30`.
2. Sigue con `02_stack_basico` para practicar `sp` sin frame formal.
3. Usa `03_stack_frames` antes de modificar cualquier funcion no hoja.
4. Depura `06_debugging_frames_gdb` con GDB para ver la cadena de `x29`.
