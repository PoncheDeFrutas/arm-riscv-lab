---
theme: default
class: text-left
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
title: "Unidad 06 · Memoria básica, secciones y direccionamiento"
info: "Presentación de apoyo para la Unidad 06 de la ruta AArch64."
author: "ARM RISC-V Lab"
seoMeta:
  ogTitle: "Unidad 06 · Memoria básica, secciones y direccionamiento"
  ogDescription: "Carga direcciones, lee contenido, escribe bytes y recorre memoria con instrucciones load/store."
---

# Arquitectura de Computadores y Ensambladores 1

Escuela de Ingeniería de Ciencias y Sistemas

---
layout: center
---

Arquitectura de Computadores y Ensambladores 1

## Unidad 06
## Memoria básica, secciones y direccionamiento

AArch64 es load/store: la ALU trabaja con registros y la memoria se toca de forma explícita.

Unidad práctica: dirección vs contenido, secciones, ldr/str, tamaños, modos de direccionamiento y arrays.

---

# Anuncios importantes

1. **Anuncio 1**

---

# Agenda

1. **Dirección y contenido** — Memoria como bytes, punteros y diferencia entre cargar dirección y contenido.
2. **Secciones y mapa de memoria** — `.text`, `.rodata`, `.data`, `.bss`, stack y heap.
3. **Load/store básico** — `ldr`, `str`, cargar-modificar-guardar.
4. **Tamaños y modos de direccionamiento** — `ldrb`, `ldrh`, `ldrsw`, offsets, pre-index y post-index.
5. **Arrays y recorrido** — Base + índice × tamaño, escalas y lectura guiada.

---

# Competencias

### Competencia 1
Aplica el set de instrucciones ARM-64 utilizando instrucciones aritméticas, lógicas, de carga/almacenamiento, desplazamientos y rotaciones para construir programas funcionales que manipulen datos a nivel de registros y memoria.

### Competencia 2
Analiza el comportamiento de arquitecturas modernas (ARM y RISC-V) utilizando simuladores como Gem5, QEMU, registros e instrucciones optimizando programas a bajo nivel en microprocesadores.

---

# Valor de la semana

**Precisión.** Exactitud al escribir y ejecutar instrucciones a nivel de máquina.

### Aplicación en clase
En ensamblador, un error de un bit o una instrucción mal escrita puede producir resultados completamente inesperados. La precisión es esencial al trabajar con instrucciones aritméticas, lógicas y de memoria.

---

# Qué buscamos hoy

1. **Dirección vs contenido** — Distinguir dirección, contenido y valor interpretado en memoria.
2. **Load/store** — Cargar datos a registros y escribir resultados de vuelta a memoria.
3. **Tamaños de acceso** — Elegir `ldrb`, `ldrh`, `ldr w` o `ldr x` según el dato.
4. **Direccionamiento y arrays** — Calcular offsets, usar escalas y recorrer memoria con post-index.

---
layout: section
---

# Dirección y contenido

La primera regla: una dirección dice dónde mirar; el contenido dice qué bytes hay allí.

---
layout: center
class: text-center
---

### Pregunta de arranque

## ¿Qué diferencia hay entre cargar una dirección y cargar lo que hay en esa dirección?

- Una dirección es un número que indica posición.
- El contenido son bytes guardados en esa posición.
- El valor depende de la instrucción y el tamaño de lectura.

---

# Memoria como arreglo de bytes

```bash
Dirección:   0x400120  0x400121  0x400122  0x400123
Contenido:      2A        00        00        00
```

- **Dirección** — Número que indica posición. Ej: `0x400120`
- **Contenido** — Bytes guardados. Ej: `2A 00 00 00`
- **Valor** — Interpretación. Ej: `42` como int32 LE.

---

# Cargar dirección vs cargar contenido

```asm
.data
valor:
    .quad 42

.text
_start:
    ldr x0, =valor    // x0 = dirección donde empieza valor
    ldr x1, [x0]      // x1 = contenido de 64 bits guardado allí
```

- `ldr x0, =valor` — Carga una dirección. `x0` = puntero, ej: `0x410158`
- `ldr x1, [x0]` — Usa corchetes → acceso a memoria. `x1` = valor leído: `42`

