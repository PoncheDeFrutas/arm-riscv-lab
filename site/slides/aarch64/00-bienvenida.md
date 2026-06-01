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
title: "Bienvenida al Curso"
info: "Presentacion de bienvenida, organizacion inicial, programa, evaluacion, grupos y entorno de trabajo."
author: "ARM RISC-V Lab"
---

<CoverSlide
  title="Bienvenida al curso"
  subtitle="ARM64 / AArch64 - Arquitectura de Computadores y Ensambladores 1"
  note="Auxiliar: Diego Josue Guevara Abaj"
/>

<!--
Abrir con tono formal. Enfatizar que la sesion fija acuerdos de trabajo y expectativas del curso.
-->

---
layout: aarch64-section
---

# Inicio del Curso

Organizacion, expectativas y preparacion tecnica

---

# Bienvenidos

Esta primera sesion sirve para establecer como trabajaremos durante el curso.

<InfoBox type="info" title="Enfoque">

El curso combina conceptos de arquitectura con programacion practica en **AArch64**.

</InfoBox>

<v-clicks>

- Entenderemos como piensa una arquitectura de 64 bits
- Escribiremos codigo de bajo nivel con disciplina
- Usaremos herramientas reales de compilacion, emulacion y depuracion
- Trabajaremos en proyectos como evidencia principal del aprendizaje

</v-clicks>

<Mascot emotion="contento" />

<!--
No presentar esto como una clase teorica aislada. Conectar desde el inicio teoria, practica y proyectos.
-->

---
layout: aarch64-section
---

# Presentacion del Auxiliar

Rol dentro del laboratorio

---

# Auxiliar del Curso

<InfoBox type="info" title="Diego Josue Guevara Abaj">

- **Email:** 3663830780101@ingenieria.usac.edu.gt
- **Perfil:** Estudiante de Ingenieria en Ciencias y Sistemas
- **Rol:** apoyo academico, resolucion de dudas y acompanamiento tecnico

</InfoBox>

### Como puedo apoyar

<v-clicks>

- Aclarar conceptos de ARM64 / AArch64
- Orientar configuracion del entorno
- Revisar errores comunes de ensamblador y herramientas
- Dar retroalimentacion sobre proyectos y practicas
- Apoyar la organizacion del trabajo en grupo

</v-clicks>

<!--
Si existe canal oficial adicional, mencionarlo verbalmente aqui. Mantener email como referencia escrita.
-->

---
layout: aarch64-section
---

# Objetivos del Dia

Que debe quedar claro al terminar

---

# Agenda Inicial

<StepList :steps="[
  'Dar la bienvenida al curso',
  'Explicar la organizacion general',
  'Revisar el programa del curso',
  'Presentar la forma de evaluacion',
  'Explicar fechas importantes',
  'Organizar grupos de trabajo',
  'Preparar el entorno de trabajo',
  'Resolver dudas iniciales'
]" />

<Mascot emotion="leyendo" />

---
layout: aarch64-section
---

# Programa del Curso

Ruta general de aprendizaje

---

# Que Estudiaremos

<StepList :steps="[
  'Introduccion a ARM64 / AArch64',
  'Registros y modelo de ejecucion',
  'Memoria y direccionamiento',
  'Instrucciones basicas',
  'Syscalls en Linux',
  'Control de flujo',
  'Funciones y stack frames',
  'Organizacion de proyectos',
  'Buenas practicas de desarrollo en bajo nivel'
]" />

<!--
Presentar como mapa, no como lista exhaustiva. La profundidad vendra en sesiones posteriores.
-->

---

# Mapa del Curso

<div class="two-col">
<div>

### Fundamentos

<v-clicks>

- Arquitectura AArch64
- Registros `x0` - `x30`
- Memoria, direcciones y datos
- Instrucciones aritmeticas y logicas

</v-clicks>

</div>
<div>

### Construccion

<v-clicks>

- Syscalls y Linux API
- Saltos, ciclos y condiciones
- Funciones, stack y ABI
- Proyectos reproducibles con Git y Make

</v-clicks>

</div>
</div>

<Mascot emotion="idea" />

---
layout: aarch64-section
---

# Evaluacion y Proyectos

Eje principal del curso

---

# Proyectos del Curso

<InfoBox type="note" title="Evaluacion centrada en proyectos">

Los proyectos seran la evidencia principal de avance. Se evaluara funcionamiento, organizacion, claridad del codigo y cumplimiento de requisitos.

</InfoBox>

| Proyecto | Valor | Fecha de entrega | Observaciones |
|---|---:|---|---|
| Proyecto 1 | 40 puntos | 12 de junio de 2026 | Primera entrega formal |
| Proyecto 2 | 60 puntos | 28 de junio de 2026 | Fecha tentativa |

<!--
Recordar que las fechas corresponden a junio de 2026. Aclarar que cualquier ajuste oficial se comunicara por los canales del curso.
-->

---

# Expectativas de Entrega

<v-clicks>

- Codigo que compile y ejecute segun instrucciones
- Repositorio organizado y facil de revisar
- Evidencia de pruebas realizadas
- Documentacion minima para ejecutar el proyecto
- Participacion equilibrada dentro del grupo
- Entrega puntual segun fecha acordada

</v-clicks>

<InfoBox v-click type="warning" title="Regla practica">

