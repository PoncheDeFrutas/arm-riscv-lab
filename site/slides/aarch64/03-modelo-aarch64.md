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
title: "Unidad 03 · Modelo ARMv8-A / AArch64"
info: "Presentación de apoyo para la Unidad 03 de la ruta AArch64."
author: "ARM RISC-V Lab"
---

<CoverSlide
  title="Unidad 03 · Modelo ARMv8-A / AArch64"
  subtitle="Arquitectura de Computadores y Ensambladores 1"
  note="Escuela de Ingeniería de Ciencias y Sistemas"
/>

---
layout: aarch64-section
---

# Bienvenidos a la Unidad 03

Qué estado puede observar un programa: registros, flags, direcciones de ejecución y contexto de privilegios

---

# Modelo ARMv8-A / AArch64

Unidad conceptual: registros generales, especiales, PSTATE/NZCV, SIMD/FP, exception levels y lectura con GDB.

### Agenda

<v-clicks>

1. **Registros generales** — `X0`–`X30`, `W0`–`W30` y zero-extension
2. **Registros especiales** — `XZR`, `SP`, `PC`, `X29/FP` y `X30/LR`
3. **PSTATE y flags NZCV** — Comparaciones, condiciones y saltos condicionales
4. **SIMD/FP y exception levels** — `V0`–`V31`, vistas por tamaño, EL0 a EL3
5. **Lectura con GDB** — Mirar registros sin sobreinterpretar

</v-clicks>

---

# Anuncios importantes

<InfoBox type="warning" title="Anuncios">

- **Anuncio 1** — Pendiente por definir

</InfoBox>

---

# Competencias del curso

<InfoBox type="info" title="Competencia 1">

El estudiante desarrolla soluciones eficientes en sistemas computacionales integrando arquitectura de computadores, programación en bajo nivel y herramientas modernas de análisis y simulación para resolver problemas complejos en sistemas embebidos e IoT.

</InfoBox>

<InfoBox type="info" title="Competencia 2">

Implementa sistemas embebidos orientados a IoT mediante el uso de Raspberry Pi, sensores digitales y comunicación con la nube para resolver problemas reales mediante automatización de procesos.

</InfoBox>

---

# Valor de la semana

<InfoBox type="note" title="Aplicación">

Capacidad de llevar teoría a la práctica.

</InfoBox>

### Aplicación en clase

Relacionar arquitectura con sistemas reales. Cada registro, flag y nivel de excepción que estudiamos aparece cuando depuras un programa AArch64 en Linux.

---

# Qué buscamos hoy

<StepList :steps="[
  'Registros generales — Reconocer Xn y Wn, entender zero-extension al escribir en Wn',
  'Registros especiales — Ubicar SP, PC, FP, LR y XZR',
  'Flags NZCV — Entender qué señales dejan las comparaciones y cómo los usan los saltos',
  'Mapa completo — Ubicar SIMD/FP, exception levels y leer registros con GDB'
]" />

---
layout: aarch64-section
---

# Registros generales

31 registros de 64 bits: el lugar donde viven enteros, direcciones y resultados

---
layout: aarch64-question
---

## ¿Son X0 y W0 registros separados?

<v-clicks>

- No. W0 son los 32 bits bajos de X0
- Escribir en W0 limpia los bits altos de X0
- Es el mismo registro visto con tamaños distintos

</v-clicks>

---

# X0–X30 y W0–W30

<div class="mascot-row">

<div class="mascot-content">

<CodeBlock title="Estructura de un registro Xn" lang="text">

```text
x0:
63                                32 31                                0
+-----------------------------------+-----------------------------------+
|          bits altos de x0          |                w0                 |
+-----------------------------------+-----------------------------------+
```

</CodeBlock>

<v-clicks>

- **Xn — 64 bits** — Registro completo. Enteros, direcciones, temporales
- **Wn — 32 bits** — Parte baja de `Xn`. Operaciones de 32 bits

