# 16 · ELF, Linking, Loading Y Binarios

Bloque: ABI, binarios y debugging.

Esta unidad trata el binario como objeto tecnico: fuente, objeto relocatable,
ejecutable ELF, secciones, segmentos, simbolos, relocations, dynamic loader,
GOT/PLT/PIE y herramientas de inspeccion.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Ejecuta los comandos desde `examples/aarch64`.
- Usa los targets compartidos: `readelf-header`, `readelf-sections`,
  `readelf-programs`, `readelf-dynamic`, `objdump`, `nm` y `strip-copy`.

## Ejemplos

| Ejemplo | Leccion | Tema |
|---|---|---|
| [01_flujo_assembly_objeto_ejecutable](01_flujo_assembly_objeto_ejecutable/README.md) | 16.1 | de `.s` a `.o` y ELF |
| [02_elf_header_entry_point](02_elf_header_entry_point/README.md) | 16.2 | header y entry point |
| [03_secciones_simbolos_relocations](03_secciones_simbolos_relocations/README.md) | 16.3 | secciones, simbolos y relocations |
| [04_segmentos_loader_permisos](04_segmentos_loader_permisos/README.md) | 16.4 | segmentos y permisos |
| [05_linking_estatico_dinamico](05_linking_estatico_dinamico/README.md) | 16.5 | linking dinamico con libc |
| [06_got_plt_pie](06_got_plt_pie/README.md) | 16.6 | GOT, PLT y PIE |
| [07_herramientas_lectura_guiada](07_herramientas_lectura_guiada/README.md) | 16.7 | rutina integrada de lectura |

## Recorrido Sugerido

1. Compila primero el binario minimo y revisa header, secciones y programas.
2. Distingue seccion de segmento antes de entrar a dynamic linking.
3. Usa `readelf -d` para dependencias dinamicas en vez de `ldd` si estas en host cruzado.
4. Cierra con `strip-copy` para separar ejecucion de simbolos de depuracion.