No se entrega codigo que el grupo no haya probado en el entorno indicado.

</InfoBox>

<Mascot emotion="pensando" />

---
layout: aarch64-section
---

# Organizacion de Grupos

Trabajo colaborativo desde el inicio

---

# Grupos de Trabajo

<InfoBox type="info" title="Tamano del grupo">

Cada grupo debera estar formado por **5 integrantes**.

</InfoBox>

### Recomendaciones

<v-clicks>

- Definir roles internos desde la primera semana
- Crear un repositorio del grupo
- Establecer un canal de comunicacion
- Repartir tareas de forma equilibrada
- Documentar avances y decisiones
- Probar el codigo antes de entregar

</v-clicks>

<!--
Insistir en que grupo organizado temprano reduce riesgos cerca de la entrega.
-->

---

# Roles Internos Sugeridos

<div class="two-col">
<div>

### Tecnicos

<v-clicks>

- Integracion y Makefile
- Implementacion en ensamblador
- Pruebas y depuracion

</v-clicks>

</div>
<div>

### Gestion

<v-clicks>

- Documentacion
- Revision de entregables
- Coordinacion de avances

</v-clicks>

</div>
</div>

<InfoBox v-click type="note" title="Importante">

Los roles ayudan a organizar, pero todos deben entender el proyecto completo.

</InfoBox>

---
layout: aarch64-section
---

# Preparacion del Entorno

Herramientas para trabajar sin bloqueos

---

# Entorno de Trabajo

Durante la sesion se revisara que cada estudiante pueda trabajar con las herramientas base.

<v-clicks>

- **VS Code** como editor recomendado
- **Linux / WSL** como entorno principal
- **QEMU** si se requiere emulacion
- **Make** para automatizar compilacion
- **GNU assembler / linker** para construir binarios
- **Git** para control de versiones y trabajo en equipo

</v-clicks>

<Mascot emotion="leyendo" />

---
layout: aarch64-checklist
---

### Checklist de Entorno

- <span class="check-icon">✓</span> Tengo acceso a Linux, WSL o entorno equivalente
- <span class="check-icon">✓</span> Puedo abrir y editar codigo en VS Code
- <span class="check-icon">✓</span> Tengo Git configurado
- <span class="check-icon">✓</span> Puedo usar `make`
- <span class="check-icon">✓</span> Tengo assembler y linker GNU para AArch64
- <span class="check-icon">✓</span> Puedo ejecutar binarios con QEMU si aplica
- <span class="check-icon">✓</span> Se como clonar y actualizar un repositorio

<Mascot emotion="solucionado" />

<!--
Usar esta diapositiva para detectar bloqueos tecnicos temprano.
-->

---
layout: aarch64-section
---

# Dudas Frecuentes

Preguntas iniciales esperadas

---

# Preguntas Frecuentes

<v-clicks>

- **Necesito saber ensamblador antes?** No. Se espera disciplina, practica y lectura cuidadosa.
- **Puedo trabajar en Windows?** Si, usando WSL o un entorno Linux equivalente.
- **Como se entregan los proyectos?** Segun instrucciones oficiales del curso y repositorio indicado.
- **Que pasa si mi grupo tiene problemas?** Deben reportarlo temprano, con evidencia y propuesta de solucion.
- **Que se espera en las entregas?** Codigo funcional, ordenado, probado y documentado.
- **Como se evaluara el trabajo en grupo?** Por entregable, defensa si aplica y trazabilidad del trabajo.

</v-clicks>

<Mascot emotion="confundido" />

<!--
Invitar a preguntar aqui. Si una respuesta depende de lineamiento oficial, dejar claro que se confirmara por canal del curso.
-->

---
layout: aarch64-section
---

# Acuerdos del Dia

Lo minimo que debe quedar definido

---
layout: aarch64-checklist
---

### Checklist Final

- <span class="check-icon">✓</span> Conozco al auxiliar y su rol
- <span class="check-icon">✓</span> Entiendo la organizacion general del curso
- <span class="check-icon">✓</span> Identifico los temas principales de AArch64
- <span class="check-icon">✓</span> Conozco el valor de Proyecto 1 y Proyecto 2
- <span class="check-icon">✓</span> Tengo claras las fechas del 12 y 28 de junio de 2026
- <span class="check-icon">✓</span> Se que mi grupo debe tener 5 integrantes
- <span class="check-icon">✓</span> Se que debo preparar mi entorno de trabajo

<Mascot emotion="contento" />

---

# Proximos Pasos

<InfoBox type="warning" title="Primer recordatorio">

La primera entrega esta programada para el **12 de junio de 2026**.

</InfoBox>

<v-clicks>

- Confirmar grupo de 5 integrantes
- Crear o definir repositorio de trabajo
- Revisar instalacion del entorno
- Leer instrucciones oficiales del Proyecto 1
- Registrar dudas tecnicas antes de la fecha de entrega

</v-clicks>

---
layout: aarch64-statement
---

# Preguntas

<Mascot emotion="pensando" />

---

<CoverSlide
  title="Gracias por su atencion"
  subtitle="ARM64 / AArch64 - Arquitectura de Computadores y Ensambladores 1"
  note="Proxima meta: organizar grupo y preparar entorno para Proyecto 1"
/>
