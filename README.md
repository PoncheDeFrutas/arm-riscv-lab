# ARM RISC-V Lab

Repositorio educativo para Arquitectura de Computadores y Ensambladores.

La primera vertical slice cubre AArch64/ARM64 en Linux user-space usando syscalls,
QEMU user mode, GDB y VS Code. La estructura queda preparada para crecer hacia
RISC-V sin mezclar contenido ni duplicar teoría.

## Flujo principal

```bash
cd 00-hello-minimo
make -C src
make -C src run
make -C src gdb
```

El flujo recomendado para estudiantes es:

```bash
leer teoría -> ejecutar ejemplo -> depurar -> resolver ejercicio
```

Para Raspberry Pi ARM64 real, usa el Makefile nativo de la lección:

```bash
cd 00-hello-minimo
make -C src -f Makefile.arm64
make -C src -f Makefile.arm64 run
make -C src -f Makefile.arm64 gdb
```

## Estructura

- `courses/`: teoría y navegación del sitio Quarto.
- `guides/`: instalación, ejecución, depuración y troubleshooting.
- `lessons/`: ejemplos ejecutables autocontenidos.
- `exercises/`: prácticas asociadas a cada lección.
- `slides/`: presentaciones Slidev de apoyo a clase.
- `tooling/`: templates de Makefile y Docker.
- `projects/`: estructura mínima de proyecto con `.vscode/` y `src/`.

## Sitio

```bash
pnpm install
make site
quarto preview
```

`make site` renderiza Quarto y después compila las slides dentro de `_site/`.

## Slides

```bash
pnpm install
pnpm exec slidev slides/aarch64/laboratorio/overview/slides.md
```

El workflow de GitHub Pages compila el deck en
`_site/slides/aarch64/laboratorio/overview/`.
