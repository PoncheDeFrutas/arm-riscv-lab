# 06.5 · Modos De Direccionamiento

## Objetivo

Practicar las formas principales para calcular direcciones efectivas en una
instruccion de carga.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El array contiene valores de 8 bytes. El programa lee `array[0]` con base sola,
`array[1]` con offset inmediato, `array[2]` con indice escalado y luego muestra
post-index avanzando el puntero base.

## Pasos De Estudio

1. Identifica el tamano de cada elemento del array.
2. Relaciona `lsl #3` con multiplicar el indice por 8.
3. Depura hasta despues del `ldr x3, [x1], #8`.
4. Observa que `x1` cambia solamente en el acceso post-index.

## Archivos

```text
06_memoria_direccionamiento/05_modos_direccionamiento/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=06_memoria_direccionamiento/05_modos_direccionamiento run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=06_memoria_direccionamiento/05_modos_direccionamiento run
echo $?
```

## Depurar

Abre `src/main.s` en VS Code y usa `Debug ARM64 QEMU - archivo activo`.

Comandos utiles en GDB:

```gdb
break _start
continue
info registers x0 x1 x2 x3 x4 x5 pc
x/4gd &array
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `60`.

## Que Observar

- `[x1]` usa la direccion base.
- `[x1, #8]` suma un offset inmediato.
- `[x1, x2, lsl #3]` calcula `base + indice * 8`.
- `[x1], #8` lee primero y actualiza el puntero despues.

## Errores Comunes

- Usar `lsl #2` con elementos `.quad`; eso escala por 4, no por 8.
- Pensar que todos los modos actualizan el registro base.

## Cambios Sugeridos

1. Cambia `x2` a `#3` para leer `array[3]`.
2. Cambia el acceso post-index por pre-index `[x1, #8]!`.
3. Cambia el array a `.word` y ajusta la escala a `lsl #2`.