</v-clicks>

</div>

<Mascot emotion="pensando" />

</div>

---

# Zero-extension al escribir en Wn

<CodeAnnotation :annotations="[
  { num: '1', text: 'x0 = -1 → todos los bits en 1 (0xFFFFFFFFFFFFFFFF)' },
  { num: '2', text: 'Escribir en w0 limpia los 32 bits altos → x0 = 0x0000000000000001' }
]">

```asm
mov x0, #-1     // 1
mov w0, #1      // 2
```

</CodeAnnotation>

<InfoBox type="note" title="Regla clave">

Escribir en `Wn` limpia los 32 bits altos. No queda `0xFFFFFFFF00000001`. No dupliques mentalmente registros. `x0` y `w0` son el mismo registro visto con tamaños distintos.

</InfoBox>

---
layout: aarch64-section
---

# Registros especiales

No todos los nombres se comportan como registros generales normales

---

# XZR, SP, PC, FP y LR

<div class="mascot-row">

<div class="mascot-content">

<v-clicks>

- `xzr` / `wzr` — Leer = cero. Escribir = descarta
- `sp` — Stack pointer. Dirección del stack actual
- `pc` — Program counter. Posición de ejecución. No es un Xn más
- `x29` / `fp` — Frame pointer. Referencia en stack frames
- `x30` / `lr` — Link register. Dirección de retorno

</v-clicks>

</div>

<Mascot emotion="leyendo" />

</div>

---
layout: aarch64-two-cols
---

# ¿Quién se puede usar como temporal?

::left::

### Sí se pueden usar

- `x0`–`x28` — Generales, como mapa inicial
- ABI definirá roles después

::right::

### Tienen reglas especiales

- `sp` — No como general normal
- `pc` — No programable directamente
- `xzr` — No almacena valores

---
layout: aarch64-section
---

# PSTATE y flags NZCV

Señales de estado que ciertas instrucciones actualizan y otras consultan

---

# Los cuatro flags

<v-clicks>

- `N` — Negative — ¿El resultado tiene bit de signo encendido?
- `Z` — Zero — ¿El resultado fue cero?
- `C` — Carry — ¿Hubo carry / no borrow en unsigned?
- `V` — Overflow — ¿Hubo overflow en signed?

</v-clicks>

<InfoBox type="note" title="Importante">

Los flags no son registros generales. Son señales que `cmp`, `adds`, `subs` actualizan y que `b.cond` consulta.

</InfoBox>

---

# Comparar y saltar

<CodeAnnotation :annotations="[
  { num: '1', text: 'x0 = 5' },
  { num: '2', text: 'x1 = 5' },
  { num: '3', text: 'cmp: resta internamente sin guardar resultado, actualiza flags NZCV' },
  { num: '4', text: 'b.eq: consulta flag Z. Salta si Z = 1 (igualdad)' }
]">

```asm
mov x0, #5
mov x1, #5
cmp x0, x1       // 3
b.eq iguales     // 4
```

</CodeAnnotation>

<InfoBox type="warning" title="Cuidado">

Flags no duran como variables. Una instrucción posterior puede cambiarlos.

</InfoBox>

---
layout: aarch64-section
---

# SIMD/FP y exception levels

Banco vectorial y niveles de privilegio como mapa inicial

---

# Registros V0–V31

32 registros de 128 bits. No son Xn. Son otro banco.

<v-clicks>

- `bn` — 8 bits — Byte
- `hn` — 16 bits — Halfword
- `sn` — 32 bits — Single precision
- `dn` — 64 bits — Double precision
- `qn` — 128 bits — Quadword

</v-clicks>

<InfoBox type="note" title="Importante">

`x0` y `d0` no son el mismo registro. Mismo número, bancos distintos.

</InfoBox>

---

# Exception levels: EL0 a EL3

<v-clicks>

