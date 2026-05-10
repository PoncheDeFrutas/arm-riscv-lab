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

<style>
@import "../../../../styles/index.css";
</style>

<div class="ecys-cover-bg"></div>

<div class="ecys-title-cover">

<div class="muted">Escuela de Ingeniería de Ciencias y Sistemas</div>

# Arquitectura de Computadores y Ensambladores 1

</div>

---
layout: center
---

<div class="muted">Arquitectura de Computadores y Ensambladores 1</div>

## Unidad 07
## Aritmética, lógica, flags y bits

Opera valores en registros, actualiza NZCV y manipula bits
antes de escribir branches y loops.

<div class="cover-note">
Unidad práctica: constantes, aritmética, flags, lógica/máscaras, shifts, extensiones y campos de bits.
</div>

---

# Anuncios importantes

<div class="numbered-grid">
  <div class="numbered-card">
    <div class="card-number">1</div>
    <h3>Anuncio 1</h3>
    <p></p>
  </div>
</div>

---

# Agenda

<div class="numbered-grid">
  <div class="numbered-card">
    <div class="card-number">1</div>
    <h3>Movimiento de constantes</h3>
    <p><code>mov</code>, <code>movz</code>, <code>movk</code>, <code>movn</code> y bloques de 16 bits.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">2</div>
    <h3>Aritmética y flags</h3>
    <p><code>add</code>/<code>adds</code>, <code>sub</code>/<code>subs</code>, <code>cmp</code>, <code>cmn</code> y NZCV.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">3</div>
    <h3>Lógica y máscaras</h3>
    <p><code>and</code>, <code>orr</code>, <code>eor</code>, <code>bic</code>, <code>tst</code> y operaciones bit a bit.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">4</div>
    <h3>Shifts, extensiones y bitfields</h3>
    <p><code>lsl</code>, <code>lsr</code>, <code>asr</code>, <code>ror</code>, <code>sxtb</code>/<code>uxtb</code>, <code>ubfx</code>/<code>bfi</code>.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">5</div>
    <h3>Lectura guiada</h3>
    <p>Un archivo completo que combina todas las familias.</p>
  </div>
</div>

---

# Competencias

<div class="concept-grid vertical-center">
  <div class="concept-card">
    <h3>Competencia 1</h3>
    <p>
      Aplica el set de instrucciones ARM-64 utilizando instrucciones aritméticas,
      lógicas, de carga/almacenamiento, desplazamientos y rotaciones para
      construir programas funcionales que manipulen datos a nivel de registros
      y memoria.
    </p>
  </div>

  <div class="concept-card">
    <h3>Competencia 2</h3>
    <p>
      Analiza el comportamiento de arquitecturas modernas (ARM y RISC-V)
      utilizando simuladores como Gem5, QEMU, registros e instrucciones
      optimizando programas a bajo nivel en microprocesadores.
    </p>
  </div>
</div>

---

# Valor de la semana

<div class="callout tip">
  <strong>Precisión.</strong>
  Exactitud al escribir y ejecutar instrucciones a nivel de máquina.
</div>

<div class="concept-grid">
  <div class="concept-card">
    <h3>Aplicación en clase</h3>
    <p>
      Un bit equivocado en una máscara, un shift mal elegido o confundir
      <code>add</code> con <code>adds</code> produce resultados completamente
      diferentes. La precisión es la disciplina central de esta unidad.
    </p>
  </div>
</div>

---

# Qué buscamos hoy

<div class="slide-center-block">

<div class="objective-grid">
  <div v-click class="objective-item">
    <div class="item-number">1</div>
    <h3>Construir constantes</h3>
    <p>Distinguir <code>mov</code>, <code>movz</code>/<code>movk</code> y <code>ldr</code> desde memoria.</p>
  </div>

  <div v-click class="objective-item">
    <div class="item-number">2</div>
    <h3>Operar y marcar</h3>
    <p>Sumar, restar, comparar y decidir cuándo actualizar flags.</p>
  </div>

  <div v-click class="objective-item">
    <div class="item-number">3</div>
    <h3>Filtrar bits</h3>
    <p>Usar máscaras para encender, apagar, alternar y probar bits.</p>
  </div>

  <div v-click class="objective-item">
    <div class="item-number">4</div>
    <h3>Ajustar y extraer</h3>
    <p>Shifts, extensiones signed/unsigned y campos de bits.</p>
  </div>
