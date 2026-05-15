---
theme: default
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
comark: true
clickAnimation: up
magicMoveCopy: 'final'
title: "Unidad 07 · Aritmética, lógica, flags y bits"
info: "Presentación de apoyo para la Unidad 07 de la ruta AArch64."
author: "ARM RISC-V Lab"
---

<CoverSlide
  title="Unidad 07 · Aritmética, lógica, flags y bits"
  subtitle="Arquitectura de Computadores y Ensambladores 1"
  note="Escuela de Ingeniería de Ciencias y Sistemas"
/>

---
layout: aarch64-section
---

# Aritmética, lógica, flags y bits

Opera valores en registros, actualiza NZCV y manipula bits antes de escribir branches y loops.

Unidad práctica: constantes, aritmética, flags, lógica/máscaras, shifts, extensiones y campos de bits.

---

# Anuncios importantes

<InfoBox type="warning" title="Anuncios">

- **Anuncio 1**

</InfoBox>

---

# Agenda

<v-clicks>

1. **Movimiento de constantes** — `mov`, `movz`, `movk`, `movn` y bloques de 16 bits.
2. **Aritmética y flags** — `add`/`adds`, `sub`/`subs`, `cmp`, `cmn` y NZCV.
3. **Lógica y máscaras** — `and`, `orr`, `eor`, `bic`, `tst` y operaciones bit a bit.
4. **Shifts, extensiones y bitfields** — `lsl`, `lsr`, `asr`, `ror`, `sxtb`/`uxtb`, `ubfx`/`bfi`.
5. **Lectura guiada** — Un archivo completo que combina todas las familias.

</v-clicks>

---

# Competencias

<InfoBox type="info" title="Competencia 1">

Aplica el set de instrucciones ARM-64 utilizando instrucciones aritméticas, lógicas, de carga/almacenamiento, desplazamientos y rotaciones para construir programas funcionales que manipulen datos a nivel de registros y memoria.

</InfoBox>

<InfoBox type="info" title="Competencia 2">

Analiza el comportamiento de arquitecturas modernas (ARM y RISC-V) utilizando simuladores como Gem5, QEMU, registros e instrucciones optimizando programas a bajo nivel en microprocesadores.

</InfoBox>

---

# Valor de la semana

<InfoBox type="note" title="Precisión">

Exactitud al escribir y ejecutar instrucciones a nivel de máquina.

Un bit equivocado en una máscara, un shift mal elegido o confundir `add` con `adds` produce resultados completamente diferentes. La precisión es la disciplina central de esta unidad.

</InfoBox>

---

# Qué buscamos hoy

<StepList :steps="[
  'Construir constantes: distinguir mov, movz/movk y ldr desde memoria',
  'Operar y marcar: sumar, restar, comparar y decidir cuándo actualizar flags',
  'Filtrar bits: usar máscaras para encender, apagar, alternar y probar bits',
  'Ajustar y extraer: shifts, extensiones signed/unsigned y campos de bits'
]" />

---
layout: aarch64-section
---

# Movimiento de constantes

Poner valores en registros no siempre significa leer memoria.

---
layout: aarch64-question
---

## ¿Por qué no basta con un solo mov para cualquier constante?

- Una instrucción A64 ocupa 32 bits.
- Opcode + registros + inmediato deben caber ahí.
- Constantes grandes necesitan múltiples instrucciones.

---

# Tres formas de obtener un valor

<CodeAnnotation :annotations="[
  { num: '1', text: 'Constante directa: no toca memoria' },
  { num: '2', text: 'Dirección de símbolo o literal pool' },
  { num: '3', text: 'Contenido leído desde memoria (corchetes)' }
]">

```asm {1|2|3}
mov x0, #42       // constante inmediata
ldr x1, =dato     // dirección o literal
ldr x2, [x1]      // contenido desde memoria
```

</CodeAnnotation>

---

# Construir constantes grandes: movz + movk

<CodeBlock title="Registro x0 dividido en bloques de 16 bits" lang="bash">

```bash
x0:
[ 63..48 ][ 47..32 ][ 31..16 ][ 15..0 ]
```

</CodeBlock>

<CodeAnnotation :annotations="[
  { num: '1', text: 'Limpia + escribe bloque 0: 0x0000000000007788' },
  { num: '2', text: 'Conserva y reemplaza bloque 1 (lsl #16)' },
  { num: '3', text: 'Conserva y reemplaza bloque 2 (lsl #32)' },
  { num: '4', text: 'Conserva y reemplaza bloque 3 (lsl #48)' }
]">

```asm {1|2|3|4}
movz x0, #0x7788           // base limpia
movk x0, #0x5566, lsl #16  // bloque 1
movk x0, #0x3344, lsl #32  // bloque 2
movk x0, #0x1122, lsl #48  // bloque 3
```

</CodeAnnotation>

<div class="mascot-row mt-4">
<Mascot emotion="idea" />
</div>

<InfoBox type="note" title="Resultado">

