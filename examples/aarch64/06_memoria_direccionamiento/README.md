# 06 · Memoria Basica, Secciones Y Direccionamiento

Bloque: Programas Linux.

Esta unidad conecta el modelo load/store de AArch64 con memoria real: direccion
vs contenido, secciones, cargas, stores, tamanos de acceso, modos de
direccionamiento y arrays.

## Ejemplos

| Ejemplo | Leccion | Estado |
|---|---|---|
| `01_direccion_contenido` | 06.1 · Direccion y contenido | implementado |
| `02_secciones_mapa` | 06.2 · Secciones y mapa de memoria | implementado |
| `03_load_store_basico` | 06.3 · Load/store basico | implementado |
| `04_tamanos_acceso` | 06.4 · Tamanos de acceso | implementado |
| `05_modos_direccionamiento` | 06.5 · Modos de direccionamiento | implementado |
| `06_arrays_recorrido` | 06.6 · Arrays y recorrido | implementado |

## Flujo Recomendado

1. Empieza con direccion vs contenido antes de tocar stores.
2. Revisa las secciones para ubicar donde vive cada dato.
3. Practica cargar, modificar y guardar con un solo contador.
4. Compara lecturas de 1, 2, 4 y 8 bytes.
5. Usa modos de direccionamiento para calcular direcciones efectivas.
6. Cierra con arrays como memoria consecutiva recorrida con post-index.
