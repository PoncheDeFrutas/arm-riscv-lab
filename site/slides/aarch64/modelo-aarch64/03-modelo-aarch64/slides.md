---
theme: default
class: text-left
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
title: "Unidad 03 · Modelo ARMv8-A / AArch64"
info: "Presentación de apoyo para la Unidad 03 de la ruta AArch64."
author: "ARM RISC-V Lab"
seoMeta:
  ogTitle: "Unidad 03 · Modelo ARMv8-A / AArch64"
  ogDescription: "Registros generales, registros especiales, flags, SIMD/FP y niveles de excepción como estado visible del procesador."
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

## Unidad 03
## Modelo ARMv8-A / AArch64

Qué estado puede observar un programa: registros, flags,
direcciones de ejecución y contexto de privilegios.

<div class="cover-note">
Unidad conceptual: registros generales, especiales, PSTATE/NZCV, SIMD/FP, exception levels y lectura con GDB.
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
    <h3>Registros generales</h3>
    <p><code>X0</code>–<code>X30</code>, <code>W0</code>–<code>W30</code> y zero-extension.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">2</div>
    <h3>Registros especiales</h3>
    <p><code>XZR</code>, <code>SP</code>, <code>PC</code>, <code>X29/FP</code> y <code>X30/LR</code>.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">3</div>
    <h3>PSTATE y flags NZCV</h3>
    <p>Comparaciones, condiciones y saltos condicionales.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">4</div>
    <h3>SIMD/FP y exception levels</h3>
    <p><code>V0</code>–<code>V31</code>, vistas por tamaño, EL0 a EL3.</p>
  </div>

  <div class="numbered-card">
    <div class="card-number">5</div>
    <h3>Lectura con GDB</h3>
    <p>Mirar registros sin sobreinterpretar.</p>
  </div>
</div>

---

# Competencias

<div class="concept-grid vertical-center">
  <div class="concept-card">
    <h3>Competencia 1</h3>
    <p>
      El estudiante desarrolla soluciones eficientes en sistemas computacionales
      integrando arquitectura de computadores, programación en bajo nivel y
      herramientas modernas de análisis y simulación para resolver problemas
      complejos en sistemas embebidos e IoT.
    </p>
  </div>

  <div class="concept-card">
    <h3>Competencia 2</h3>
    <p>
      Implementa sistemas embebidos orientados a IoT mediante el uso de
      Raspberry Pi, sensores digitales y comunicación con la nube para resolver
      problemas reales mediante automatización de procesos.
    </p>
  </div>
</div>

---

# Valor de la semana

<div class="callout tip">
  <strong>Aplicación.</strong>
  Capacidad de llevar teoría a la práctica.
</div>

<div class="concept-grid">
  <div class="concept-card">
    <h3>Aplicación en clase</h3>
    <p>
      Relacionar arquitectura con sistemas reales. Cada registro, flag y nivel
      de excepción que estudiamos aparece cuando depuras un programa AArch64
      en Linux.
    </p>
  </div>
</div>

---

# Qué buscamos hoy

<div class="slide-center-block">

<div class="objective-grid">
  <div v-click class="objective-item">
    <div class="item-number">1</div>
    <h3>Registros generales</h3>
    <p>Reconocer <code>Xn</code> y <code>Wn</code>, entender zero-extension al escribir en <code>Wn</code>.</p>
  </div>

  <div v-click class="objective-item">
    <div class="item-number">2</div>
    <h3>Registros especiales</h3>
    <p>Ubicar <code>SP</code>, <code>PC</code>, <code>FP</code>, <code>LR</code> y <code>XZR</code>.</p>
  </div>

  <div v-click class="objective-item">
    <div class="item-number">3</div>
    <h3>Flags NZCV</h3>
    <p>Entender qué señales dejan las comparaciones y cómo los usan los saltos.</p>
  </div>

  <div v-click class="objective-item">
    <div class="item-number">4</div>
    <h3>Mapa completo</h3>
    <p>Ubicar SIMD/FP, exception levels y leer registros con GDB.</p>
  </div>
</div>

</div>

---
layout: section
---

# Registros generales

31 registros de 64 bits: el lugar donde viven enteros, direcciones y resultados.

