# 14 · Layout De Datos, Structs Y ADTs

Bloque: Memoria y estructuras.

Esta unidad disena datos compuestos como bloques de memoria: offsets, tamanos,
invariantes, descriptores, objetos manuales, buffers, strings, matrices,
wrappers de archivo y arenas simples.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre el `src/main.s` del ejemplo antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_structs_layout](01_structs_layout/README.md) | 14.1 | offsets y size de `Point` |
| [02_acceso_campos_punteros](02_acceso_campos_punteros/README.md) | 14.2 | base + offset y tamanos correctos |
| [03_adts_invariantes](03_adts_invariantes/README.md) | 14.3 | Buffer ADT e invariantes |
| [04_objetos_manuales](04_objetos_manuales/README.md) | 14.4 | constructor, metodo y destructor |
| [05_descriptores](05_descriptores/README.md) | 14.5 | descriptor como metadata |
| [06_buffer_string_matrix](06_buffer_string_matrix/README.md) | 14.6 | Buffer, String y Matrix |
| [07_file_wrapper_arena](07_file_wrapper_arena/README.md) | 14.7 | wrapper de fd y arena simple |
| [08_lectura_guiada_buffer_adt](08_lectura_guiada_buffer_adt/README.md) | 14.8 | lectura guiada de Buffer ADT |

## Recorrido Sugerido

1. Domina `Point` antes de avanzar a descriptores.
2. Trata cada `.equ` como parte del contrato del tipo.
3. En los ADTs, modifica el estado solo por funciones del propio tipo.
4. Depura mirando primero la base del objeto y despues cada campo por offset.
