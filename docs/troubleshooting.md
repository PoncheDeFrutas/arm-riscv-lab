# Troubleshooting

## Problemas comunes

### La toolchain no está instalada

Verifica que tengas instalados los paquetes necesarios:

```bash
aarch64-linux-gnu-gcc --version
qemu-aarch64 --version
```

Si no están instalados, sigue la guía de [setup](setup.md).

### Error al ejecutar make

- Confirma que estás dentro de `src/` antes de ejecutar `make`
- Usa `make clean` si hay residuos en `build/`

### GDB no conecta

- Si `make gdb` no conecta, revisa que el puerto 1234 esté libre
- Verifica que `gdb-multiarch` esté instalado

### Problemas con QEMU

- Asegúrate de que el binario sea realmente AArch64: `file <binario>`
- Si usas x86_64, necesitas QEMU user-mode: `qemu-aarch64`

## Dónde buscar ayuda

1. Lee primero `site/guides/troubleshooting.qmd`
2. Revisa las guías en `site/guides/`
3. Consulta este documento para problemas comunes
