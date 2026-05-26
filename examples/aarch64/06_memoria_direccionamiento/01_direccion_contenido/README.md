# 06.1 · Direccion Y Contenido

## Objetivo

Distinguir entre cargar la direccion de una etiqueta y leer el contenido que vive
en esa direccion.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa declara un dato de 64 bits con valor `42`. Primero carga la direccion
de `valor` en `x0`; despues usa corchetes, `[x0]`, para leer el contenido real en
`x1`. Termina devolviendo ese contenido como codigo de salida.

## Pasos De Estudio

1. Lee los comentarios iniciales de `src/main.s`.
2. Ejecuta el programa y confirma el codigo de salida.
3. Depura desde `_start` y compara `x0` antes y despues de `ldr x1, [x0]`.
4. Usa GDB para inspeccionar la memoria apuntada por `x0`.

## Archivos

```text
06_memoria_direccionamiento/01_direccion_contenido/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=06_memoria_direccionamiento/01_direccion_contenido run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=06_memoria_direccionamiento/01_direccion_contenido run
echo $?
```

## Depurar

Abre `src/main.s` en VS Code y usa `Debug ARM64 QEMU - archivo activo`.

Comandos utiles en GDB:

```gdb
break _start
continue
info registers x0 x1 pc
x/1gx $x0
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `ldr x0, =valor` obtiene una direccion.
- `ldr x1, [x0]` lee el contenido guardado en esa direccion.
- Los corchetes significan acceso a memoria.

## Errores Comunes

- Pensar que una direccion y el dato apuntado son lo mismo.
- Olvidar los corchetes al querer leer memoria.

## Cambios Sugeridos

1. Cambia `.quad 42` por otro numero pequeno.
2. Cambia `ldr x1, [x0]` por `ldrb w1, [x0]` y compara.
3. Inspecciona `x/8xb $x0` para ver los bytes reales.
