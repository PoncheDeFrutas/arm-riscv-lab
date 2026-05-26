# 15.5 · Assembly Llamado Desde C

## Objetivo

Exportar una funcion assembly para que C la llame con un prototipo `extern`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.c` o `src/sumar.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

C declara `extern long sumar(long, long)`. Assembly exporta el simbolo `sumar`,
lee `x0` y `x1`, y retorna el resultado en `x0`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=15_abi_aapcs64/05_assembly_desde_c run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=15_abi_aapcs64/05_assembly_desde_c run
```

## Depurar

```gdb
break main
break sumar
continue
info registers x0 x1 x30 pc
stepi
```

## Salida Esperada

```text
resultado = 42
```

## Que Observar

- El nombre del prototipo C coincide con el simbolo assembly.
- C coloca argumentos en `x0` y `x1`.
- `.type` y `.size` ayudan a herramientas porque `sumar` se exporta como funcion.

## Cambios Sugeridos

1. Cambia los argumentos en `main.c`.
2. Cambia el nombre del simbolo y observa el error del linker.
3. Usa `nm` para ver el simbolo `sumar`.
