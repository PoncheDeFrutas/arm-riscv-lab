# 13 · mmap, Paginas Y Permisos

Bloque: Memoria y estructuras.

Esta unidad usa syscalls reales para pedir regiones de memoria virtual,
protegerlas, mapear archivos y liberarlas. Los ejemplos evitan fallos
intencionales en ejecucion normal; los crashes utiles para aprender quedan como
cambios sugeridos.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre el `src/main.s` del ejemplo antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_paginas_memoria_virtual](01_paginas_memoria_virtual/README.md) | 13.1 | pagina, alineacion y region mapeada |
| [02_mmap_anonimo_privado](02_mmap_anonimo_privado/README.md) | 13.2 | `mmap` anonimo privado |
| [03_munmap_ciclo_vida](03_munmap_ciclo_vida/README.md) | 13.3 | base, cursor y `munmap` |
| [04_mprotect_permisos](04_mprotect_permisos/README.md) | 13.4 | permisos y `mprotect` |
| [05_mmap_con_archivo](05_mmap_con_archivo/README.md) | 13.5 | archivo mapeado |
| [06_errores_diagnostico](06_errores_diagnostico/README.md) | 13.6 | retorno negativo y diagnostico |
| [07_programa_guiado](07_programa_guiado/README.md) | 13.7 | flujo completo con cleanup |

## Recorrido Sugerido

1. Empieza con una sola pagina y confirma que la base queda alineada.
2. Practica `mmap` anonimo antes de agregar permisos y archivos.
3. En los ejemplos con cleanup, revisa primero que recurso ya existe antes de
   saltar a la ruta de error.
4. Si quieres provocar fallos reales, hazlo solo despues de entender la version
   segura.
