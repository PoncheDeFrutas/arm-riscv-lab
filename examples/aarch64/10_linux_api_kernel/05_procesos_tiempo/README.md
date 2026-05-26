# 10.5 · Procesos Y Tiempo

## Objetivo

Usar syscalls que no son de archivo: `getpid`, `clock_gettime` y `nanosleep`.

## Antes De Empezar

- Abre `examples/aarch64` como workspace si vas a usar VS Code.
- Abre `src/main.s` antes de presionar F5.
- Ejecuta los comandos desde `examples/aarch64`.

## Idea Del Programa

`getpid` no recibe argumentos y devuelve el PID en `x0`. `clock_gettime` y
`nanosleep` usan punteros a estructuras `timespec` de 16 bytes.

## Ejecutar Con QEMU

```bash
make -f Makefile.qemu EXAMPLE=10_linux_api_kernel/05_procesos_tiempo run
echo $?
```

## Ejecutar En ARM64 Nativo

```bash
make -f Makefile.native EXAMPLE=10_linux_api_kernel/05_procesos_tiempo run
echo $?
```

## Depurar

```gdb
break _start
continue
info registers x0 x1 x8 x19 pc
x/2gd &now
stepi
```

## Salida Esperada

No imprime texto. Termina con codigo `0`.

## Condiciones Usadas

| Condicion | Donde aparece | Significado |
|---|---|---|
| `lt` | `b.lt error` | Less than signed: salta si una syscall de tiempo devuelve error negativo. |

## Que Observar

- `x19` conserva el PID solo para inspeccion.
- `clock_gettime` escribe dos enteros de 64 bits en `now`.
- `nanosleep` recibe direccion de `req`, no un numero directo de segundos.

## Cambios Sugeridos

1. Cambia los nanosegundos de `req`.
2. Cambia `CLOCK_MONOTONIC` por otro reloj valido.
3. Observa `now` antes y despues de `clock_gettime`.
