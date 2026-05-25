# Examples

Ejemplos ejecutables del laboratorio.

La ruta AArch64 usa `examples/aarch64` como workspace de ejemplos. Abre esa
carpeta en VS Code para usar sus Makefiles compartidos y su configuracion de
debugging.

```bash
cd examples/aarch64
make -f Makefile.qemu EXAMPLE=05_primeros_programas/01_programa_minimo_exit run
```