---

# La diferencia está en los corchetes

- **Sin corchetes** — `ldr x0, =valor` → Obtienes la **dirección** asociada al símbolo.
- **Con corchetes** — `ldr x1, [x0]` → Lees el **contenido** almacenado en esa dirección.

Los corchetes indican acceso a memoria: "ve a esa dirección y lee lo que hay allí".

---
layout: section
---

# Secciones y mapa de memoria

Dónde viven código, datos constantes, datos modificables y espacio reservado.

---

# Mapa inicial de memoria

**Regiones de un proceso Linux**
- `.text` — Instrucciones ejecutables.
- `.rodata` — Datos constantes (solo lectura).
- `.data` — Datos inicializados modificables.
- `.bss` — Espacio reservado (sin bytes en archivo).

**Zonas adicionales**
- **Stack** — Existe desde `_start`. `sp` apunta a esta zona.
- **Heap** — Memoria dinámica futura. No la usaremos aún.

---
layout: section
---

# Load/store básico

AArch64 calcula en registros y accede a memoria con instrucciones explícitas.

---

# Arquitectura load/store

```mermaid {theme: 'dark', scale: 0.78}
flowchart LR
  MEM1["Memoria"] --> LOAD["ldr"]
  LOAD --> REG1["Registro"]
  REG1 --> OP["Operación ALU"]
  OP --> REG2["Registro"]
  REG2 --> STORE["str"]
  STORE --> MEM2["Memoria"]
```

La ALU trabaja con registros. Si un valor está en memoria, primero lo cargas. Si quieres conservar el resultado, lo escribes de vuelta.

---

# Patrón cargar-modificar-guardar

**Código**
```asm
ldr x0, =contador
ldr x1, [x0]       // cargar
add x1, x1, #1     // modificar
str x1, [x0]       // guardar
```

**Secuencia**
1. Cargar dirección.
2. Cargar contenido al registro.
3. Modificar en registro.
4. Guardar resultado en memoria.

---
layout: section
---

# Tamaños de acceso

La instrucción decide cuántos bytes leer o escribir.

---

# Instrucciones por tamaño

- `ldrb` / `strb` — 1 byte.
- `ldrh` / `strh` — 2 bytes (halfword).
- `ldr w` / `str w` — 4 bytes (word).
- `ldr x` / `str x` — 8 bytes (doubleword).

---

# Mismos bytes, lecturas distintas

```asm
.data
bytes:
    .byte 0x11, 0x22, 0x33, 0x44

.text
_start:
    ldr x0, =bytes
    ldrb w1, [x0]    // w1 = 0x11
    ldrh w2, [x0]    // w2 = 0x2211 (little-endian)
    ldr  w3, [x0]    // w3 = 0x44332211
```

No existe "leer una variable". Existen instrucciones que leen 1, 2, 4 u 8 bytes desde una dirección. Elegir tamaño correcto es parte del programa.

---

# ldrsw: sign extension a 64 bits

- `ldr w1, [x0]` — Lee 32 bits, limpia mitad alta. `0xFFFFFFFF` → `x1 = 0x00000000FFFFFFFF`
- `ldrsw x2, [x0]` — Lee 32 bits, extiende signo a 64. `0xFFFFFFFF` → `x2 = 0xFFFFFFFFFFFFFFFF`

La diferencia no está en los bytes guardados. Está en cómo se extiende el valor al registro de 64 bits.

---
layout: section
---

# Modos de direccionamiento

Cómo AArch64 calcula la dirección efectiva de un acceso a memoria.

---

# Formas principales

- `[x0]` — Base sola. Dirección en `x0`.
- `[x0, #8]` — Offset inmediato. `x0 + 8`.
- `[x0, x1]` — Offset en registro. `x0 + x1`.
- `[x0, x1, lsl #3]` — Offset escalado. `x0 + x1 × 8`.
- `[x0, #8]!` — Pre-index. Actualiza `x0`, luego lee.
- `[x0], #8` — Post-index. Lee, luego actualiza `x0`.

---

# Pre-index vs post-index