</div>

</div>

---
layout: section
---

# Movimiento de constantes

Poner valores en registros no siempre significa leer memoria.

---
layout: center
class: text-center
---

<div class="big-question">
  <div class="muted">Pregunta de arranque</div>
  <h3>¿Por qué no basta con un solo mov para cualquier constante?</h3>
  <div class="question-points">
    <div v-click>Una instrucción A64 ocupa 32 bits.</div>
    <div v-click>Opcode + registros + inmediato deben caber ahí.</div>
    <div v-click>Constantes grandes necesitan múltiples instrucciones.</div>
  </div>
</div>

---

# Tres formas de obtener un valor

<div class="slide-center-block">

<div class="content-stack-lg">

```asm
mov x0, #42       // constante inmediata
ldr x1, =dato     // dirección o literal
ldr x2, [x1]      // contenido desde memoria
```

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>mov</code></h3>
    <p>Constante directa. No toca memoria.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>ldr =sym</code></h3>
    <p>Dirección de símbolo o literal.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>ldr [x1]</code></h3>
    <p>Contenido leído desde memoria (corchetes).</p>
  </div>
</div>

</div>

</div>

---

##### Construir constantes grandes: movz + movk

<div class="slide-center-block">

<div class="two-column-layout">

<div class="content-stack-md">

<div class="muted">Registro dividido en bloques de 16 bits</div>

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

</div>

<div class="content-stack-md">

<div class="muted">Valor paso a paso</div>

<div class="compare-grid compare-grid-stacked">
  <div v-click class="compare-card">
    <div class="card-kicker">movz</div>
    <ul>
      <li><code>0x0000000000007788</code></li>
      <li>Limpia + escribe bloque 0.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker">movk ×3</div>
    <ul>
      <li>Conserva (keep) y reemplaza.</li>
      <li>Final: <code>0x1122334455667788</code></li>
    </ul>
  </div>
</div>

</div>

</div>

</div>

---
layout: section
---

# Aritmética y flags

La pregunta no es solo "cuánto da", sino "quiero flags o no".

---

# add vs adds — sub vs subs

<div class="slide-center-block">

<div class="content-stack-lg">

```asm
add  x2, x0, x1    // guarda resultado, no toca NZCV
adds x3, x0, x1    // guarda resultado Y actualiza NZCV
```

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker">Sin <code>s</code></div>
    <ul>
      <li><code>add</code>, <code>sub</code>, <code>neg</code></li>
      <li>Solo resultado.</li>
      <li>Flags intactos.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker">Con <code>s</code></div>
    <ul>
      <li><code>adds</code>, <code>subs</code>, <code>negs</code></li>
      <li>Resultado + flags NZCV.</li>
      <li>Preparación para <code>b.cond</code>.</li>
    </ul>
  </div>
</div>

<div v-click class="callout warning centered-narrow">
Si usas <code>add</code> y luego esperas que <code>b.eq</code> funcione, tu razonamiento falla. Para actualizar flags usa <code>adds</code>, <code>subs</code> o <code>cmp</code>.
</div>

</div>

</div>

---

# cmp y cmn

<div class="slide-center-block">

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker"><code>cmp x0, x1</code></div>
    <ul>
      <li>Equivale a <code>subs xzr, x0, x1</code></li>
      <li>Actualiza flags como <code>x0 - x1</code>.</li>
      <li>Descarta el resultado.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker"><code>cmn x0, x1</code></div>
    <ul>
      <li>Equivale a <code>adds xzr, x0, x1</code></li>
      <li>Actualiza flags como <code>x0 + x1</code>.</li>
      <li>Descarta la suma.</li>
    </ul>
  </div>
</div>

</div>

---

# Carry vs Overflow

