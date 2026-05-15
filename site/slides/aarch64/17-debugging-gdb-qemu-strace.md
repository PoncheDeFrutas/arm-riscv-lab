---
theme: default
class: text-left
highlighter: shiki
lineNumbers: true
drawings:
  persist: false
transition: slide-left
mdc: true
title: "Unidad 17 · Debugging con GDB, QEMU y strace"
info: "Presentación de apoyo para la Unidad 17 de la ruta AArch64."
author: "ARM RISC-V Lab"
seoMeta:
  ogTitle: "Unidad 17 · Debugging con GDB, QEMU y strace"
  ogDescription: "Aprende a leer el estado real del programa mientras se ejecuta usando GDB y strace en AArch64."
---

# Arquitectura de Computadores y Ensambladores 1

Escuela de Ingeniería de Ciencias y Sistemas

---
layout: center
---

Arquitectura de Computadores y Ensambladores 1

## Unidad 17
## Debugging: GDB, QEMU y strace

Leer el estado real del programa mientras se ejecuta.

Unidad práctica: dejar de adivinar por qué falló el programa y aprender a mirar directamente los registros, la memoria y las llamadas al kernel.

---

# Anuncios importantes

1. **Anuncio 1**

---

# Agenda

1. **Flujo de Control** — Cómo usar breakpoints, `stepi` y `nexti` para dominar el tiempo.
2. **Mirar el Estado** — Leer registros e inspeccionar direcciones de memoria directamente (`x/x`, `x/s`).
3. **Stack Frames** — Usar `sp`, `x29`, `x30` y `bt` para entender dónde estamos.
4. **El Kernel no miente** — Verificar con `strace` la comunicación exacta (Syscalls) con Linux.

---

# Competencias

### Competencia 1
El estudiante desarrolla soluciones eficientes en sistemas computacionales integrando arquitectura de computadores, programación en bajo nivel y herramientas modernas de análisis y simulación para resolver problemas complejos en sistemas embebidos e IoT.

### Competencia 2
Diagnostica y depura programas a nivel de código máquina utilizando herramientas (GDB, QEMU y strace) para analizar interactivamente el estado de los registros, la memoria, los frames en el stack y las interacciones con el SO.

---

# Valor de la semana

**Rigor Analítico y Evidencia Empírica.** No adivinar dónde está el error; observar la máquina para encontrarlo.

### Aplicación en clase
En alto nivel puedes usar `print("Llegó aquí")`. En Ensamblador, el programa puede suicidarse silenciosamente (Segmentation Fault) si calculas mal un puntero. Depurar exige **Rigor**: formular una hipótesis (*"creo que x0 tiene el fd"*), pausar el código, y recolectar la **evidencia** leyendo la memoria real antes de culpar a la instrucción.

---

# Qué buscamos hoy

1. **Navegar el código** — Detener el proceso, avanzar instrucción por instrucción y entender la diferencia entre `stepi` y `nexti`.
2. **Inspeccionar Memoria** — Traducir una dirección de memoria a valores legibles: Hexadecimales, Strings o Instrucciones.
3. **Depurar el Pila (Stack)** — Ver cómo se construyen los marcos de función y usar Backtrace (`bt`) para no perderte.
4. **Auditar al Kernel** — Saber exactamente si una lectura/escritura falló porque el Kernel te devolvió un `ENOENT` en `strace`.

---
layout: section
---

# Flujo de Control en GDB

El ciclo es simple: detener, observar, avanzar e interpretar.

---

# Breakpoints y avance

GDB permite detener el programa y observarlo con calma. Si todo ocurre demasiado rápido, el error puede pasar sin que lo veas.

- **Detener** — `break _start`. Pone un punto de parada en una etiqueta o función.
- **Continuar** — `continue`. Deja correr el programa hasta el siguiente breakpoint.

Usa `-g` al ensamblar, por ejemplo `as -g`, para que GDB pueda leer etiquetas y nombres.

---

# Avanzar instrucción por instrucción

- `stepi` — Avanza una instrucción. Si encuentra un `bl`, **entra** a la subrutina.
- `nexti` — Avanza una instrucción. Si encuentra un `bl`, **no entra**; ejecuta la llamada completa y sigue después.

Usa `stepi` cuando quieras inspeccionar la llamada. Usa `nexti` cuando solo te interese su resultado.

---
layout: section
---

# Mirar el estado

El CPU no miente: o el registro tiene el valor correcto o no lo tiene.

---

# Registros y memoria

Comandos para preguntar: "¿qué hay aquí?"

- **Ver registros** — `info registers`. Muestra `x0-x30`, `sp` y `pc`.
- **Ver memoria** — `x/10x $sp`. Examina 10 valores en hexadecimal desde la dirección de `sp`.
- **Ver texto** — `x/s 0x400000`. Intenta leer una cadena ASCII desde esa dirección.

---

# Del registro a la memoria

```mermaid {theme: 'dark', scale: 0.8}
flowchart LR
  obs["info registers"] --> x0["x0 = 0x41000"]
  x0 --> examine["x/s 0x41000"]
  examine --> txt["'Hola Mundo\\n'"]
```

