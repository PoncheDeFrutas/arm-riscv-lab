# 06.2 · Secciones Y Mapa

## Objetivo

Relacionar las secciones `.text`, `.rodata`, `.data` y `.bss` con el papel que
cumplen dentro de un programa AArch64.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El codigo vive en `.text`, el mensaje imprimible vive en `.rodata`, un contador
inicializado vive en `.data` y un buffer reservado vive en `.bss`. El programa
escribe un byte en el buffer y luego imprime un mensaje corto.

## Pasos De Estudio

1. Identifica cada seccion en `src/main.s`.
2. Ejecuta el programa y observa el texto impreso.
3. Usa `readelf -S` para ver las secciones del binario.
4. En GDB, inspecciona la direccion de `buffer` despues de `strb`.

## Archivos

```text
06_memoria_direccionamiento/02_secciones_mapa/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=06_memoria_direccionamiento/02_secciones_mapa run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=06_memoria_direccionamiento/02_secciones_mapa run
```

## Depurar

Abre `src/main.s` en VS Code y usa `Debug ARM64 QEMU - archivo activo`.

Comandos utiles en GDB:

```gdb
break _start
continue
info registers x1 w3 pc
x/8xb &buffer
stepi
```

## Salida Esperada

```text
Secciones 06
```

## Que Observar

- `.text` contiene instrucciones.
- `.rodata` contiene bytes constantes para `write`.
- `.bss` reserva memoria que no aparece como bytes explicitos en el archivo.

## Errores Comunes

- Confundir `.data` con `.bss`: `.data` tiene valor inicial; `.bss` reserva ceros.
- Esperar que `.rodata` sea una zona para modificar datos.

## Cambios Sugeridos

1. Cambia el byte escrito en `buffer`.
2. Aumenta `.skip 8` a `.skip 16` y revisa `readelf -S`.
3. Mueve `msg` a `.data` y compara las secciones.
