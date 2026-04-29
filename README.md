# ARM RISC-V Lab

Repositorio educativo para Arquitectura de Computadores y Ensambladores.

La primera vertical slice cubre AArch64/ARM64 en Linux user-space usando syscalls,
QEMU user mode, GDB y VS Code. La estructura queda preparada para crecer hacia
RISC-V sin mezclar contenido ni duplicar teoría.

## Flujo principal

```bash
cd lessons/aarch64/02-syscalls/00-hello-world
make
make run
make gdb
```

El flujo recomendado para estudiantes es:

```text
leer teoría -> ejecutar ejemplo -> depurar -> resolver ejercicio
```

## Estructura

- `courses/`: teoría y navegación del sitio Quarto.
- `guides/`: instalación, ejecución, depuración y troubleshooting.
- `lessons/`: ejemplos ejecutables autocontenidos.
- `exercises/`: prácticas asociadas a cada lección.
- `slides/`: presentaciones Slidev de apoyo a clase.
- `tooling/`: Makefiles compartidos y Docker.

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
pnpm exec slidev slides/aarch64/02-syscalls/00-hello-world/slides.md
```

El workflow de GitHub Pages compila el deck en
`_site/slides/aarch64/02-syscalls/00-hello-world/`.