Flujo típico: primero miras un registro; luego inspeccionas la dirección a la que apunta.

Un registro puede contener un valor o una dirección. GDB te permite seguir esa relación paso a paso.

---
layout: section
---

# Stack Frames

¿Quién me llamó y cómo regreso?

---

# Backtrace y Registros Especiales

- **Las piezas de AAPCS64** — `sp` (Stack Pointer): Dónde está la cima actual. `x29` (Frame Pointer): Base de mi marco actual. `x30` (Link Register): A dónde debo regresar. Si un programa colapsa, ver estos 3 te dirá qué función estaba corriendo.
- **Comando `bt` (Backtrace)** — Imprime la ruta de funciones llamadas. Ejemplo: `#0 funcion_c ()`, `#1 funcion_b ()`, `#2 main ()`. GDB usa `x29` y `x30` para reconstruir este historial automáticamente.

---
layout: section
---

# `strace` y el Kernel

La verdad sobre las Syscalls.

---

# Leyendo la salida de strace

`strace` observa lo que tu programa le pide al kernel. No corrige tu código, pero muestra con claridad qué syscall se hizo, con qué argumentos y qué valor devolvió.

- **Qué muestra** — Nombre de la syscall, argumentos enviados y valor de retorno.
- **Para qué sirve** — Verificar si el programa pidió lo correcto al sistema operativo.

---

# Lectura básica y errores

**Ejemplo correcto**
- `write(1, "Hola\n", 5) = 5`
- Syscall: `write`. Fd: `1`. Buffer: `"Hola\n"`. Pidió 5 bytes y devolvió 5.

**Ejemplo con error**
- `openat(AT_FDCWD, "no-existe.txt", O_RDONLY) = -1 ENOENT`
- La syscall falló. El archivo no existe. En assembly, ese error se refleja en `x0`.

Al usar `strace qemu-aarch64 ./prog`, pueden mezclarse syscalls del emulador con las de tu programa.

---

# Checklist mental

- Sé cómo iniciar un binario cruzado (QEMU) esperando a GDB: `qemu-aarch64 -g 1234 ./prog`.
- Puedo conectarme a ese proceso desde GDB: `target remote :1234`.
- Sé poner un tope: `break _start`.
- Entiendo cuándo usar `stepi` (entrar a todo) y `nexti` (pasar de largo funciones completas).
- Sé ver el contenido de los registros con `info registers`.
- Sé inspeccionar punteros a memoria para ver Hexadecimal (`x/x`) o Letras (`x/s`).
- Sé usar `strace` para descubrir si un archivo no abrió por falta de permisos o error en el path.

---

# Siguiente paso

Ejecución con QEMU -g → Conexión con GDB Multiarch → Paso a Paso e Inspección

---
layout: center
class: text-center
---

### Actividad de cierre

# Preguntas de repaso

- Si en GDB ves un registro antes de ejecutar la instrucción de asignación, ¿Qué vas a leer?
- Tienes un `bl imprimir_pantalla`, y sabes que la función funciona perfecto, solo quieres pasar a la siguiente línea. ¿Usas `stepi` o `nexti`?
- Si en `info registers` ves que `x0` tiene la dirección `0x4000b0`, ¿qué comando de GDB usas para ver si ahí hay una frase (String)?
- ¿Qué herramienta te confirma que el Kernel realmente rechazó tu archivo con `ENOENT` (No such file)?

---

### Ejemplo Práctico: Conexión Remota

Para depurar un binario AArch64 desde una computadora `x86_64`, QEMU ejecuta el programa y GDB se conecta de forma remota.

QEMU ejecuta el binario → QEMU espera en el puerto `1234` → GDB se conecta y controla la ejecución

---

# Terminal 1: lanzar QEMU

El host compila el programa y deja a QEMU esperando a GDB.

```bash
# Compilar con información de depuración
$ aarch64-linux-gnu-as -g p.s -o p.o
$ aarch64-linux-gnu-ld p.o -o prog

# Ejecutar el binario y esperar conexión remota
$ qemu-aarch64 -g 1234 ./prog
```

Después de ejecutar `qemu-aarch64 -g 1234 ./prog`, el programa queda detenido hasta que GDB se conecte.

---

# Terminal 2: conectar GDB

GDB abre el binario local y se conecta al puerto donde espera QEMU.

```bash
# Abrir GDB con el binario
$ gdb-multiarch ./prog

# Conectarse a QEMU
(gdb) target remote :1234
(gdb) break _start
(gdb) continue

# Inspeccionar la ejecución
(gdb) stepi
(gdb) info registers x0
```

QEMU ejecuta el programa; GDB lo observa, lo detiene y permite inspeccionarlo instrucción por instrucción.

---

# Fuentes

- Página Quarto: `site/courses/aarch64/debugging-gdb-qemu-strace/`
- Toolchain GNU: documentación oficial de GDB
- Proyecto strace: documentación
- Slidev: documentación oficial

---
layout: statement
---

# ¿Dudas?

---
layout: center
---

# Gracias por tu atención
