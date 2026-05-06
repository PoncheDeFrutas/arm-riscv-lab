# Flujo principal: x86_64 + QEMU user mode.
# Flujo principal: x86_64 + QEMU user mode.
# En Raspberry Pi ARM64 real copia un template ARM64 como Makefile.

AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld
QEMU    = qemu-aarch64

SRC     = main.s
BUILD   = build
OBJ     = $(BUILD)/main.o
BIN     = $(BUILD)/main

ASFLAGS = -g
LDFLAGS =

.PHONY: all run gdb clean info

all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(OBJ): $(SRC) | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $<

run: $(BIN)
	$(QEMU) $(BIN)

gdb: $(BIN)
	@echo "Starting QEMU and waiting for GDB on port 1234..."
	$(QEMU) -g 1234 -singlestep $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Flujo: x86_64 + QEMU user mode"
	@echo "Targets disponibles:"
	@echo "  make        -> ensambla y enlaza"
	@echo "  make run    -> ejecuta con QEMU"
	@echo "  make gdb    -> QEMU + espera GDB en localhost:1234"
	@echo "  make clean  -> limpia build/"
