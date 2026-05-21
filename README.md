# ARM RISC-V Lab

Material educativo para aprender arquitectura de computadores y programación de bajo nivel desde Linux. La ruta activa del repositorio es AArch64 (ARM64); RISC-V queda como una ruta planificada para más adelante.

El objetivo no es solo mostrar instrucciones de ensamblador. El material busca conectar cada tema con herramientas reales: compilación, ejecución, inspección de binarios, syscalls, memoria y depuración.

## Qué contiene este repositorio

El contenido principal está en `site/courses/aarch64/`. Ahí se organizan las unidades del curso: bases binarias, modelo AArch64, GNU Assembly, primeros programas, memoria, control de flujo, syscalls, ABI, ELF, stack, heap y debugging.

También hay guías prácticas en `site/guides/` para preparar el entorno, trabajar con QEMU, depurar con GDB y resolver problemas comunes. Las presentaciones de apoyo están en `site/slides/`.

## Estado actual

- **AArch64**: ruta principal y en desarrollo activo.
- **RISC-V**: existe una página inicial en `site/courses/riscv/`, pero el contenido todavía está en planificación.
- **Ejemplos y proyectos**: `examples/` y `projects/` están reservados para programas ejecutables y prácticas; aún faltan ejemplos completos.
- **Tooling**: `tooling/` contiene plantillas de Makefile y soporte para entornos reproducibles.

## Para quién es

- Estudiantes de arquitectura de computadores.
- Personas que empiezan con ensamblador y quieren una ruta ordenada.
- Quienes quieren entender registros, memoria, syscalls, ABI y binarios ELF.
- Docentes o auxiliares que quieran reutilizar o extender el material.

## Por dónde empezar

Si es tu primera vez, empieza por la guía de entorno:

- `site/guides/setup/index.qmd`
- `site/guides/setup/qemu-x86_64.qmd` si usas una computadora x86_64
- `site/guides/setup/native-aarch64.qmd` si trabajas en ARM64 nativo

Después sigue la ruta AArch64:

1. `site/courses/aarch64/fundamentos/contexto-historia-objetivos.qmd`
2. `site/courses/aarch64/laboratorio/index.qmd`
3. `site/courses/aarch64/bases-binarias/index.qmd`
4. `site/courses/aarch64/modelo-aarch64/index.qmd`
5. `site/courses/aarch64/gnu-assembly/index.qmd`
6. `site/courses/aarch64/primeros-programas/index.qmd`

No hace falta leer todo de una vez. La idea es avanzar por unidad: leer, ejecutar cuando haya ejemplo, inspeccionar con herramientas y modificar el programa para entender qué cambia.

## Estructura del repositorio

| Ruta | Uso |
|---|---|
| `site/` | Fuente del sitio Quarto |
| `site/courses/aarch64/` | Ruta principal del curso |
| `site/courses/riscv/` | Ruta RISC-V planificada |
| `site/guides/` | Setup, debugging y troubleshooting |
| `site/slides/` | Presentaciones Slidev y componentes Vue |
| `examples/` | Ejemplos autocontenidos, pendientes de poblar |
| `projects/` | Prácticas o proyectos más grandes, pendientes de poblar |
| `tooling/docker/` | Dockerfile del laboratorio |
| `tooling/make/makefile-templates/` | Plantillas para compilar en QEMU o ARM64 nativo |
| `_site/` | Sitio generado; no se edita a mano |

## Herramientas necesarias

Para trabajar con AArch64 desde una máquina x86_64 en Debian/Ubuntu:

```bash
sudo apt update
sudo apt install -y make gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu qemu-user gdb-multiarch file strace
```

Para una máquina ARM64 nativa:

```bash
sudo apt update
sudo apt install -y make gcc binutils gdb file strace
```

Verificación rápida:

```bash
aarch64-linux-gnu-gcc --version
qemu-aarch64 --version
gdb-multiarch --version
```

Para previsualizar el sitio también necesitas Quarto. Para trabajar con slides, usa Node.js y pnpm dentro de `site/slides/`.

## Comandos útiles

Desde la raíz del repositorio:

```bash
make help
make preview
make quarto-site
make slides
make slides-build
make site
```

- `make preview`: abre una vista local del sitio Quarto.
- `make quarto-site`: genera solo las páginas del sitio.
- `make slides`: ejecuta Slidev para el deck configurado en `SLIDES`.
- `make slides-build`: construye las presentaciones hacia `_site/slides/`.
- `make site`: genera sitio y slides.

Para una presentación específica:

```bash
make slides SLIDES=site/slides/aarch64/05-primeros-programas.md
```

## Flujo recomendado de estudio

1. Lee una unidad del curso.
2. Revisa los comandos y fragmentos de código.
3. Ejecuta el ejemplo cuando exista.
4. Inspecciona el binario con `objdump`, `readelf`, `nm` o `strace`.
5. Depura con GDB cuando la unidad lo indique.
6. Cambia algo pequeño y vuelve a ejecutar.

Ese ciclo importa más que memorizar instrucciones. La meta es que puedas explicar qué hace el programa, qué registros usa, qué syscalls ejecuta y qué cambia en memoria.

## Para docentes o colaboradores

Al agregar una unidad nueva, intenta mantener esta estructura:

- una explicación corta en `.qmd`;
- comandos reproducibles;
- código fuente cuando aplique;
- salida esperada o forma de verificarla;
- una actividad o pregunta de práctica;
- conexión clara con la unidad anterior y la siguiente.

Si agregas ejemplos ejecutables, ubícalos en `examples/` o `projects/` y usa las plantillas de `tooling/make/makefile-templates/` cuando sea posible.

## Licencia

Este repositorio usa licencia MIT. Ver `LICENSE`.