---
layout: center
class: text-center
---

<div class="big-question">
  <div class="muted">Pregunta de arranque</div>
  <h3>¿Son X0 y W0 registros separados?</h3>
  <div class="question-points">
    <div v-click>No. W0 son los 32 bits bajos de X0.</div>
    <div v-click>Escribir en W0 limpia los bits altos de X0.</div>
    <div v-click>Es el mismo registro visto con tamaños distintos.</div>
  </div>
</div>

---

# X0–X30 y W0–W30

<div class="slide-center-block">

<div class="content-stack-lg">

```bash
x0:
63                                32 31                                0
+-----------------------------------+-----------------------------------+
|          bits altos de x0          |                w0                 |
+-----------------------------------+-----------------------------------+
```

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker">Xn — 64 bits</div>
    <ul>
      <li>Registro completo.</li>
      <li>Enteros, direcciones, temporales.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker">Wn — 32 bits</div>
    <ul>
      <li>Parte baja de <code>Xn</code>.</li>
      <li>Operaciones de 32 bits.</li>
    </ul>
  </div>
</div>

</div>

</div>

---

# Zero-extension al escribir en Wn

<div class="slide-center-block">

<div class="content-stack-lg">

```asm
mov x0, #-1     // x0 = 0xFFFFFFFFFFFFFFFF
mov w0, #1      // x0 = 0x0000000000000001
```

<div class="key-idea centered-narrow">

Escribir en <code>Wn</code> limpia los 32 bits altos. No queda <code>0xFFFFFFFF00000001</code>.

</div>

<div v-click class="callout warning centered-narrow">
No dupliques mentalmente registros. <code>x0</code> y <code>w0</code> son el mismo registro visto con tamaños distintos.
</div>

</div>

</div>

---
layout: section
---

# Registros especiales

No todos los nombres se comportan como registros generales normales.

---

# XZR, SP, PC, FP y LR

<div class="slide-center-block">

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>xzr</code> / <code>wzr</code></h3>
    <p>Leer = cero. Escribir = descarta.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>sp</code></h3>
    <p>Stack pointer. Dirección del stack actual.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>pc</code></h3>
    <p>Program counter. Posición de ejecución. No es un Xn más.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>x29</code> / <code>fp</code></h3>
    <p>Frame pointer. Referencia en stack frames.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>x30</code> / <code>lr</code></h3>
    <p>Link register. Dirección de retorno.</p>
  </div>
</div>

</div>

---

# ¿Quién se puede usar como temporal?

<div class="slide-center-block">

<div class="two-column-layout">

<div class="content-stack-md">

<div class="muted">Sí se pueden usar</div>

<div class="compare-grid compare-grid-stacked">
  <div v-click class="compare-card">
    <div class="card-kicker">x0–x28</div>
    <ul>
      <li>Generales, como mapa inicial.</li>
      <li>ABI definirá roles después.</li>
    </ul>
  </div>
</div>

</div>

<div class="content-stack-md">

<div class="muted">Tienen reglas especiales</div>

<div class="compare-grid compare-grid-stacked">
  <div v-click class="compare-card">
    <div class="card-kicker">sp, pc, xzr</div>
    <ul>
      <li><code>sp</code> — no como general normal.</li>
      <li><code>pc</code> — no programable directamente.</li>
      <li><code>xzr</code> — no almacena.</li>
    </ul>
  </div>
</div>

</div>

</div>

</div>

---
layout: section
---

# PSTATE y flags NZCV

Señales de estado que ciertas instrucciones actualizan y otras consultan.

---

# Los cuatro flags

<div class="slide-center-block">

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>N</code> — Negative</h3>
    <p>¿El resultado tiene bit de signo encendido?</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>Z</code> — Zero</h3>
    <p>¿El resultado fue cero?</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>C</code> — Carry</h3>
    <p>¿Hubo carry / no borrow en unsigned?</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>V</code> — Overflow</h3>
    <p>¿Hubo overflow en signed?</p>
  </div>
</div>

<div v-click class="callout info centered-narrow">
Los flags no son registros generales. Son señales que <code>cmp</code>, <code>adds</code>, <code>subs</code> actualizan y que <code>b.cond</code> consulta.
</div>

