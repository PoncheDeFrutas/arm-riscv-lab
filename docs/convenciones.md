# Convenciones del Repositorio

## Organización

- Unidades numeradas y organizadas por tema en `site/courses/aarch64/`
- Ejemplos esperados con `src/main.s`, `src/Makefile` y `build/` para salida
- `.s` es el código fuente ensamblador, `.o` es el archivo objeto y el ejecutable final es un binario ELF
- `examples/` para ejemplos autocontenidos y `projects/` para estructuras más grandes

## Nomenclatura

- Archivos `.qmd` y decks en minúsculas con prefijos numéricos (ej: `03-load-store-basico.qmd`)
- Contenido en español salvo que se trate de texto técnico existente en inglés
- Front matter de Quarto y estructura de sidebar según `site/_quarto.yml`

## Tooling

- Plantillas de Makefile en `tooling/make/makefile-templates/`
- Dockerfile en `tooling/docker/`
- Slides en `site/slides/aarch64/` con componentes Vue reutilizables y estilos en `site/slides/aarch64/styles/`

## Archivos generados

No se deben commitear: `_site/`, `.quarto/`, `dist/`, `node_modules/`, `*.o`, `*.elf`.

Si las convenciones cambian, se actualizará este documento.
