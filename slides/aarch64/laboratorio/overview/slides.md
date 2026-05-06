---
theme: default
title: "Laboratorio ARM64 reproducible"
info: "Unidad 01 de ARM RISC-V Lab"
class: text-left
drawings:
  persist: false
transition: slide-left
mdc: true
---

# Laboratorio ARM64 reproducible

Unidad 01 · AArch64 en Linux

<div class="mt-8 grid grid-cols-3 gap-4 text-sm">
  <div class="rounded border border-sky-400/40 p-4">Raspberry Pi ARM64</div>
  <div class="rounded border border-sky-400/40 p-4">x86_64 + QEMU user mode</div>
  <div class="rounded border border-sky-400/40 p-4">Primer binario inspeccionable</div>
</div>

<!--
Hoy no buscamos explicar todo ARM64. Buscamos que todos tengan un laboratorio
funcionando y una ruta clara según su máquina.
-->

---

# Meta de la unidad

Al final, estudiante debe poder:

- elegir ruta de ejecución;
- instalar toolchain mínima;
- compilar con `make`;
- ejecutar con `make run`;
- mirar el binario con herramientas básicas;
- detenerse en `_start` con GDB.

<!--
La clave es reproducibilidad. Si el entorno no funciona, los temas de registros,
memoria y syscalls se vuelven ruido.
-->

---

# Dos rutas principales

| Máquina | Ruta | Ejecución |
|---|---|---|
| Raspberry Pi ARM64 | Nativa | `./build/main` |
| Linux x86_64 | Cross + QEMU user mode | `qemu-aarch64 ./build/main` |

Docker queda como alternativa. QEMU system mode queda como tema futuro.

<!--
La misma fuente en assembly puede servir en ambas rutas. Lo que cambia es cómo
se genera y se ejecuta el binario.
-->

---

# Toolchain mínima

```bash
make
gcc / aarch64-linux-gnu-gcc
as / aarch64-linux-gnu-as
ld / aarch64-linux-gnu-ld
qemu-aarch64
gdb / gdb-multiarch
file readelf objdump nm hexdump xxd ldd strace
```

`perf` aparece solo como mapa futuro de rendimiento.

<!--
No conviene enseñar todas las herramientas al máximo detalle. Primero las usamos
para verificar que existe un binario ARM64 real.
-->

---

# Flujo mínimo

```bash
cd 00-hello-minimo
make
make run
```

Salida esperada:

```bash
Hola ARM64
```

<!--
Este flujo debe sentirse estable. El estudiante no debe cambiar comandos en cada
lección.
-->

---

# Qué inspeccionar primero

| Herramienta | Pregunta |
|---|---|
| `file` | ¿Qué tipo de archivo es? |
| `readelf -h` | ¿Es ELF64 AArch64? |
| `objdump -d` | ¿Qué instrucciones hay? |
| `nm` | ¿Qué símbolos aparecen? |
| `strace` | ¿Qué interacción con Linux se ve? |

<!--
Aquí solo abrimos la puerta. ELF, ABI y syscalls tendrán unidades propias.
-->

---

# Debugging mínimo

```bash
break _start
run
info registers x0 x1 x2 x8 pc
x/4i $pc
stepi
```

Objetivo: ver ejecución real, no dominar GDB completo.

<!--
Quiero que el estudiante vea PC, registros y una instrucción avanzar. Eso basta
para conectar texto assembly con ejecución.
-->

---

# Cierre

Checklist de laboratorio:

- ruta elegida;
- herramientas verificadas;
- `build/main` generado;
- salida correcta;
- binario inspeccionado;
- breakpoint en `_start`;
- estructura de repo entendida.

<!--
Cuando esta lista está completa, la siguiente unidad ya puede enseñar contenido
de arquitectura sin volver a resolver instalación.
-->
