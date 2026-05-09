# ARM RISC-V Lab

Repositorio educativo para Arquitectura de Computadores y Ensambladores.

La raíz queda para navegar y trabajar: sitio, ejemplos, proyectos y tooling.
La fuente completa del sitio Quarto vive en `site/`; el sitio publicado se
genera en `_site/` para GitHub Pages.

## Estructura

- `site/`: fuente del sitio Quarto, guías, cursos, estilos y diapositivas.
- `examples/`: ejemplos ejecutables autocontenidos.
- `projects/`: plantillas o proyectos de práctica con `src/` y configuración local.
- `tooling/`: Makefiles base, Docker y apoyo para laboratorio.
- `Makefile`: comandos de build, preview, slides y publicación.

## Sitio

```bash
cd site
pnpm install
cd ..
make site
make preview
```

`make site` renderiza `site/` hacia `_site/` y después compila las diapositivas
configuradas en `SLIDE_DECKS`.

## Diapositivas

```bash
make slides
make slides-build
```

Las fuentes viven bajo `site/slides/`. El build publicado queda bajo
`_site/slides/` para preservar las URLs públicas actuales.

Las dependencias de Slidev viven en `site/package.json`.

## Ejemplos

Flujo recomendado para estudiantes:

```bash
cd examples/aarch64/00-hello-minimo/src
make
make run
make gdb
```

Para Raspberry Pi ARM64 real, copia una plantilla de `tooling/make/` como
`src/Makefile` y usa el mismo flujo: `make`, `make run`, `make gdb`.

## Publicación

```bash
make publish
```

`make publish` conserva el flujo de GitHub Pages con Quarto y publica el sitio
generado sin prefijo `/site`.
