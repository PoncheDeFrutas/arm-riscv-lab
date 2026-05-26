# 06.6 · Arrays Y Recorrido

## Objetivo

Recorrer un array como memoria consecutiva usando post-index para avanzar el
puntero despues de cada lectura.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El array contiene cuatro valores de 8 bytes. Cada `ldr [x1], #8` lee el elemento
actual y luego avanza el puntero al siguiente. El programa suma los elementos y
devuelve el resultado como codigo de salida.

## Pasos De Estudio

1. Observa que los elementos son `.quad`, por eso cada avance es de 8 bytes.
2. Depura cada `ldr` y mira como cambia `x1`.
3. Comprueba que los registros `x2` a `x5` contienen los elementos del array.
4. Sigue las tres sumas finales hasta obtener `50`.

## Archivos

```text
06_memoria_direccionamiento/06_arrays_recorrido/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=06_memoria_direccionamiento/06_arrays_recorrido run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=06_memoria_direccionamiento/06_arrays_recorrido run
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

No imprime texto. Termina con codigo `50`.

## Que Observar

- Un array es una region consecutiva de memoria.
- Post-index permite leer y avanzar el puntero en una sola instruccion.
- Este ejemplo evita loops para concentrarse en memoria; los loops llegan en la unidad 08.

## Errores Comunes

- Avanzar `#4` cuando los elementos son `.quad`.
- Olvidar que despues del ultimo post-index `x1` ya no apunta al ultimo elemento, sino a la posicion siguiente.

## Cambios Sugeridos

1. Cambia los valores del array y recalcula la suma esperada.
2. Agrega un quinto elemento y una quinta carga.
3. Cambia a `.word` y usa registros `w` con avance `#4`.