**Pre-index `[x0, #8]!`**
- Primero: `x0 = x0 + 8`
- Luego: lee desde nuevo `x0`.
- Avanza el puntero antes del acceso.

**Post-index `[x0], #8`**
- Primero: lee desde `x0` actual.
- Luego: `x0 = x0 + 8`
- Avanza el puntero después del acceso.

Post-index es cómodo para recorrer memoria linealmente: lee y avanza en una sola instrucción.

---
layout: section
---

# Arrays y recorrido

Un array es memoria consecutiva. La dirección del elemento depende de base + índice × tamaño.

---

# Arrays y recorrido

Un array es memoria consecutiva. La dirección del elemento depende de base + índice × tamaño.

---

# Fórmula de acceso a arrays

$$
\text{dir}[i] = \text{base} + i \times \text{tamaño}
$$

**Escalas comunes**
- `.byte` — sin escala
- `.word` — `lsl #2` (×4)
- `.quad` — `lsl #3` (×8)

**Ejemplo con offset escalado**
```asm
.data
array:
    .quad 10, 20, 30, 40

.text
_start:
    ldr x0, =array
    mov x1, #2              // índice
    ldr x2, [x0, x1, lsl #3]
    // x2 = array[2] = 30
```

---

# Recorrido con post-index

```asm
ldr x0, =array
ldr x1, [x0], #8    // x1 = array[0], x0 avanza
ldr x2, [x0], #8    // x2 = array[1], x0 avanza
ldr x3, [x0], #8    // x3 = array[2], x0 avanza
```

```bash
Inicio:     x0 → array[0]
Después 1:  x0 → array[1]
Después 2:  x0 → array[2]
Después 3:  x0 → después del array
```

---

# ldp y stp: pares de registros

```asm
.data
pares:
    .quad 11, 22

.text
_start:
    ldr x0, =pares
    ldp x1, x2, [x0]    // x1 = 11, x2 = 22
```

`ldp` carga dos registros consecutivos. `stp` guarda dos. Aparecerán mucho con stack frames.

---

# Checklist mental

- Puedo distinguir dirección, contenido y valor.
- Puedo cargar una dirección con `ldr =symbol`.
- Puedo cargar contenido con `ldr xN, [xM]`.
- Puedo escribir memoria con `str`.
- Puedo elegir entre `ldrb`, `ldrh`, `ldr` y `ldrsw`.
- Puedo calcular offsets para arrays.
- Puedo distinguir pre-index de post-index.

---

# Siguiente paso

Dirección vs contenido dominados → Load/store y tamaños claros → Modos de direccionamiento y arrays → Control de flujo, stack y funciones

---
layout: center
class: text-center
---

### Actividad de cierre

# Preguntas de repaso

- ¿Qué diferencia hay entre `ldr x0, =valor` y `ldr x1, [x0]`?
- ¿Qué lee `ldrb w1, [x0]` vs `ldr w2, [x0]` desde los mismos bytes?
- ¿Qué escala usarías para un array de `.word`?
- ¿Qué diferencia hay entre pre-index y post-index?
- ¿Por qué AArch64 se llama arquitectura load/store?

---

### Ejemplo Práctico

Declarar datos, cargar, modificar, guardar y recorrer un array en AArch64.

1. **Cargar** — `ldr x0, =dato` y `ldr x1, [x0]` para dirección y contenido.
2. **Modificar** — `add x1, x1, #1` y `str x1, [x0]` para leer-modificar-guardar.
3. **Recorrer** — Array con post-index: `ldr x1, [x0], #8` y acumular.
4. **Inspeccionar** — `objdump -s -j .data` para ver bytes antes y después.

---

# Fuentes

- Página Quarto: `site/courses/aarch64/memoria-direccionamiento/`
- Larry D. Pyeatt y William Ughetta, *ARM 64-Bit Assembly Language*
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- William Hohl y Christopher Hinds, *ARM Assembly Language: Fundamentals and Techniques*
- `man objdump`, `man readelf` — inspección de secciones y datos
- Slidev, documentación oficial

---
layout: statement
---

# Dudas¿?

---
layout: center
---

# Gracias por tu atención
