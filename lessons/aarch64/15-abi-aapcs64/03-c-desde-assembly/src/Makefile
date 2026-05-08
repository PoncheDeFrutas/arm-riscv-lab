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

$(BIN): main.s funcion.c | $(BUILD)
	$(CC) $(CFLAGS) main.s funcion.c -o $@

run: $(BIN)
	$(QEMU) -L $(SYSROOT) $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets disponibles:"
	@echo "  make       -> compila assembly + C con GCC"
	@echo "  make run   -> ejecuta con QEMU user mode"
	@echo "  make clean -> limpia build/"