</div>

---

# Comparar y saltar

<div class="slide-center-block">

<div class="content-stack-lg">

```asm
mov x0, #5
mov x1, #5
cmp x0, x1       // actualiza flags como x0 - x1
b.eq iguales     // salta si Z = 1 (igualdad)
```

<div class="compare-grid">
  <div v-click class="compare-card">
    <div class="card-kicker"><code>cmp x0, x1</code></div>
    <ul>
      <li>Resta internamente sin guardar resultado.</li>
      <li>Actualiza flags NZCV.</li>
    </ul>
  </div>
  <div v-click class="compare-card">
    <div class="card-kicker"><code>b.eq iguales</code></div>
    <ul>
      <li>Consulta flag Z.</li>
      <li>Salta si la comparación indicó igualdad.</li>
    </ul>
  </div>
</div>

<div v-click class="callout warning centered-narrow">
Flags no duran como variables. Una instrucción posterior puede cambiarlos.
</div>

</div>

</div>

---
layout: section
---

# SIMD/FP y exception levels

Banco vectorial y niveles de privilegio como mapa inicial.

---

# Registros V0–V31

<div class="slide-center-block">

<div class="content-stack-lg">

<div class="lead-block">
32 registros de 128 bits. No son Xn. Son otro banco.
</div>

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>bn</code> — 8 bits</h3>
    <p>Byte.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>hn</code> — 16 bits</h3>
    <p>Halfword.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>sn</code> — 32 bits</h3>
    <p>Single precision.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>dn</code> — 64 bits</h3>
    <p>Double precision.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>qn</code> — 128 bits</h3>
    <p>Quadword.</p>
  </div>
</div>

<div v-click class="callout-box">
<code>x0</code> y <code>d0</code> no son el mismo registro. Mismo número, bancos distintos.
</div>

</div>

</div>

---

# Exception levels: EL0 a EL3

<div class="slide-center-block">

<div class="concept-grid">
  <div v-click class="concept-card">
    <h3><code>EL0</code> — User mode</h3>
    <p>Programas de usuario. Aquí corren nuestros programas.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>EL1</code> — Kernel mode</h3>
    <p>Kernel del SO. Administra memoria, procesos, dispositivos.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>EL2</code> — Hypervisor</h3>
    <p>Virtualización.</p>
  </div>
  <div v-click class="concept-card">
    <h3><code>EL3</code> — Secure monitor</h3>
    <p>Transición secure / non-secure.</p>
  </div>
</div>

<div v-click class="callout info centered-narrow">
Tu programa usa registros generales en EL0. Linux corre en EL1. <code>svc #0</code> es el puente entre ambos.
</div>

</div>

---
layout: section
---

# Lectura con GDB

Mirar registros sin sobreinterpretar.

---

##### Comandos básicos de GDB

<div class="slide-center-block">

<div class="two-column-layout">

<div class="content-stack-md">

<div class="muted">Preparación</div>

```bash
make gdb           // terminal 1
gdb-multiarch build/main  // terminal 2
```

```bash
set architecture aarch64
target remote localhost:1234
break _start
continue
```

</div>

<div class="content-stack-md">

<div class="muted">Consultar estado</div>

<div class="compare-grid compare-grid-stacked">
  <div v-click class="compare-card">
    <div class="card-kicker">Registros</div>
    <ul>
      <li><code>info registers x0 x1 x8</code></li>
      <li><code>info registers sp pc</code></li>
      <li><code>info registers x29 x30</code></li>
    </ul>
  </div>

  <div v-click class="compare-card">
    <div class="card-kicker">Instrucciones</div>
    <ul>
      <li><code>x/4i $pc</code></li>
      <li><code>info registers cpsr</code></li>
    </ul>
  </div>
</div>

</div>

</div>

</div>

---

# Leer sin sobreinterpretar

<div class="slide-center-block">

<div class="content-stack-lg">

