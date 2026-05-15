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

# Arquitectura de Computadores y Ensambladores 1

Escuela de Ingeniería de Ciencias y Sistemas

---
layout: center
---

Arquitectura de Computadores y Ensambladores 1

## Unidad 03
## Modelo ARMv8-A / AArch64

Qué estado puede observar un programa: registros, flags, direcciones de ejecución y contexto de privilegios.

Unidad conceptual: registros generales, especiales, PSTATE/NZCV, SIMD/FP, exception levels y lectura con GDB.

---

# Anuncios importantes

1. **Anuncio 1**

---

# Agenda

1. **Registros generales** — `X0`–`X30`, `W0`–`W30` y zero-extension.
2. **Registros especiales** — `XZR`, `SP`, `PC`, `X29/FP` y `X30/LR`.
3. **PSTATE y flags NZCV** — Comparaciones, condiciones y saltos condicionales.
4. **SIMD/FP y exception levels** — `V0`–`V31`, vistas por tamaño, EL0 a EL3.
5. **Lectura con GDB** — Mirar registros sin sobreinterpretar.

---

# Competencias

### Competencia 1
El estudiante desarrolla soluciones eficientes en sistemas computacionales integrando arquitectura de computadores, programación en bajo nivel y herramientas modernas de análisis y simulación para resolver problemas complejos en sistemas embebidos e IoT.

### Competencia 2
Implementa sistemas embebidos orientados a IoT mediante el uso de Raspberry Pi, sensores digitales y comunicación con la nube para resolver problemas reales mediante automatización de procesos.

---

# Valor de la semana

**Aplicación.** Capacidad de llevar teoría a la práctica.

### Aplicación en clase
Relacionar arquitectura con sistemas reales. Cada registro, flag y nivel de excepción que estudiamos aparece cuando depuras un programa AArch64 en Linux.

---

# Qué buscamos hoy

1. **Registros generales** — Reconocer `Xn` y `Wn`, entender zero-extension al escribir en `Wn`.
2. **Registros especiales** — Ubicar `SP`, `PC`, `FP`, `LR` y `XZR`.
3. **Flags NZCV** — Entender qué señales dejan las comparaciones y cómo los usan los saltos.
4. **Mapa completo** — Ubicar SIMD/FP, exception levels y leer registros con GDB.

---
layout: section
---

# Registros generales

31 registros de 64 bits: el lugar donde viven enteros, direcciones y resultados.

---
layout: center
class: text-center
---

### Pregunta de arranque

## ¿Son X0 y W0 registros separados?

- No. W0 son los 32 bits bajos de X0.
- Escribir en W0 limpia los bits altos de X0.
- Es el mismo registro visto con tamaños distintos.

---

# X0–X30 y W0–W30

```bash
x0:
63                                32 31                                0
+-----------------------------------+-----------------------------------+
|          bits altos de x0          |                w0                 |
+-----------------------------------+-----------------------------------+
```

- **Xn — 64 bits** — Registro completo. Enteros, direcciones, temporales.
- **Wn — 32 bits** — Parte baja de `Xn`. Operaciones de 32 bits.

---

# Zero-extension al escribir en Wn

```asm
mov x0, #-1     // x0 = 0xFFFFFFFFFFFFFFFF
mov w0, #1      // x0 = 0x0000000000000001
```

Escribir en `Wn` limpia los 32 bits altos. No queda `0xFFFFFFFF00000001`.

No dupliques mentalmente registros. `x0` y `w0` son el mismo registro visto con tamaños distintos.

---
layout: section
---

# Registros especiales

No todos los nombres se comportan como registros generales normales.

---

# XZR, SP, PC, FP y LR

- `xzr` / `wzr` — Leer = cero. Escribir = descarta.
- `sp` — Stack pointer. Dirección del stack actual.
- `pc` — Program counter. Posición de ejecución. No es un Xn más.
- `x29` / `fp` — Frame pointer. Referencia en stack frames.
- `x30` / `lr` — Link register. Dirección de retorno.

---

# ¿Quién se puede usar como temporal?

**Sí se pueden usar**
- `x0–x28` — Generales, como mapa inicial. ABI definirá roles después.

**Tienen reglas especiales**
- `sp, pc, xzr` — `sp` no como general normal. `pc` no programable directamente. `xzr` no almacena.

