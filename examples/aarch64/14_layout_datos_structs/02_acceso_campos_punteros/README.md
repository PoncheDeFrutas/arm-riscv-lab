# 14.2 · Acceso A Campos Con Punteros

## Objetivo

Leer y escribir campos usando direccion base, offset y tamano de acceso
correcto.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

Se crea un array de dos `Point`. El programa calcula la direccion del segundo
elemento con `base + POINT_SIZE`, escribe sus campos y llama a una funcion que
recibe ese puntero.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/02_acceso_campos_punteros run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/02_acceso_campos_punteros run
echo $?
```

## Depurar

```gdb
break sumar_point
continue
info registers x0 x1 x2 x3 pc
x/6gx &points
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `27`.

## Que Observar

- El puntero al segundo elemento es `points + 1 * POINT_SIZE`.
- `ldr xN` lee 8 bytes porque los campos son `.quad`.
- Usar `ldrb` aqui leeria solo un byte del campo.

## Cambios Sugeridos

1. Cambia el segundo punto a otros valores.
2. Llama la funcion con el primer punto.
3. Cambia `POINT_SIZE` incorrectamente y observa el efecto en GDB.
