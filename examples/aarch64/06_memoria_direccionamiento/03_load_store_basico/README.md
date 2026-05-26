# 06.3 · Load/Store Basico

## Objetivo

Practicar el patron load/store de AArch64: cargar desde memoria, modificar en
registro y guardar el resultado.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El programa empieza con `contador = 41`. Carga la direccion del contador, lee el
valor, suma uno en un registro, guarda el resultado y vuelve a leer memoria para
confirmar que el cambio quedo escrito.

## Pasos De Estudio

1. Ubica el bloque `cargar-modificar-guardar`.
2. Ejecuta el programa y revisa `echo $?`.
3. Depura paso a paso y observa como cambia `x1`.
4. Inspecciona la direccion de `contador` antes y despues de `str`.

## Archivos

```text
06_memoria_direccionamiento/03_load_store_basico/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=06_memoria_direccionamiento/03_load_store_basico run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=06_memoria_direccionamiento/03_load_store_basico run
echo $?
```

## Depurar

Abre `src/main.s` en VS Code y usa `Debug ARM64 QEMU - archivo activo`.

Comandos utiles en GDB:

```gdb
break _start
continue
info registers x0 x1 pc
x/1gd &contador
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- La ALU modifica registros, no memoria directamente.
- `str x1, [x0]` es la instruccion que actualiza memoria.
- La recarga final comprueba el dato guardado.

## Errores Comunes

- Hacer `add` y olvidar `str`, dejando memoria sin cambios.
- Usar `ldr x0, [x0]` demasiado pronto y perder la direccion del contador.

## Cambios Sugeridos

1. Cambia el valor inicial a `10` y suma `5`.
2. Cambia `.quad` por `.word` y adapta `ldr/str` a registros `w`.
3. Inspecciona `x/8xb &contador` para ver los bytes en little endian.