Final: `0x1122334455667788`. `movz` limpia y escribe. `movk` conserva (keep) y reemplaza.

</InfoBox>

---
layout: aarch64-section
---

# Aritmética y flags

La pregunta no es solo "cuánto da", sino "quiero flags o no".

---

# add vs adds — sub vs subs

<CodeAnnotation :annotations="[
  { num: '1', text: 'Guarda resultado, NO toca NZCV' },
  { num: '2', text: 'Guarda resultado Y actualiza NZCV' }
]">

```asm {1|2}
add  x2, x0, x1    // guarda resultado, no toca NZCV
adds x3, x0, x1    // guarda resultado Y actualiza NZCV
```

</CodeAnnotation>

<v-clicks>

- **Sin `s`** — `add`, `sub`, `neg`. Solo resultado. Flags intactos
- **Con `s`** — `adds`, `subs`, `negs`. Resultado + flags NZCV. Preparación para `b.cond`

</v-clicks>

<InfoBox type="warning" title="Cuidado">

Si usas `add` y luego esperas que `b.eq` funcione, tu razonamiento falla. Para actualizar flags usa `adds`, `subs` o `cmp`.

</InfoBox>

---

# cmp y cmn

<v-clicks>

- `cmp x0, x1` — Equivale a `subs xzr, x0, x1`. Actualiza flags como `x0 - x1`. Descarta el resultado
- `cmn x0, x1` — Equivale a `adds xzr, x0, x1`. Actualiza flags como `x0 + x1`. Descarta la suma

</v-clicks>

<InfoBox type="note" title="Nota">

Ambas instrucciones actualizan flags pero descartan el resultado. Usan `xzr` (zero register) como destino.

</InfoBox>

---
layout: aarch64-two-cols
---

# Carry vs Overflow

::left::

### Carry (C) — Unsigned

- ¿Hubo carry fuera del tamaño?
- Ejemplo: `0xFFFF...FF + 1`
- Aritmética sin signo
- Importante para comparaciones unsigned

::right::

### Overflow (V) — Signed

- ¿El resultado signed no cabe?
- Ejemplo: `0x7FFFFFFF + 1`
- Aritmética con signo
- Importante para comparaciones signed

<div class="mascot-row mt-4">
<Mascot emotion="confundido" />
</div>

<InfoBox type="note" title="Concepto clave">

`C` y `V` cuentan historias distintas sobre los mismos bits. `C` ayuda en unsigned. `V` ayuda en signed.

</InfoBox>

---
layout: aarch64-section
---

# Lógica y máscaras

Bits como interruptores: selecciona, enciende, apaga, alterna y prueba.

---

# Operaciones lógicas: AND y ORR

<div class="grid grid-cols-2 gap-4">

<InstructionCard
  mnemonic="AND"
  name="Bitwise AND"
  syntax="AND Xd, Xn, Xm"
  description="Conserva solo los bits donde ambos operandos tienen 1."
  :example="{ code: 'and x1, x0, #0xFF', explanation: 'Conserva byte bajo de x0' }"
/>

<InstructionCard
  mnemonic="ORR"
  name="Bitwise OR"
  syntax="ORR Xd, Xn, Xm"
  description="Enciende bits donde cualquiera de los operandos tiene 1."
  :example="{ code: 'orr x0, x0, #0b1000', explanation: 'Enciende bit 3' }"
/>

</div>

---

# Operaciones lógicas: EOR y BIC

<div class="grid grid-cols-2 gap-4">

<InstructionCard
  mnemonic="EOR"
  name="Bitwise XOR"
  syntax="EOR Xd, Xn, Xm"
  description="Alterna bits donde los operandos difieren."
  :example="{ code: 'eor x0, x0, #0b1000', explanation: 'Alterna bit 3' }"
/>

<InstructionCard
  mnemonic="BIC"
  name="Bit Clear"
  syntax="BIC Xd, Xn, Xm"
  description="Apaga bits: Xd = Xn & ~Xm."
  :example="{ code: 'bic x0, x0, #0b1000', explanation: 'Apaga bit 3' }"
/>

</div>

---

# tst: probar sin guardar

<CodeBlock title="Probar bits sin modificar registros" lang="asm">

```asm
tst x0, #1       // equivale a ands xzr, x0, #1
```

</CodeBlock>

<ComparisonTable
  :headers="['Instrucción', 'Destino', 'Flags', 'Intención']"
  :rows='[
    ["tst x0, #1", "xzr (descarta)", "Actualiza NZ", "Probar bits"],
    ["and x1, x0, #1", "x1 (guarda)", "No actualiza", "Guardar resultado"]
  ]'
/>

<InfoBox type="note" title="Recetas comunes">

- Probar bit 0: `tst x0, #1`
- Encender bit 3: `orr x0, x0, #0b1000`
- Apagar bit 3: `bic x0, x0, #0b1000`
- Conservar byte bajo: `and x1, x0, #0xFF`

