# 15.6 · C Desde Assembly Y printf

## Objetivo

Escribir `main` en assembly y llamar a `printf` respetando la ABI y el runtime de
C.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El runtime de C llama a `main`. Nuestro `main` guarda `x29/x30`, prepara los
argumentos de `printf` en `x0` y `x1`, llama a libc y retorna `0`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/06_c_desde_assembly_printf run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/06_c_desde_assembly_printf run
```

## Depurar

```gdb
break main
break printf
continue
info registers x0 x1 sp x29 x30 pc
stepi
```

## Salida Esperada

```text
printf desde assembly: 42
```

## Que Observar

- `main` es llamado por libc, no por una syscall.
- `printf` recibe formato en `x0` y el entero en `x1`.
- El frame protege `x30` porque `main` llama a otra funcion.

## Cambios Sugeridos

1. Cambia el valor `42`.
2. Agrega otro argumento a `printf`.
3. Quita el frame temporalmente para razonar por que se pierde el retorno.