<div class="slide-center-block">

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker"><code>C</code> — Carry (unsigned)</div>
    <ul>
      <li>¿Hubo carry fuera del tamaño?</li>
      <li>Ejemplo: <code>0xFFFF...FF + 1</code></li>
      <li>Aritmética unsigned.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker"><code>V</code> — Overflow (signed)</div>
    <ul>
      <li>¿El resultado signed no cabe?</li>
      <li>Ejemplo: <code>0x7FFFFFFF + 1</code></li>
      <li>Aritmética signed.</li>
    </ul>
  </div>
</div>

<div v-click class="callout info centered-narrow">
<code>C</code> y <code>V</code> cuentan historias distintas sobre los mismos bits. <code>C</code> ayuda en unsigned. <code>V</code> ayuda en signed.
</div>

</div>

---
layout: section
---

# Lógica y máscaras

Bits como interruptores: selecciona, enciende, apaga, alterna y prueba.

---

# Operaciones lógicas fundamentales

<div class="slide-center-block">

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>and</code> — conservar</h3>
    <p><code>10101100 & 00001111 = 00001100</code></p>
  </div>
  <div v-click class="concept-card">
    <h3><code>orr</code> — encender</h3>
    <p><code>1000 | 0010 = 1010</code></p>
  </div>
  <div v-click class="concept-card">
    <h3><code>eor</code> — alternar</h3>
    <p><code>1010 ^ 0010 = 1000</code></p>
  </div>
  <div v-click class="concept-card">
    <h3><code>bic</code> — apagar</h3>
    <p><code>1111 & ~0100 = 1011</code></p>
  </div>
</div>

</div>

---

# tst: probar sin guardar

<div class="slide-center-block">

<div class="content-stack-lg">

```asm
tst x0, #1       // equivale a ands xzr, x0, #1
```

<div class="key-idea centered-narrow">

<code>tst</code> es para preguntar. <code>and</code> es para guardar. Ambos usan máscara, distinta intención.

</div>

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker">Recetas comunes</div>
    <ul>
      <li>Probar bit 0: <code>tst x0, #1</code></li>
      <li>Encender bit 3: <code>orr x0, x0, #0b1000</code></li>
      <li>Apagar bit 3: <code>bic x0, x0, #0b1000</code></li>
      <li>Conservar byte bajo: <code>and x1, x0, #0xFF</code></li>
    </ul>
  </div>
</div>

</div>

</div>

---
layout: section
---

# Shifts, extensiones y bitfields

Mover, escalar, agrandar y extraer campos dentro de registros.

---

# Shifts: lsl, lsr, asr, ror

<div class="slide-center-block">

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>lsl</code></h3>
    <p>Izquierda. Ceros por la derecha. ≈ multiplicar por 2^n.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>lsr</code></h3>
    <p>Derecha. Ceros por la izquierda. Unsigned/campos.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>asr</code></h3>
    <p>Derecha. Conserva bit de signo. Signed.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>ror</code></h3>
    <p>Rotación. Bits salen y regresan por el otro lado.</p>
  </div>
</div>

<div v-click class="callout warning centered-narrow">
No uses <code>lsr</code> esperando preservar signo. Para valores signed, usa <code>asr</code>.
</div>

</div>

---

# Extensiones signed vs unsigned

<div class="slide-center-block">

<div class="content-stack-lg">

```asm
mov  w8, #0xFF
uxtb w9, w8       // w9 = 0x000000FF (unsigned 255)
sxtb w10, w8      // w10 = 0xFFFFFFFF (signed -1)
```

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker"><code>uxtb</code> — unsigned</div>
    <ul>
      <li>Rellena con ceros.</li>
      <li><code>0xFF</code> → <code>255</code></li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker"><code>sxtb</code> — signed</div>
    <ul>
      <li>Extiende bit de signo.</li>
      <li><code>0xFF</code> → <code>-1</code></li>
    </ul>
  </div>
</div>

<div v-click class="callout info centered-narrow">
El byte no cambió. Cambió la extensión. Elegir mal produce valores completamente diferentes.
</div>

</div>

</div>

---

# Campos de bits: ubfx y bfi

