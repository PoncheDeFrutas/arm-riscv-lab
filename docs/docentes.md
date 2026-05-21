# Guía para Docentes y Colaboradores

## Cómo crear una nueva lección

Una nueva lección debería incluir:

1. Explicación breve en `.qmd`
2. Código fuente en `src/`
3. `Makefile` claro
4. Salida esperada
5. Paso opcional de depuración
6. Ejercicio asociado
7. Relación con la unidad anterior y la siguiente

## Estructura recomendada

- Usa `site/courses/` para teoría
- Usa `examples/` o `projects/` para material ejecutable
- Mantén cada unidad conectada con explicación, ejemplo y ejercicio

## Convenciones

- Sigue la nomenclatura del repositorio (ver [convenciones](convenciones.md))
- Respeta la estructura de front matter de Quarto
- Los ejemplos deben ser autocontenidos y reproducibles

## Flujo de validación

Antes de commitear una nueva lección:

1. Ejecuta `make quarto-site` o `make site` para validar el contenido
2. Si hay slides, usa `make slides-build` y previsualiza con `make slides`
3. Para lecciones ejecutables: `make`, `make run` y herramientas de inspección
