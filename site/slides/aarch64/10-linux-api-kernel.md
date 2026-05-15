---
theme: default
class: text-left
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
title: "Unidad 10 · Linux como API del kernel"
info: "Presentación de apoyo para la Unidad 10 de la ruta AArch64."
author: "ARM RISC-V Lab"
seoMeta:
  ogTitle: "Unidad 10 · Linux como API del kernel"
  ogDescription: "Archivos, errores y recursos usando syscalls AArch64 sin depender de libc."
---

# Arquitectura de Computadores y Ensambladores 1

Escuela de Ingeniería de Ciencias y Sistemas

---
layout: center
---

Arquitectura de Computadores y Ensambladores 1

## Unidad 10
## Linux como API del kernel

Archivos, errores y recursos usando syscalls AArch64 sin depender de libc.

Unidad práctica: file descriptors, ciclo open/read/write/close, errores, cleanup, lseek, fstat, getpid y nanosleep.

---

# Anuncios importantes

1. **Anuncio 1**

---

# Agenda

1. **File descriptors y recursos** — Qué es un fd, stdin/stdout/stderr y ciclo de vida.
2. **Archivos con syscalls** — `openat`, `read`, `write`, `close` en flujo completo.
3. **Errores y cleanup** — Dos rutas de error, `cleanup` y errno conceptual.
4. **Posición y metadatos** — `lseek`, `fstat`, `statx` como mapa inicial.
5. **Procesos y tiempo** — `getpid`, `nanosleep`, `clock_gettime` y menciones.

---

# Competencias

### Competencia 1
El estudiante desarrolla soluciones eficientes en sistemas computacionales integrando arquitectura de computadores, programación en bajo nivel y herramientas modernas de análisis y simulación para resolver problemas complejos en sistemas embebidos e IoT.

### Competencia 2
Implementa sistemas embebidos orientados a IoT mediante el uso de Raspberry Pi, sensores digitales y comunicación con la nube para resolver problemas reales mediante automatización de procesos.

---

# Valor de la semana

**Responsabilidad.** Capacidad de gestionar recursos correctamente y asumir las consecuencias de cada decisión técnica.

### Aplicación en clase
Cada recurso abierto es responsabilidad del programa. No cerrar un fd, ignorar un error o sobrescribir un retorno sin revisarlo son decisiones con consecuencias reales en sistemas de producción.

---

# Qué buscamos hoy

1. **File descriptors** — Entender fd como handle entero, no como puntero ni dirección.
2. **Ciclo de recurso** — Abrir → usar → revisar → cerrar como disciplina de trabajo.
3. **Rutas de error** — Diseñar cleanup que sabe qué recursos están vivos.
4. **Más allá de archivos** — Reconocer que el mismo contrato sirve para posición, metadatos y tiempo.

---
layout: section
---

# File descriptors y recursos

Un fd es un número que representa un recurso abierto del kernel.

---
layout: center
class: text-center
---

### Pregunta de arranque

## ¿Un file descriptor es un puntero a memoria?

- No. Es un entero pequeño que el kernel asocia con un recurso.
- No puedes hacer `ldr x1, [x0]` con un fd.
- Se pasa como argumento a otras syscalls.

---

# File descriptors iniciales

```bash
proceso
  fd 0 → stdin
  fd 1 → stdout
  fd 2 → stderr
  fd 3 → archivo abierto por openat
```

- fd 0 — stdin — Entrada estándar. `read` lee desde aquí.
- fd 1 — stdout — Salida estándar. `write` escribe aquí.
- fd 2 — stderr — Salida de error. Mensajes de fallo van aquí.

Un fd no es puntero. No puedes hacer `ldr` con un fd. Se pasa como argumento a syscalls.

---

# Ciclo de vida de un recurso

```mermaid {theme: 'dark', scale: 0.78}
flowchart LR
  open["openat"] --> fd["fd en x0"]
  fd --> save["Guardar fd"]
  save --> use["read / write"]
  use --> check["Revisar retorno"]
  check --> close["close(fd)"]
```

Abrir → guardar → usar → revisar → cerrar.

`x0` cambia de papel: antes de `svc #0` es argumento, después es retorno. Por eso debes guardar valores importantes como el fd.

---
layout: section
---

# Archivos con syscalls

openat, read, write, close — el flujo completo de archivo.

---

# Abrir y leer

Primera mitad del flujo: obtener un descriptor y leer bytes.

```asm
mov x0, #AT_FDCWD
ldr x1, =nombre
mov x2, #O_RDONLY
mov x3, #0
mov x8, #56         // openat
svc #0
cmp x0, #0
b.lt error_sin_fd

mov x19, x0         // guardar fd

mov x0, x19
ldr x1, =buffer
mov x2, #128
mov x8, #63         // read
svc #0
cmp x0, #0
b.lt cleanup
```

---

# Escribir y cerrar

Segunda mitad del flujo: escribir lo leído y liberar el descriptor.

