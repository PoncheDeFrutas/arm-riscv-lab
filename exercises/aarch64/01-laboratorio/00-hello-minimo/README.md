# Ejercicios - Hello mínimo ARM64

Parte desde:

```bash
lessons/aarch64/01-laboratorio/00-hello-minimo/
```

## Ejercicio 1: cambia el mensaje

Cambia `Hola ARM64` por tu nombre y vuelve a ejecutar:

```bash
make clean
make
make run
```

Validación: la salida muestra tu nuevo mensaje.

## Ejercicio 2: dos líneas

Agrega una segunda cadena en `.data` y una segunda syscall `write`.

Validación esperada:

```bash
Hola ARM64
Laboratorio listo
```

## Ejercicio 3: código de salida

Cambia `exit(0)` por `exit(7)`.

Ejecuta:

```bash
make run
echo $?
```

Validación: el shell muestra `7`.

## Entrega sugerida

- Captura o texto de `make run`.
- Salida de `file build/main`.
- Dos líneas explicando qué registros cambiaste.