<div class="slide-center-block">

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker"><code>ubfx x1, x0, #8, #4</code></div>
    <ul>
      <li>Extrae 4 bits desde bit 8.</li>
      <li>Rellena con ceros.</li>
      <li>No toca memoria.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker"><code>bfi x0, x3, #16, #8</code></div>
    <ul>
      <li>Inserta 8 bits bajos de <code>x3</code>.</li>
      <li>Los coloca desde bit 16.</li>
      <li>Conserva el resto de <code>x0</code>.</li>
    </ul>
  </div>
</div>

<div v-click class="callout info centered-narrow">
En bitfield, posiciones mueven la mirada dentro de un registro. No son offsets de memoria.
</div>

</div>

---

###### Checklist mental

<div class="slide-center-block">

<div class="reveal-list centered-narrow">
  <div v-click class="reveal-item">Puedo construir constantes con <code>mov</code>, <code>movz</code>/<code>movk</code>.</div>
  <div v-click class="reveal-item">Puedo distinguir <code>add</code> de <code>adds</code> y <code>sub</code> de <code>subs</code>.</div>
  <div v-click class="reveal-item">Puedo explicar N, Z, C y V.</div>
  <div v-click class="reveal-item">Puedo usar máscaras con <code>and</code>, <code>orr</code>, <code>eor</code>, <code>bic</code> y <code>tst</code>.</div>
  <div v-click class="reveal-item">Puedo distinguir <code>lsl</code>, <code>lsr</code>, <code>asr</code> y <code>ror</code>.</div>
  <div v-click class="reveal-item">Puedo elegir extensión signed o unsigned.</div>
  <div v-click class="reveal-item">Puedo extraer e insertar campos de bits.</div>
</div>

</div>

---

# Siguiente paso

<div class="slide-center-block">

<div class="flow-column">
  <div v-click class="flow-step">Constantes y aritmética dominadas</div>
  <div v-click class="flow-arrow">→</div>
  <div v-click class="flow-step">Máscaras, shifts y extensiones claros</div>
  <div v-click class="flow-arrow">→</div>
  <div v-click class="flow-step">Flags NZCV listos para condiciones</div>
  <div v-click class="flow-arrow">→</div>
  <div v-click class="flow-step">Control de flujo: branches, loops y decisiones</div>
</div>

</div>

---
layout: center
class: text-center
---

<div class="muted">Actividad de cierre</div>

# Preguntas de repaso

<div class="question-points mx-auto mt-6 max-w-2xl text-left">
  <div v-click>¿Qué diferencia hay entre <code>mov</code> y <code>ldr</code> desde memoria?</div>
  <div v-click>¿Por qué <code>add</code> no sirve para preparar un <code>b.eq</code>?</div>
  <div v-click>¿Qué instrucción usarías para probar si el bit 0 está encendido sin modificar el registro?</div>
  <div v-click>¿Cuál es la diferencia entre <code>lsr</code> y <code>asr</code>?</div>
  <div v-click>¿Por qué <code>uxtb</code> y <code>sxtb</code> dan resultados distintos para <code>0xFF</code>?</div>
</div>

---

###### Ejemplo Práctico

<div class="slide-center-block">

<div class="content-stack-lg">

<div class="key-idea centered-narrow">
  <div class="muted">Actividad guiada</div>
  <p>Leer y ejecutar un programa que combina constantes, aritmética, máscaras, shifts y bitfields.</p>
</div>

<div class="concept-grid concept-grid-4">
  <div v-click class="concept-card">
    <h3>Constantes</h3>
    <p><code>movz</code> + <code>movk</code> para armar <code>0x12345678</code>.</p>
  </div>

  <div v-click class="concept-card">
    <h3>Flags</h3>
    <p><code>subs</code> y <code>cmp</code>: ver cómo NZCV cambia.</p>
  </div>

  <div v-click class="concept-card">
    <h3>Máscaras</h3>
    <p><code>orr</code>, <code>bic</code>, <code>tst</code> y verificar con GDB.</p>
  </div>

  <div v-click class="concept-card">
    <h3>Bitfields</h3>
    <p><code>ubfx</code> para extraer un campo y comparar con <code>and</code>+<code>lsr</code>.</p>
  </div>
</div>

</div>

</div>

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
