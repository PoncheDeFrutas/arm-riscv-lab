# Guía para Docentes y Colaboradores

## Cómo crear una nueva lección

Una nueva lección debería incluir:

1. Explicación breve en `.qmd`
2. Código fuente de ejemplo en `examples/aarch64/<unidad>/<ejemplo>/src/main.s`, si aplica
3. README del ejemplo con ejecución, salida esperada y puntos de depuración
4. Salida esperada
5. Paso opcional de depuración
6. Ejercicio asociado
7. Relación con la unidad anterior y la siguiente

## Estructura recomendada

- Usa `site/courses/` para teoría
- Usa `examples/aarch64` para ejemplos pequeños con Makefiles y `.vscode/` compartidos
- Usa `projects/` para material ejecutable con estructura propia
- Mantén cada unidad conectada con explicación, ejemplo y ejercicio

## Convenciones

- Sigue la nomenclatura del repositorio (ver [convenciones](convenciones.md))
- Respeta la estructura de front matter de Quarto
- Los ejemplos deben tener `src/main.s`, README propio y carpeta numerada en `snake_case`
- No dupliques `.vscode/` ni Makefiles dentro de cada ejemplo AArch64

## Flujo de validación

Antes de commitear una nueva lección:

1. Ejecuta `make quarto-site` o `make site` para validar el contenido
2. Si hay slides, usa `make slides-build` y previsualiza con `make slides`
3. Para ejemplos AArch64: desde `examples/aarch64`, ejecuta `make -f Makefile.qemu EXAMPLE=01_laboratorio/03_primer_programa run`
