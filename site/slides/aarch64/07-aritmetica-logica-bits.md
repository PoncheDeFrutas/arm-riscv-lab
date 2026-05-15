---
theme: default
class: text-left
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
title: "Unidad 07 · Aritmética, lógica, flags y bits"
info: "Presentación de apoyo para la Unidad 07 de la ruta AArch64."
author: "ARM RISC-V Lab"
seoMeta:
  ogTitle: "Unidad 07 · Aritmética, lógica, flags y bits"
  ogDescription: "Opera valores en registros, actualiza flags y manipula bits antes de control de flujo."
---

# Arquitectura de Computadores y Ensambladores 1

Escuela de Ingeniería de Ciencias y Sistemas

---
layout: center
---

Arquitectura de Computadores y Ensambladores 1

## Unidad 07
## Aritmética, lógica, flags y bits

Opera valores en registros, actualiza NZCV y manipula bits antes de escribir branches y loops.

Unidad práctica: constantes, aritmética, flags, lógica/máscaras, shifts, extensiones y campos de bits.

---

# Anuncios importantes

1. **Anuncio 1**

---

# Agenda

1. **Movimiento de constantes** — `mov`, `movz`, `movk`, `movn` y bloques de 16 bits.
2. **Aritmética y flags** — `add`/`adds`, `sub`/`subs`, `cmp`, `cmn` y NZCV.
3. **Lógica y máscaras** — `and`, `orr`, `eor`, `bic`, `tst` y operaciones bit a bit.
4. **Shifts, extensiones y bitfields** — `lsl`, `lsr`, `asr`, `ror`, `sxtb`/`uxtb`, `ubfx`/`bfi`.
5. **Lectura guiada** — Un archivo completo que combina todas las familias.

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
Un bit equivocado en una máscara, un shift mal elegido o confundir `add` con `adds` produce resultados completamente diferentes. La precisión es la disciplina central de esta unidad.

---

# Qué buscamos hoy

1. **Construir constantes** — Distinguir `mov`, `movz`/`movk` y `ldr` desde memoria.
2. **Operar y marcar** — Sumar, restar, comparar y decidir cuándo actualizar flags.
3. **Filtrar bits** — Usar máscaras para encender, apagar, alternar y probar bits.
4. **Ajustar y extraer** — Shifts, extensiones signed/unsigned y campos de bits.

---
layout: section
---

# Movimiento de constantes

Poner valores en registros no siempre significa leer memoria.

---
layout: center
class: text-center
---

### Pregunta de arranque

## ¿Por qué no basta con un solo mov para cualquier constante?

- Una instrucción A64 ocupa 32 bits.
- Opcode + registros + inmediato deben caber ahí.
- Constantes grandes necesitan múltiples instrucciones.

---

# Tres formas de obtener un valor

```asm
mov x0, #42       // constante inmediata
ldr x1, =dato     // dirección o literal
ldr x2, [x1]      // contenido desde memoria
```

- `mov` — Constante directa. No toca memoria.
- `ldr =sym` — Dirección de símbolo o literal.
- `ldr [x1]` — Contenido leído desde memoria (corchetes).

---

# Construir constantes grandes: movz + movk

**Registro dividido en bloques de 16 bits**
```bash
x0:
[ 63..48 ][ 47..32 ][ 31..16 ][ 15..0 ]
```

```asm
movz x0, #0x7788           // base limpia
movk x0, #0x5566, lsl #16  // bloque 1
movk x0, #0x3344, lsl #32  // bloque 2
movk x0, #0x1122, lsl #48  // bloque 3
```

- **movz** — `0x0000000000007788`. Limpia + escribe bloque 0.
- **movk ×3** — Conserva (keep) y reemplaza. Final: `0x1122334455667788`

---
layout: section
---

# Aritmética y flags

La pregunta no es solo "cuánto da", sino "quiero flags o no".

---

# add vs adds — sub vs subs

```asm
add  x2, x0, x1    // guarda resultado, no toca NZCV
adds x3, x0, x1    // guarda resultado Y actualiza NZCV
```

- **Sin `s`** — `add`, `sub`, `neg`. Solo resultado. Flags intactos.
- **Con `s`** — `adds`, `subs`, `negs`. Resultado + flags NZCV. Preparación para `b.cond`.

Si usas `add` y luego esperas que `b.eq` funcione, tu razonamiento falla. Para actualizar flags usa `adds`, `subs` o `cmp`.

---

# cmp y cmn

- `cmp x0, x1` — Equivale a `subs xzr, x0, x1`. Actualiza flags como `x0 - x1`. Descarta el resultado.
- `cmn x0, x1` — Equivale a `adds xzr, x0, x1`. Actualiza flags como `x0 + x1`. Descarta la suma.

---

# Carry vs Overflow

