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
title: "Semana de Diagnóstico"
info: "Presentación inicial del curso, presentación del tutor y evaluación diagnóstica."
author: "ARM RISC-V Lab"
---

<CoverSlide
  title="Semana de Diagnóstico"
  subtitle="Arquitectura de Computadores y Ensambladores 1"
  note="Escuela de Ingeniería de Ciencias y Sistemas"
/>

---
layout: aarch64-section
---

# Bienvenidos al Curso

Conocernos y preparar el terreno para el semestre

---

# Semana de Diagnóstico

Sesión inicial para establecer dinámicas de trabajo, presentar el programa y evaluar los conocimientos previos.

### Objetivos del día

<v-clicks>

1. **Conocernos** — Tutor y estudiantes
2. **Diagnóstico** — Evaluación de conocimientos previos (sin impacto en nota)
3. **Organización** — Censo de horarios de calificación
4. **Programa** — Contenido general del semestre
5. **Evaluación del Curso** — Evaluación de conocimientos del curso
6. **Tarea** — Preparación del entorno para la próxima semana

</v-clicks>

---
layout: aarch64-section
---

# Presentaciones

Conocernos antes de empezar

---

# Tutor del Laboratorio

<InfoBox type="info" title="Diego Josue Guevara Abaj">

- **Email:** 3663830780101@ingenieria.usac.edu.gt
- **Perfil:** Estudiante de Ingeniería en Ciencias y Sistemas

Estoy aquí para apoyarlos a dominar la Arquitectura AArch64 y el lenguaje Ensamblador.

</InfoBox>

---
layout: aarch64-question
---

## ¿Quiénes son ustedes?

<v-clicks>

- Nombre completo
- ¿Qué expectativas tienen del curso?
- ¿Tienen experiencia previa con programación a bajo nivel (C / C++)?

</v-clicks>

<Mascot emotion="contento" />

---
layout: aarch64-section
---

# Evaluación de Conocimientos Previos

Primera evaluación diagnóstica

---

# Evaluación Diagnóstica

<InfoBox type="note" title="Sin impacto en la nota final">

Esta evaluación **no tiene impacto** en su nota final. Nos sirve como punto de partida para saber qué conceptos base debemos reforzar.

</InfoBox>

### Acceder a la evaluación

<v-click>

<div class="flex flex-col items-center gap-4 mt-6">

<a href="https://wayground.com/admin/quiz/693362a7f46f29bf90f27780" target="_blank" class="link-button">
<span class="link-icon">📝</span>
<span class="link-label">Evaluación de Conocimientos Previos</span>
<span class="link-url">wayground.com</span>
</a>

</div>

</v-click>

<Mascot emotion="confundido" />

---
layout: aarch64-section
---

# Organización del Curso

Coordinación y logística

---

# Censo de Horarios de Calificación

A lo largo del semestre revisaremos prácticas y proyectos.

<v-click>

Necesitamos coordinar **horarios disponibles** para organizar los turnos de revisión.

</v-click>

<v-click>

<InfoBox type="warning" title="¿Cuándo están disponibles?">

Indiquen sus horarios libres para agendar las revisiones de prácticas y proyectos.

</InfoBox>

</v-click>

---
layout: aarch64-section
---

# Programa del Curso

Contenido general del semestre

---

# Contenido a Aprender

<StepList :steps="[
  'Bases Binarias y Representación de Datos',
  'AArch64: Arquitectura, Registros y Modelo de Ejecución',
  'Ensamblador GNU: Directivas y Control de Flujo',
  'La Pila (Stack) y Convenciones de Llamada (AAPCS64)',
  'Memoria Virtual, Heap, y Syscalls (Linux API)',
  'Linking (Archivos ELF) y Debugging (GDB + strace)'
]" />

---
layout: aarch64-section
---

# Evaluación de Conocimientos del Curso

Segunda evaluación diagnóstica

---

# Evaluación del Curso

<InfoBox type="note" title="Sin impacto en la nota final">

Esta evaluación **no tiene impacto** en su nota final. Nos ayuda a medir qué tanto saben sobre los temas que veremos en el semestre.

</InfoBox>

### Acceder a la evaluación

<v-click>

<div class="flex flex-col items-center gap-4 mt-6">

<a href="https://wayground.com/admin/quiz/693368fcccefe4e38cf3ae37" target="_blank" class="link-button">
<span class="link-icon">📝</span>
<span class="link-label">Evaluación de Conocimientos del Curso</span>
<span class="link-url">wayground.com</span>
</a>

</div>

</v-click>

---
layout: aarch64-statement
---

# El diagnóstico no es un examen, es un mapa

<Mascot emotion="contento" />

---
layout: aarch64-section
---

# Tarea de Fortalecimiento

Preparación del entorno para la próxima semana

---

# Preparación del Entorno

<InfoBox type="note" title="Tarea para la próxima semana">

Para arrancar sin demoras técnicas, deberán configurar su entorno de trabajo.

</InfoBox>

### Qué instalar

<v-clicks>

- **Linux** — WSL, Máquina Virtual o Nativo
- **Toolchain AArch64** — GCC / Binutils
- **QEMU** — Emulador user mode para x86_64

</v-clicks>

---

# Checklist de Instalación

Verifiquen que todo funcione antes de la próxima clase:

<v-clicks>

- <span class="check-icon">✓</span> Linux instalado y funcionando
- <span class="check-icon">✓</span> `aarch64-linux-gnu-gcc` disponible
- <span class="check-icon">✓</span> `aarch64-linux-gnu-as` disponible
- <span class="check-icon">✓</span> `qemu-aarch64` disponible
- <span class="check-icon">✓</span> Editor de código configurado

</v-clicks>

---
layout: aarch64-checklist
---

### Checklist mental

- <span class="check-icon">✓</span> Conozco al tutor y mis compañeros
- <span class="check-icon">✓</span> Completé la evaluación de conocimientos previos
- <span class="check-icon">✓</span> Completé la evaluación de conocimientos del curso
- <span class="check-icon">✓</span> Registré mis horarios disponibles
- <span class="check-icon">✓</span> Entiendo el contenido del curso
- <span class="check-icon">✓</span> Sé qué instalar para la próxima clase

<Mascot emotion="solucionado" />

---

<ActivityRegister />

---
layout: aarch64-statement
---

# ¿Dudas?

---

<CoverSlide
  title="Gracias por su atención"
  subtitle="Arquitectura de Computadores y Ensambladores 1"
/>