<div class="reveal-list centered-narrow">
  <div v-click class="reveal-item"><code>x0 = 0x1</code> → ¿Es entero, dirección o argumento?</div>
  <div v-click class="reveal-item"><code>sp = 0x...</code> → ¿A qué región de stack apunta?</div>
  <div v-click class="reveal-item"><code>pc = 0x...</code> → ¿Qué instrucción está por ejecutarse?</div>
  <div v-click class="reveal-item"><code>x30 = 0x...</code> → ¿Podría ser dirección de retorno?</div>
</div>

<div v-click class="callout info centered-narrow">
GDB muestra valores. El curso te enseña a interpretarlos con contexto: registro, tamaño, instrucción actual y memoria asociada.
</div>

</div>

</div>

---

# Checklist mental

<div class="slide-center-block">

<div class="reveal-list centered-narrow">
  <div v-click class="reveal-item">Puedo explicar <code>Xn</code> y <code>Wn</code> y zero-extension.</div>
  <div v-click class="reveal-item">Puedo ubicar <code>XZR</code>, <code>SP</code>, <code>PC</code>, <code>FP</code> y <code>LR</code>.</div>
  <div v-click class="reveal-item">Puedo nombrar y explicar <code>N</code>, <code>Z</code>, <code>C</code> y <code>V</code>.</div>
  <div v-click class="reveal-item">Puedo ubicar <code>V0</code>–<code>V31</code> como banco SIMD/FP.</div>
  <div v-click class="reveal-item">Puedo distinguir <code>EL0</code> de <code>EL1</code>.</div>
  <div v-click class="reveal-item">Puedo leer registros básicos con GDB.</div>
</div>

</div>

---

# Siguiente paso

<div class="slide-center-block">

<div class="flow-column">
  <div v-click class="flow-step">Registros generales y especiales</div>
  <div v-click class="flow-arrow">→</div>
  <div v-click class="flow-step">Flags NZCV y comparaciones</div>
  <div v-click class="flow-arrow">→</div>
  <div v-click class="flow-step">SIMD/FP y exception levels</div>
  <div v-click class="flow-arrow">→</div>
  <div v-click class="flow-step">GNU Assembly, directivas y primeros programas</div>
</div>

</div>

---
layout: center
class: text-center
---

<div class="muted">Actividad de cierre</div>

# Preguntas de repaso

<div class="question-points mx-auto mt-6 max-w-2xl text-left">
  <div v-click>¿Qué pasa con <code>x0</code> cuando escribes en <code>w0</code>?</div>
  <div v-click>¿<code>PC</code> se puede usar como registro general?</div>
  <div v-click>¿Qué flag se activa cuando el resultado de <code>cmp</code> es cero?</div>
  <div v-click>¿<code>x0</code> y <code>d0</code> son el mismo registro?</div>
  <div v-click>¿En qué exception level corre un programa de usuario en Linux?</div>
</div>

---

###### Ejemplo Práctico

###### Ejemplo Práctico

<div class="slide-center-block">

<div class="content-stack-lg">

<div class="key-idea centered-narrow">
  <div class="muted">Actividad guiada</div>
  <p>Observar registros, flags y estado del procesador con GDB en un programa mínimo.</p>
</div>

<div class="concept-grid concept-grid-4">
  <div v-click class="concept-card">
    <h3>Generales</h3>
    <p><code>info registers x0 x1 x8</code> y verificar valores.</p>
  </div>

  <div v-click class="concept-card">
    <h3>Especiales</h3>
    <p><code>info registers sp pc x29 x30</code></p>
  </div>

  <div v-click class="concept-card">
    <h3>Flags</h3>
    <p><code>info registers cpsr</code> y buscar NZCV.</p>
  </div>

  <div v-click class="concept-card">
    <h3>Instrucciones</h3>
    <p><code>x/4i $pc</code> para ver qué sigue.</p>
  </div>
</div>

</div>

</div>

---

# Fuentes

- Página Quarto: `site/courses/aarch64/modelo-aarch64/`
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- Larry D. Pyeatt y William Ughetta, *ARM 64-Bit Assembly Language*
- William Hohl y Christopher Hinds, *ARM Assembly Language: Fundamentals and Techniques*
- `gdb` / `gdb-multiarch` — lectura básica de estado
- Slidev, documentación oficial

---
layout: statement
---

# Dudas¿?

---
layout: center
---

# Gracias por tu atención
