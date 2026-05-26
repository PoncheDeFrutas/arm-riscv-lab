# 15.1 · ABI, AAPCS64 Y Mapa De Registros

## Objetivo

Usar una llamada simple para ver argumentos en `x0`-`x7`, retorno en `x0` y la
diferencia entre calling convention y syscall convention.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`_start` prepara dos argumentos en `x0` y `x1`, llama a `sumar_abi`, recibe el
retorno en `x0` y solo despues usa `x8` para seleccionar la syscall `exit`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/01_abi_aapcs64_registros run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/01_abi_aapcs64_registros run
echo $?
```

## Depurar

```gdb
break sumar_abi
continue
info registers x0 x1 x8 x30 pc
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `x0` y `x1` son argumentos para una funcion normal.
- `x0` tambien es el registro de retorno.
- `x8` no selecciona una funcion C; aqui solo se usa para la syscall final.

## Cambios Sugeridos

1. Cambia los argumentos `19` y `23`.
2. Agrega un tercer argumento en `x2`.
3. Inspecciona `x30` despues de ejecutar `bl`.
