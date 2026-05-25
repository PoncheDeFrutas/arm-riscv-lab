# Convenciones del Repositorio

## Organización

- Unidades numeradas y organizadas por tema en `site/courses/aarch64/`
- Ejemplos AArch64 organizados bajo `examples/aarch64/`, con Makefiles y `.vscode/` compartidos
- Cada ejemplo debe tener `src/main.s` y generar artefactos solo en `src/build/`
- `.s` es el código fuente ensamblador, `.o` es el archivo objeto y el ejecutable final es un binario ELF
- `examples/` para ejemplos autocontenidos y `projects/` para estructuras más grandes

## Nomenclatura

- Archivos `.qmd` y decks en minúsculas con prefijos numéricos (ej: `03-load-store-basico.qmd`)
- Carpetas de ejemplos AArch64 en `snake_case` con prefijo numérico (ej: `05_primeros_programas/01_programa_minimo_exit`)
- Contenido en español salvo que se trate de texto técnico existente en inglés
- Front matter de Quarto y estructura de sidebar según `site/_quarto.yml`

## Tooling

- Makefiles compartidos de ejemplos en `examples/aarch64/Makefile.qemu` y `examples/aarch64/Makefile.native`
- Plantillas de Makefile en `tooling/make/makefile-templates/` para proyectos aislados o compatibilidad
- Dockerfile en `tooling/docker/`
- Slides en `site/slides/aarch64/` con componentes Vue reutilizables y estilos en `site/slides/aarch64/styles/`

## Archivos generados

No se deben commitear: `_site/`, `.quarto/`, `dist/`, `node_modules/`, `*.o`, `*.elf`.

Si las convenciones cambian, se actualizará este documento.
