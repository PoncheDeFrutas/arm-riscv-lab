---
theme: default
class: text-left
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
title: "Unidad 12 · Heap y memoria dinámica"
info: "Presentación de apoyo para la Unidad 12 de la ruta AArch64."
author: "ARM RISC-V Lab"
seoMeta:
  ogTitle: "Unidad 12 · Heap y memoria dinámica"
  ogDescription: "Vida útil, ownership, bloques dinámicos y errores de memoria en AArch64."
---

# Arquitectura de Computadores y Ensambladores 1

Escuela de Ingeniería de Ciencias y Sistemas

---
layout: center
---

Arquitectura de Computadores y Ensambladores 1

## Unidad 12
## Heap y memoria dinámica

Vida útil, ownership, bloques dinámicos y errores de memoria.

Unidad teórica y práctica: stack vs heap, leaks, use-after-free y preparación para mmap.

---

# Anuncios importantes

1. **Anuncio 1**

---

# Agenda

1. **Stack vs Heap** — Diferencias en vida útil (lifetime) y por qué `.bss` no siempre alcanza.
2. **Bloques y Ownership** — Dirección, capacidad, uso y la responsabilidad de liberar.
3. **Errores críticos** — Memory leaks, use-after-free y double free.
4. **De brk a mmap** — Diferenciar CPU, kernel y bibliotecas (`malloc`/`free`).

---

# Competencias

### Competencia 1
El estudiante desarrolla soluciones eficientes en sistemas computacionales integrando arquitectura de computadores, programación en bajo nivel y herramientas modernas de análisis y simulación para resolver problemas complejos en sistemas embebidos e IoT.

### Competencia 2
Administra la asignación y liberación de memoria dinámica a bajo nivel, previniendo vulnerabilidades y fallos críticos (leaks, double free) para garantizar la estabilidad e integridad de los sistemas.

---

# Valor de la semana

**Responsabilidad (Ownership).** Hacerse cargo del ciclo de vida completo de los recursos que uno solicita y utiliza.

### Aplicación en clase
En programación de bajo nivel, no hay un recolector de basura (Garbage Collector) que limpie nuestros errores. Si pides memoria dinámica, tú eres el dueño (owner) y tienes la responsabilidad estricta de liberarla cuando termine su vida útil.

---

# Qué buscamos hoy

1. **Diferenciar memorias** — Reconocer cuándo usar Stack, Heap o `.bss` según la vida útil.
2. **Entender Ownership** — Separar el concepto de *puntero* del concepto de *dueño* del bloque.
3. **Reconocer Fallos** — Identificar qué causa leaks y use-after-free a nivel de diseño.
4. **Preparar el terreno** — Distinguir entre instrucciones de A64, funciones (`malloc`) y syscalls (`mmap`).

---
layout: section
---

# Stack vs Heap

No toda memoria vive lo mismo ni se administra igual.

---

# Tres vidas distintas

La dirección indica dónde está un dato. **La vida útil indica hasta cuándo tiene sentido usarlo.**

| Región | Cuándo nace | Cuándo deja de servir |
|---|---|---|
| `.data` / `.bss` | Al cargar el proceso | Al terminar el proceso |
| Stack | Al entrar a función o reservar | Al liberar frame o restaurar `sp` |
| Heap | Cuando el programa pide memoria | Cuando el programa la libera |

El error aparece cuando una dirección se sigue usando **después de que su vida útil terminó**.

---

# ¿Por qué no basta .bss o Stack?

**Límites del `.bss`**
```asm
.bss
buffer:
    .skip 64
```
Si el tamaño depende de una entrada (e.g., leer un archivo de tamaño desconocido), fijar un número desperdicia memoria o se queda corto.

**Límites del Stack**
```bash
funcion crea local en stack
  ptr = dirección del local
funcion retorna
  sp se restaura
```
Si devuelves la dirección de una variable local y la función retorna, ese `ptr` ya es inválido. **El frame se destruyó.**

**El Heap sirve para datos cuya vida no encaja con una sola llamada o cuyo tamaño se decide al ejecutar.**

---
layout: section
---

# Bloques y Ownership

Un bloque dinámico necesita puntero, capacidad, uso y dueño.

---

# Anatomía de un bloque dinámico

```mermaid {theme: 'dark', scale: 0.60}
flowchart LR
  reserve["Reservar bloque"] --> save["Guardar puntero y capacidad"]
  save --> use["Usar dentro de límites"]
  use --> update["Actualizar bytes usados"]
  update --> free["Liberar bloque (Responsabilidad)"]
  free --> invalid["Puntero viejo queda inválido"]
```

- **Puntero** — Dirección inicial en memoria. Copiar el puntero NO copia el bloque.
- **Capacidad** — Cantidad total de bytes reservados. Límite máximo.
- **Usados** — Cantidad de bytes que contienen **datos válidos** actualmente.
- **Dueño (Owner)** — Módulo responsable de asegurar que el bloque se libere.

---

