# 14.5 · Descriptores

## Objetivo

Usar un descriptor propio como metadata para operar un recurso o bloque sin
pasar varios argumentos sueltos.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El descriptor guarda fd, puntero, longitud y estado. La funcion
`write_descriptor` recibe el descriptor en `x0` y usa sus campos para llamar a
`write`.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/05_descriptores run
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/05_descriptores run
```

## Depurar

```gdb
break write_descriptor
continue
info registers x0 x1 x2 x3 x8 pc
x/4gx &stdout_desc
stepi
```

## Salida Esperada

```text
descriptor propio
```

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: `write` retorno error negativo. |

## Que Observar

- El descriptor no es el mensaje; apunta al mensaje y describe como usarlo.
- El fd del kernel es un campo dentro del descriptor propio.
- La funcion recibe un solo puntero y carga todo lo que necesita.

## Cambios Sugeridos

1. Cambia el fd a `2` para escribir en stderr.
2. Cambia la longitud y observa si se corta el mensaje.
3. Agrega un campo de estado y validalo antes de escribir.
