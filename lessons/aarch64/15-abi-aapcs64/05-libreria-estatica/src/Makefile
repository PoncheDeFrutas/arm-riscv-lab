CC      = aarch64-linux-gnu-gcc
AR      = aarch64-linux-gnu-ar
QEMU    = qemu-aarch64
SYSROOT = /usr/aarch64-linux-gnu

BUILD   = build
BIN     = $(BUILD)/app
LIB     = $(BUILD)/libu15.a

CFLAGS  = -g -Wall -Wextra

.PHONY: all run clean info

all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/mul.o: mul.s | $(BUILD)
	$(CC) $(CFLAGS) -c mul.s -o $@

$(LIB): $(BUILD)/mul.o
	$(AR) rcs $@ $<

$(BUILD)/main.o: main.c | $(BUILD)
	$(CC) $(CFLAGS) -c main.c -o $@

$(BIN): $(BUILD)/main.o $(LIB)
	$(CC) $(BUILD)/main.o -L$(BUILD) -lu15 -o $@

run: $(BIN)
	$(QEMU) -L $(SYSROOT) $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets disponibles:"
	@echo "  make       -> crea libu15.a y enlaza app"
	@echo "  make run   -> ejecuta con QEMU user mode"
	@echo "  make clean -> limpia build/"