# Ownership y Transferencia

Puntero NO equivale a ownership. Puedes tener una copia de la dirección (préstamo) sin ser responsable de liberar el bloque.

- **Préstamo (Borrow)** — Función A llama a Función B pasándole el puntero. B lee o escribe, pero **no libera**. A sigue siendo el dueño.
- **Transferencia (Move)** — A entrega el ownership a B. B ahora es el responsable de liberar. A ya no debe intentar liberar ese bloque.

---
layout: section
---

# Errores críticos de memoria

Leaks, use-after-free y double free son fallos de vida útil.

---

# Memory Leak y Double Free

**Memory Leak (Fuga)**
- Se pierde la referencia a la memoria reservada.
- Nadie tiene el puntero para hacer `free`.
- El bloque queda ocupado para siempre, desperdiciando recursos.

```asm
ldr x19, =buffer  // Puntero al heap
mov x19, #0       // Referencia local perdida!
// ¿Quién lo libera ahora?
```

**Double Free**
- Se libera **dos veces** el mismo bloque.
- Ocurre por ownership confuso (A y B creen ser dueños).
- Corrompe el estado interno del Allocator.

```bash
free(ptr)
free(ptr) // Error crítico, el bloque ya no te pertenece
```

---

# Use-after-free y Punteros Colgantes

Ocurre cuando el programa usa un puntero **después** de haber liberado el bloque.

```bash
antes:
  x19 -> bloque vivo

liberación:
  allocator recupera bloque (free)

después:
  x19 -> dirección vieja (Puntero colgante / Dangling pointer)
  strb w0, [x19] // ERROR CRÍTICO DE SEGURIDAD
```

Liberar un bloque **no borra** automáticamente todas las copias del puntero. Las copias viejas quedan peligrosas si alguien las usa.

---
layout: section
---

# De brk a mmap

Entendiendo las capas del sistema.

---

# CPU, Kernel y Bibliotecas

Confundir estas capas causa errores de lectura. El Heap no es una instrucción.

| Capa | Ejemplo | Quién la entiende | Qué hace |
|---|---|---|---|
| CPU | `ldr x0, [x1]` | Procesador | Ejecuta instrucciones A64 |
| Kernel | `svc #0` (mmap) | Sistema Operativo (Linux) | Ofrece syscalls para memoria bruta |
| Biblioteca | `malloc`, `free` | Código (e.g., `libc`) | Administra bloques pequeños sobre el kernel |

- `brk` (Histórico) — Syscall antigua para mover el límite final del heap. No la usaremos para allocators modernos.
- `mmap` (Práctico) — Syscall para mapear regiones explícitas de memoria al kernel. Será nuestra base en la Unidad 13.

---

# Checklist mental

- Puedo explicar qué es el heap y diferenciarlo del stack y `.bss`.
- Entiendo qué es el ciclo de vida de un dato.
- Sé distinguir entre tener un puntero y tener el ownership.
- Entiendo la diferencia entre capacidad reservada y bytes usados.
- Puedo reconocer y explicar qué es un Memory Leak.
- Entiendo el peligro de un Use-After-Free y de un Double Free.
- Sé que `malloc` es una función de biblioteca, no una instrucción.

---

# Siguiente paso

Heap y bloques conceptuales → Syscalls `mmap` y `munmap` → Permisos de memoria (RWX) y páginas → Implementaciones reales de memoria dinámica

---
layout: center
class: text-center
---

### Actividad de cierre

# Preguntas de repaso

- ¿Qué región usarías para leer un archivo cuyo tamaño conoces solo en tiempo de ejecución?
- ¿Por qué una dirección del stack deja de ser válida al ejecutar `ret`?
- ¿Qué sucede si dos funciones distintas hacen `free` sobre el mismo puntero?
- ¿Poner un registro en `0` equivale a liberar el bloque de memoria?
- ¿Por qué `malloc` no puede ser interpretado por el CPU AArch64?

---

### Ejemplo Práctico

Antes de usar `mmap`, simularemos el comportamiento de un bloque dinámico usando `.bss` para entender puntero, capacidad y uso.

```asm
.bss
buffer: .skip 64            // Simulamos el "Heap"

.text
.global _start
_start:
    ldr x19, =buffer        // 1. Puntero (x19 ahora es el dueño conceptual)
    mov x20, #64            // 2. Capacidad máxima reservada
    mov x21, #0             // 3. Bytes usados (vacío al inicio)

    // Aquí iría la lógica de leer o escribir y actualizar x21

    mov x19, #0             // Invalidación defensiva (simulación de 'free')

    mov x0, #0
    mov x8, #93
    svc #0
```

---

# Fuentes

- Página Quarto: `site/courses/aarch64/heap-memoria-dinamica/`
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- Linux man pages: `man mmap`, `man brk`
- Documentación de Glibc: *Memory Allocation*
- Slidev, documentación oficial

---
layout: statement
---

# Dudas¿?

---
layout: center
---

# Gracias por tu atención
