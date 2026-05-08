CC      = aarch64-linux-gnu-gcc
QEMU    = qemu-aarch64
SYSROOT = /usr/aarch64-linux-gnu

BUILD   = build
BIN     = $(BUILD)/app

CFLAGS  = -g -Wall -Wextra

.PHONY: all run clean info

all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(BIN): main.c sumar.s | $(BUILD)
	$(CC) $(CFLAGS) main.c sumar.s -o $@

run: $(BIN)
	$(QEMU) -L $(SYSROOT) $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets disponibles:"
	@echo "  make       -> compila C + assembly con GCC"
	@echo "  make run   -> ejecuta con QEMU user mode"
	@echo "  make clean -> limpia build/"

