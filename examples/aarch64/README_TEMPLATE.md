# XX · Titulo Del Ejemplo

## Objetivo

Describe en dos o tres lineas que idea concreta demuestra este ejemplo y con que
leccion del curso se conecta.

## Idea Del Programa

Explica el flujo del programa en lenguaje natural antes de mostrar comandos.
En assembly conviene decir que registros importan, que secciones aparecen y que
resultado debe observar el estudiante.

## Archivos

```text
XX_unidad/YY_nombre_ejemplo/
|- README.md
`- src/
   `- main.s
```

## Ejecutar Con QEMU

Desde `examples/aarch64`:

```bash
make -f Makefile.qemu EXAMPLE=XX_unidad/YY_nombre_ejemplo run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=XX_unidad/YY_nombre_ejemplo run
```

## Depurar

Abre `src/main.s` en VS Code y usa:

- `Debug ARM64 QEMU - archivo activo`, si estas en x86_64 con QEMU.
- `Debug ARM64 nativo - archivo activo`, si estas en Linux ARM64 real.

## Salida Esperada

```text
<salida o codigo de salida esperado>
```

## Que Observar

- Registro o memoria importante 1.
- Registro o memoria importante 2.
- Instruccion donde conviene poner breakpoint.

## Errores Comunes

- Error frecuente y como detectarlo.
- Error frecuente y como corregirlo.

## Cambios Sugeridos

1. Cambio pequeno para comprobar comprension.
2. Variante que altere un registro, dato o salto.
3. Reto corto conectado con la siguiente leccion.