- `EL0` — User mode — Programas de usuario. Aquí corren nuestros programas
- `EL1` — Kernel mode — Kernel del SO. Administra memoria, procesos, dispositivos
- `EL2` — Hypervisor — Virtualización
- `EL3` — Secure monitor — Transición secure / non-secure

</v-clicks>

<InfoBox type="info" title="Contexto del curso">

Tu programa usa registros generales en EL0. Linux corre en EL1. `svc #0` es el puente entre ambos.

</InfoBox>

---
layout: aarch64-section
---

# Lectura con GDB

Mirar registros sin sobreinterpretar

---

# Comandos básicos de GDB

::code-group

```bash [Preparación]
make gdb                    # terminal 1
gdb-multiarch build/main    # terminal 2

set architecture aarch64
target remote localhost:1234
break _start
continue
```

```bash [Consultar estado]
# Registros generales
info registers x0 x1 x8

# Registros especiales
info registers sp pc
info registers x29 x30

# Flags NZCV
info registers cpsr

# Próximas instrucciones
x/4i $pc
```

::

---

# Leer sin sobreinterpretar

<div class="mascot-row">

<div class="mascot-content">

<v-clicks>

- `x0 = 0x1` → ¿Es entero, dirección o argumento?
- `sp = 0x...` → ¿A qué región de stack apunta?
- `pc = 0x...` → ¿Qué instrucción está por ejecutarse?
- `x30 = 0x...` → ¿Podría ser dirección de retorno?

</v-clicks>

</div>

<Mascot emotion="confundido" />

</div>

<InfoBox type="info" title="Meta del curso">

GDB muestra valores. El curso te enseña a interpretarlos con contexto: registro, tamaño, instrucción actual y memoria asociada.

</InfoBox>

---
layout: aarch64-checklist
---

### Checklist mental

<div class="mascot-row">

<div class="mascot-content">

- <span class="check-icon">✓</span> Puedo explicar `Xn` y `Wn` y zero-extension
- <span class="check-icon">✓</span> Puedo ubicar `XZR`, `SP`, `PC`, `FP` y `LR`
- <span class="check-icon">✓</span> Puedo nombrar y explicar `N`, `Z`, `C` y `V`
- <span class="check-icon">✓</span> Puedo ubicar `V0`–`V31` como banco SIMD/FP
- <span class="check-icon">✓</span> Puedo distinguir `EL0` de `EL1`
- <span class="check-icon">✓</span> Puedo leer registros básicos con GDB

</div>

<Mascot emotion="solucionado" />

</div>

---
layout: aarch64-statement
---

# Siguiente paso: Registros generales y especiales → Flags NZCV y comparaciones → SIMD/FP y exception levels → GNU Assembly, directivas y primeros programas

---
layout: aarch64-question
---

## Preguntas de repaso

<div class="mascot-row">

<div class="mascot-content">

<v-clicks>

- ¿Qué pasa con `x0` cuando escribes en `w0`?
- ¿`PC` se puede usar como registro general?
- ¿Qué flag se activa cuando el resultado de `cmp` es cero?
- ¿`x0` y `d0` son el mismo registro?
- ¿En qué exception level corre un programa de usuario en Linux?

</v-clicks>

</div>

<Mascot emotion="pensando" />

</div>

---

# Ejemplo práctico

Observar registros, flags y estado del procesador con GDB en un programa mínimo.

<StepList :steps="[
  'Generales — info registers x0 x1 x8 y verificar valores',
  'Especiales — info registers sp pc x29 x30',
  'Flags — info registers cpsr y buscar NZCV',
  'Instrucciones — x/4i $pc para ver qué sigue'
]" />

---

# Fuentes

- Página Quarto: `site/courses/aarch64/modelo-aarch64/`
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- Larry D. Pyeatt y William Ughetta, *ARM 64-Bit Assembly Language*
- William Hohl y Christopher Hinds, *ARM Assembly Language: Fundamentals and Techniques*
- `gdb` / `gdb-multiarch` — lectura básica de estado
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
