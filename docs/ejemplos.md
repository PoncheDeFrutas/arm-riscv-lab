# Ejecutar Ejemplos

## Flujo de ejecución

Cuando los ejemplos ejecutables estén disponibles, el flujo recomendado será:

```bash
cd <carpeta-del-ejemplo>/src
make
make run
make gdb
```

Cada ejemplo deberá incluir instrucciones propias. Si un ejemplo no tiene `Makefile`, se podrán usar las plantillas de `tooling/make/makefile-templates/`.

Este flujo todavía depende de que los ejemplos se vayan agregando a `examples/` o `projects/`.

## Qué debe incluir cada ejemplo

Cada ejemplo en `examples/` o `projects/` deberá indicar:

- Qué hace el programa
- Cómo compilarlo
- Cómo ejecutarlo
- Qué salida esperar
- Qué observar con herramientas como GDB, `objdump`, `readelf` o `strace`

## Flujo de estudio recomendado

1. **Leer**: entender la idea principal en la unidad
2. **Ejecutar**: correr el ejemplo cuando exista
3. **Inspeccionar**: usar `objdump`, `readelf`, `strace` o GDB según la lección
4. **Modificar**: cambiar registros, valores o mensajes
5. **Depurar**: observar registros y memoria paso a paso
6. **Explicar**: describir qué hace el programa
7. **Practicar**: resolver ejercicios cuando existan
