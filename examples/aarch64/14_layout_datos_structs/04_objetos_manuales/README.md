# 14.4 · Objetos Manuales

## Objetivo

Modelar un objeto como bloque de memoria con constructor, metodo, destructor y
`self` en `x0`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

El objeto `Counter` tiene `value` y `alive`. Se inicializa con `30`, se le suma
`12`, se guarda el resultado y luego se destruye limpiando su estado.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=14_layout_datos_structs/04_objetos_manuales run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=14_layout_datos_structs/04_objetos_manuales run
echo $?
```

## Depurar

```gdb
break counter_init
break counter_add
break counter_destroy
continue
info registers x0 x1 x2 x19 pc
x/4gx &counter
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `42`.

## Que Observar

- `self` es solo un puntero al bloque del objeto.
- El constructor deja el objeto en estado valido.
- El destructor limpia estado, pero el programa guarda el resultado antes.

## Cambios Sugeridos

1. Cambia el valor inicial.
2. Cambia el delta del metodo.
3. Intenta llamar `counter_add` despues del destructor y agrega una validacion.