- `C` — Carry (unsigned) — ¿Hubo carry fuera del tamaño? Ejemplo: `0xFFFF...FF + 1`. Aritmética unsigned.
- `V` — Overflow (signed) — ¿El resultado signed no cabe? Ejemplo: `0x7FFFFFFF + 1`. Aritmética signed.

`C` y `V` cuentan historias distintas sobre los mismos bits. `C` ayuda en unsigned. `V` ayuda en signed.

---
layout: section
---

# Lógica y máscaras

Bits como interruptores: selecciona, enciende, apaga, alterna y prueba.

---

# Operaciones lógicas fundamentales

- `and` — conservar — `10101100 & 00001111 = 00001100`
- `orr` — encender — `1000 | 0010 = 1010`
- `eor` — alternar — `1010 ^ 0010 = 1000`
- `bic` — apagar — `1111 & ~0100 = 1011`

---

# tst: probar sin guardar

```asm
tst x0, #1       // equivale a ands xzr, x0, #1
```

`tst` es para preguntar. `and` es para guardar. Ambos usan máscara, distinta intención.

**Recetas comunes**
- Probar bit 0: `tst x0, #1`
- Encender bit 3: `orr x0, x0, #0b1000`
- Apagar bit 3: `bic x0, x0, #0b1000`
- Conservar byte bajo: `and x1, x0, #0xFF`

---
layout: section
---

# Shifts, extensiones y bitfields

Mover, escalar, agrandar y extraer campos dentro de registros.

---

# Shifts: lsl, lsr, asr, ror

- `lsl` — Izquierda. Ceros por la derecha. ≈ multiplicar por 2^n.
- `lsr` — Derecha. Ceros por la izquierda. Unsigned/campos.
- `asr` — Derecha. Conserva bit de signo. Signed.
- `ror` — Rotación. Bits salen y regresan por el otro lado.

No uses `lsr` esperando preservar signo. Para valores signed, usa `asr`.

---

# Extensiones signed vs unsigned

```asm
mov  w8, #0xFF
uxtb w9, w8       // w9 = 0x000000FF (unsigned 255)
sxtb w10, w8      // w10 = 0xFFFFFFFF (signed -1)
```

- `uxtb` — unsigned — Rellena con ceros. `0xFF` → `255`
- `sxtb` — signed — Extiende bit de signo. `0xFF` → `-1`

El byte no cambió. Cambió la extensión. Elegir mal produce valores completamente diferentes.

---

# Campos de bits: ubfx y bfi

- `ubfx x1, x0, #8, #4` — Extrae 4 bits desde bit 8. Rellena con ceros. No toca memoria.
- `bfi x0, x3, #16, #8` — Inserta 8 bits bajos de `x3`. Los coloca desde bit 16. Conserva el resto de `x0`.

En bitfield, posiciones mueven la mirada dentro de un registro. No son offsets de memoria.

---

# Checklist mental

- Puedo construir constantes con `mov`, `movz`/`movk`.
- Puedo distinguir `add` de `adds` y `sub` de `subs`.
- Puedo explicar N, Z, C y V.
- Puedo usar máscaras con `and`, `orr`, `eor`, `bic` y `tst`.
- Puedo distinguir `lsl`, `lsr`, `asr` y `ror`.
- Puedo elegir extensión signed o unsigned.
- Puedo extraer e insertar campos de bits.

---

# Siguiente paso

Constantes y aritmética dominadas → Máscaras, shifts y extensiones claros → Flags NZCV listos para condiciones → Control de flujo: branches, loops y decisiones

---
layout: center
class: text-center
---

### Actividad de cierre

# Preguntas de repaso

- ¿Qué diferencia hay entre `mov` y `ldr` desde memoria?
- ¿Por qué `add` no sirve para preparar un `b.eq`?
- ¿Qué instrucción usarías para probar si el bit 0 está encendido sin modificar el registro?
- ¿Cuál es la diferencia entre `lsr` y `asr`?
- ¿Por qué `uxtb` y `sxtb` dan resultados distintos para `0xFF`?

---

### Ejemplo Práctico

Leer y ejecutar un programa que combina constantes, aritmética, máscaras, shifts y bitfields.

1. **Constantes** — `movz` + `movk` para armar `0x12345678`.
2. **Flags** — `subs` y `cmp`: ver cómo NZCV cambia.
3. **Máscaras** — `orr`, `bic`, `tst` y verificar con GDB.
4. **Bitfields** — `ubfx` para extraer un campo y comparar con `and`+`lsr`.

---

# Fuentes

- Página Quarto: `site/courses/aarch64/aritmetica-logica-bits/`
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- Larry D. Pyeatt y William Ughetta, *ARM 64-Bit Assembly Language*
- William Hohl y Christopher Hinds, *ARM Assembly Language: Fundamentals and Techniques*
- Arm, *Arm Architecture Reference Manual for A-profile architecture*
- Slidev, documentación oficial

---
layout: statement
---

# Dudas¿?

---
layout: center
---

# Gracias por tu atención
