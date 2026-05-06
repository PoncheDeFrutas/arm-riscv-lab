# Flujo principal: x86_64 + QEMU user mode.
# Desde la carpeta del ejemplo usa: make -C src
# En Raspberry Pi ARM64 real usa: make -C src -f Makefile.arm64

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
	@echo "Desde la carpeta del ejemplo:"
	@echo "  make -C src"
	@echo "  make -C src run"
	@echo "  make -C src gdb"
	@echo "Raspberry Pi ARM64: make -C src -f Makefile.arm64 run"