</InfoBox>

---
layout: aarch64-section
---

# Shifts, extensiones y bitfields

Mover, escalar, agrandar y extraer campos dentro de registros.

---

# Shifts: lsl, lsr, asr, ror

<v-clicks>

- `lsl` — Izquierda. Ceros por la derecha. ≈ multiplicar por 2^n
- `lsr` — Derecha. Ceros por la izquierda. Unsigned/campos
- `asr` — Derecha. Conserva bit de signo. Signed
- `ror` — Rotación. Bits salen y regresan por el otro lado

</v-clicks>

<InfoBox type="warning" title="Cuidado">

No uses `lsr` esperando preservar signo. Para valores signed, usa `asr`.

</InfoBox>

---

# Extensiones signed vs unsigned

<CodeAnnotation :annotations="[
  { num: '1', text: 'Valor original de 8 bits: 0xFF' },
  { num: '2', text: 'unsigned: rellena con ceros → 255' },
  { num: '3', text: 'signed: extiende bit de signo → -1' }
]">

```asm {1|2|3}
mov  w8, #0xFF
uxtb w9, w8       // w9 = 0x000000FF (unsigned 255)
sxtb w10, w8      // w10 = 0xFFFFFFFF (signed -1)
```

</CodeAnnotation>

<ComparisonTable
  :headers="['Instrucción', 'Tipo', '0xFF → wN', 'Significado']"
  :rows='[
    ["uxtb w9, w8", "unsigned", "0x000000FF", "255"],
    ["sxtb w10, w8", "signed", "0xFFFFFFFF", "-1"]
  ]'
/>

<InfoBox type="note" title="Concepto clave">

El byte no cambió. Cambió la extensión. Elegir mal produce valores completamente diferentes.

</InfoBox>

---

# Campos de bits: ubfx y bfi

<v-clicks>

- `ubfx x1, x0, #8, #4` — Extrae 4 bits desde bit 8. Rellena con ceros. No toca memoria
- `bfi x0, x3, #16, #8` — Inserta 8 bits bajos de `x3`. Los coloca desde bit 16. Conserva el resto de `x0`

</v-clicks>

<InfoBox type="note" title="Importante">

En bitfield, posiciones mueven la mirada dentro de un registro. No son offsets de memoria.

</InfoBox>

---
layout: aarch64-checklist
---

# Checklist mental

- <span class="check-icon">✓</span> Puedo construir constantes con `mov`, `movz`/`movk`
- <span class="check-icon">✓</span> Puedo distinguir `add` de `adds` y `sub` de `subs`
- <span class="check-icon">✓</span> Puedo explicar N, Z, C y V
- <span class="check-icon">✓</span> Puedo usar máscaras con `and`, `orr`, `eor`, `bic` y `tst`
- <span class="check-icon">✓</span> Puedo distinguir `lsl`, `lsr`, `asr` y `ror`
- <span class="check-icon">✓</span> Puedo elegir extensión signed o unsigned
- <span class="check-icon">✓</span> Puedo extraer e insertar campos de bits

<div class="mascot-row mt-4">
<Mascot emotion="solucionado" />
</div>

---
layout: aarch64-statement
---

# Siguiente paso

Constantes y aritmética dominadas → Máscaras, shifts y extensiones claros → Flags NZCV listos para condiciones → Control de flujo: branches, loops y decisiones

---
layout: aarch64-question
---

## Preguntas de repaso

- ¿Qué diferencia hay entre `mov` y `ldr` desde memoria?
- ¿Por qué `add` no sirve para preparar un `b.eq`?
- ¿Qué instrucción usarías para probar si el bit 0 está encendido sin modificar el registro?
- ¿Cuál es la diferencia entre `lsr` y `asr`?
- ¿Por qué `uxtb` y `sxtb` dan resultados distintos para `0xFF`?

<div class="mascot-row mt-4">
<Mascot emotion="pensando" />
</div>

---

# Ejemplo práctico

Leer y ejecutar un programa que combina constantes, aritmética, máscaras, shifts y bitfields.

<StepList :steps="[
  'Constantes: movz + movk para armar 0x12345678',
  'Flags: subs y cmp: ver cómo NZCV cambia',
  'Máscaras: orr, bic, tst y verificar con GDB',
  'Bitfields: ubfx para extraer un campo y comparar con and+lsr'
]" />

---

# Fuentes

- Página Quarto: `site/courses/aarch64/aritmetica-logica-bits/`
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- Larry D. Pyeatt y William Ughetta, *ARM 64-Bit Assembly Language*
- William Hohl y Christopher Hinds, *ARM Assembly Language: Fundamentals and Techniques*
- Arm, *Arm Architecture Reference Manual for A-profile architecture*
- Slidev, documentación oficial

---
layout: aarch64-statement
---

# ¿Dudas?

---

<CoverSlide
  title="Gracias por tu atención"
  subtitle="Arquitectura de Computadores y Ensambladores 1"
/>