---
layout: section
---

# PSTATE y flags NZCV

Señales de estado que ciertas instrucciones actualizan y otras consultan.

---

# Los cuatro flags

- `N` — Negative — ¿El resultado tiene bit de signo encendido?
- `Z` — Zero — ¿El resultado fue cero?
- `C` — Carry — ¿Hubo carry / no borrow en unsigned?
- `V` — Overflow — ¿Hubo overflow en signed?

Los flags no son registros generales. Son señales que `cmp`, `adds`, `subs` actualizan y que `b.cond` consulta.

---

# Comparar y saltar

```asm
mov x0, #5
mov x1, #5
cmp x0, x1       // actualiza flags como x0 - x1
b.eq iguales     // salta si Z = 1 (igualdad)
```

- `cmp x0, x1` — Resta internamente sin guardar resultado. Actualiza flags NZCV.
- `b.eq iguales` — Consulta flag Z. Salta si la comparación indicó igualdad.

Flags no duran como variables. Una instrucción posterior puede cambiarlos.

---
layout: section
---

# SIMD/FP y exception levels

Banco vectorial y niveles de privilegio como mapa inicial.

---

# Registros V0–V31

32 registros de 128 bits. No son Xn. Son otro banco.

- `bn` — 8 bits — Byte.
- `hn` — 16 bits — Halfword.
- `sn` — 32 bits — Single precision.
- `dn` — 64 bits — Double precision.
- `qn` — 128 bits — Quadword.

`x0` y `d0` no son el mismo registro. Mismo número, bancos distintos.

---

# Exception levels: EL0 a EL3

- `EL0` — User mode — Programas de usuario. Aquí corren nuestros programas.
- `EL1` — Kernel mode — Kernel del SO. Administra memoria, procesos, dispositivos.
- `EL2` — Hypervisor — Virtualización.
- `EL3` — Secure monitor — Transición secure / non-secure.

Tu programa usa registros generales en EL0. Linux corre en EL1. `svc #0` es el puente entre ambos.

---
layout: section
---

# Lectura con GDB

Mirar registros sin sobreinterpretar.

---

# Comandos básicos de GDB

**Preparación**
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

**Consultar estado**
- Registros: `info registers x0 x1 x8`, `info registers sp pc`, `info registers x29 x30`
- Instrucciones: `x/4i $pc`, `info registers cpsr`

---

# Leer sin sobreinterpretar

- `x0 = 0x1` → ¿Es entero, dirección o argumento?
- `sp = 0x...` → ¿A qué región de stack apunta?
- `pc = 0x...` → ¿Qué instrucción está por ejecutarse?
- `x30 = 0x...` → ¿Podría ser dirección de retorno?

GDB muestra valores. El curso te enseña a interpretarlos con contexto: registro, tamaño, instrucción actual y memoria asociada.

---

# Checklist mental

- Puedo explicar `Xn` y `Wn` y zero-extension.
- Puedo ubicar `XZR`, `SP`, `PC`, `FP` y `LR`.
- Puedo nombrar y explicar `N`, `Z`, `C` y `V`.
- Puedo ubicar `V0`–`V31` como banco SIMD/FP.
- Puedo distinguir `EL0` de `EL1`.
- Puedo leer registros básicos con GDB.

---

# Siguiente paso

Registros generales y especiales → Flags NZCV y comparaciones → SIMD/FP y exception levels → GNU Assembly, directivas y primeros programas

---
layout: center
class: text-center
---

### Actividad de cierre

# Preguntas de repaso

- ¿Qué pasa con `x0` cuando escribes en `w0`?
- ¿`PC` se puede usar como registro general?
- ¿Qué flag se activa cuando el resultado de `cmp` es cero?
- ¿`x0` y `d0` son el mismo registro?
- ¿En qué exception level corre un programa de usuario en Linux?

---

### Ejemplo Práctico

Observar registros, flags y estado del procesador con GDB en un programa mínimo.

1. **Generales** — `info registers x0 x1 x8` y verificar valores.
2. **Especiales** — `info registers sp pc x29 x30`
3. **Flags** — `info registers cpsr` y buscar NZCV.
4. **Instrucciones** — `x/4i $pc` para ver qué sigue.

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