```asm
mov x20, x0         // bytes leídos

mov x0, #1          // stdout
ldr x1, =buffer
mov x2, x20
mov x8, #64         // write
svc #0
cmp x0, #0
b.lt cleanup

mov x0, x19
mov x8, #57         // close
svc #0

mov x0, #0
mov x8, #93         // exit
svc #0
```

---

# read no promete llenar el buffer

```asm
mov x2, #128        // pido hasta 128 bytes
mov x8, #63
svc #0              // x0 = bytes realmente leídos
mov x20, x0         // guardo la cantidad real
```

- **Pedir 128** — Es el máximo que aceptas. No garantiza recibir 128.
- **Recibir x0** — Cantidad real leída. `write` debe usar esta cantidad, no 128.

---
layout: section
---

# Errores y cleanup

Una ruta de error debe saber qué recursos ya están abiertos.

---

# Dos rutas de error

- `error_sin_fd` — No hay fd abierto. Mensaje a stderr + `exit(1)`. Usado cuando `openat` falla.
- `cleanup` — Hay fd guardado en `x19`. Primero `close(x19)`. Luego cae a `error_sin_fd`.

```bash
openat falla       → error_sin_fd (nada que cerrar)
read/write falla   → cleanup → close(x19) → error_sin_fd
```

No cierres basura. Si no hay fd abierto, no saltes a cleanup.

---

# errno conceptual

- **Con libc** — `errno` es una variable TLS. Funciones como `perror` la leen.
- **Sin libc (nosotros)** — El retorno negativo en `x0` es el error. Patrón: `cmp x0, #0` + `b.lt error`.

En assembly sin libc, tu primer contrato es el valor que vuelve en `x0`. No esperes que `errno` aparezca solo.

---
layout: section
---

# Posición, metadatos y más allá

El mismo contrato sirve para servicios más allá de archivos.

---

# lseek y fstat

- `lseek` — syscall 62 — Cambia posición dentro del fd. `SEEK_SET` (0), `SEEK_CUR` (1), `SEEK_END` (2). No aplica a pipes ni terminales.
- `fstat` — syscall 80 — Consulta metadatos desde un fd abierto. Kernel escribe estructura en buffer que tú preparas. Tamaño, tipo, permisos, tiempos.

---

# Procesos y tiempo (mapa inicial)

- `getpid` — 172 — Devuelve PID. Sin argumentos.
- `nanosleep` — 101 — Pausa el proceso. Recibe puntero a `timespec`.
- `clock_gettime` — 113 — Hora del sistema. Escribe `timespec` en buffer.
- `execve` — 221 — Reemplaza programa. Mención conceptual.

Archivos, procesos y tiempo usan el mismo mecanismo: registros, número de syscall, `svc #0`, retorno en `x0`.

---

# Checklist mental

- Puedo explicar qué es un file descriptor.
- Puedo distinguir fd, dirección y contenido.
- Puedo usar `openat`, `read`, `write` y `close` en un flujo completo.
- Puedo guardar el fd antes de sobrescribir `x0`.
- Puedo diseñar rutas `cleanup` y `error_sin_fd`.
- Puedo reconocer `lseek`, `fstat`, `getpid` y `nanosleep`.

---

# Siguiente paso

Linux como API del kernel dominado → Manejo de recursos y cleanup → Más servicios del kernel → Stack frames, funciones y ABI

---
layout: center
class: text-center
---

### Actividad de cierre

# Preguntas de repaso

- ¿Un fd es un puntero a memoria?
- ¿Por qué debes guardar el fd antes de llamar `write`?
- ¿Cuándo se salta a `cleanup` y cuándo a `error_sin_fd`?
- ¿Qué pasa si `read` devuelve menos bytes de los pedidos?
- ¿Qué tienen en común archivos, tiempo y procesos a nivel de syscall?

---

### Ejemplo Práctico

Programa que abre `entrada.txt`, lee un bloque, escribe en stdout, cierra fd y maneja errores con cleanup.

1. **openat** — Abrir archivo y guardar fd en `x19`.
2. **read → write** — Leer hacia buffer, escribir la cantidad real a stdout.
3. **cleanup** — Si falla después de abrir, cerrar fd antes de salir.
4. **Verificar** — `cat entrada.txt` vs salida del programa + `echo $?`.

---

# Fuentes

- Página Quarto: `site/courses/aarch64/linux-api-kernel/`
- Arm, *Learn the Architecture - A64 Instruction Set Architecture Guide*
- Larry D. Pyeatt y William Ughetta, *ARM 64-Bit Assembly Language*
- Linux kernel, *syscall table for AArch64*
- `man 2 openat`, `man 2 read`, `man 2 write`, `man 2 close`
- `man 2 lseek`, `man 2 fstat`, `man 2 statx`, `man 2 nanosleep`
- Slidev, documentación oficial

---
layout: statement
---

# Dudas¿?

---
layout: center
---

# Gracias por tu atención
