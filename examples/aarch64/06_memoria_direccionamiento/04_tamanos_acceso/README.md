# 06.4 · Tamanos De Acceso

## Objetivo

Mostrar que la instruccion decide cuantos bytes se leen desde una misma
direccion de memoria.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

La memoria contiene cuatro bytes: `11 22 33 44`. El programa lee desde la misma
direccion con `ldrb`, `ldrh` y `ldr w`, dejando en registros tres
interpretaciones distintas de esos bytes.

## Pasos De Estudio

1. Lee la declaracion de `bytes`.
2. Depura hasta despues de las tres cargas.
3. Compara `w2`, `w3` y `w4`.
4. Inspecciona los bytes con `x/4xb`.

## Archivos

```text
06_memoria_direccionamiento/04_tamanos_acceso/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=06_memoria_direccionamiento/04_tamanos_acceso run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=06_memoria_direccionamiento/04_tamanos_acceso run
echo $?
```

## Depurar

Abre `src/main.s` en VS Code y usa `Debug ARM64 QEMU - archivo activo`.

Comandos utiles en GDB:

```gdb
break _start
continue
info registers x1 w2 w3 w4 pc
x/4xb $x1
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `17`, que es `0x11`.

## Que Observar

- `ldrb` lee 1 byte.
- `ldrh` lee 2 bytes.
- `ldr w` lee 4 bytes.
- En little endian, los bytes bajos aparecen primero en memoria.

## Errores Comunes

- Esperar que `ldrh` devuelva `0x1122` en vez de `0x2211`.
- Mezclar registros `x` y `w` sin pensar en el tamano del dato.

## Cambios Sugeridos

1. Cambia el primer byte y observa el codigo de salida.
2. Mueve la direccion a `bytes + 1` con un offset.
3. Agrega una lectura de 8 bytes con `ldr x5, [x1]`.
