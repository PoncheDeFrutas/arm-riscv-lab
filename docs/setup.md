# Setup e Instalación

## Herramientas necesarias

Los comandos siguientes están pensados para sistemas basados en Debian/Ubuntu. Si usas otra distribución, instala los paquetes equivalentes con tu gestor de paquetes.

### Ruta recomendada: x86_64 con QEMU

```bash
sudo apt update
sudo apt install -y make gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu qemu-user gdb-multiarch file strace
```

Esto incluye `objdump`, `readelf` y `nm` (vienen en binutils).

### Ruta ARM64 nativa

```bash
sudo apt update
sudo apt install -y make gcc binutils gdb file strace
```

### Verificación rápida

```bash
aarch64-linux-gnu-gcc --version
qemu-aarch64 --version
gdb-multiarch --version
```

### Opcional (solo si quieres ver el sitio localmente)

- Quarto
- Node.js + pnpm (para Slidev cuando haya decks)

## Si estás usando una computadora x86_64

Usa QEMU user-mode para ejecutar binarios AArch64. No necesitas hardware ARM para comenzar.

## Si estás usando una computadora ARM64

Puedes ejecutar binarios nativamente. Usa los templates `Makefile.arm64.*` para compilar y depurar sin QEMU.
