CC      = aarch64-linux-gnu-gcc
QEMU    = qemu-aarch64
SYSROOT = /usr/aarch64-linux-gnu

BUILD   = build
BIN     = $(BUILD)/app
LIB     = $(BUILD)/libu15shared.so

CFLAGS  = -g -Wall -Wextra

.PHONY: all run clean info

all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/triple.o: triple.s | $(BUILD)
	$(CC) $(CFLAGS) -fPIC -c triple.s -o $@

$(LIB): $(BUILD)/triple.o
	$(CC) -shared -o $@ $<

$(BUILD)/main.o: main.c | $(BUILD)
	$(CC) $(CFLAGS) -c main.c -o $@

$(BIN): $(BUILD)/main.o $(LIB)
	$(CC) $(BUILD)/main.o -L$(BUILD) -Wl,-rpath,'$$ORIGIN' -lu15shared -o $@

run: $(BIN)
	$(QEMU) -L $(SYSROOT) $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets disponibles:"
	@echo "  make       -> crea libu15shared.so y enlaza app"
	@echo "  make run   -> ejecuta con QEMU user mode"
	@echo "  make clean -> limpia build/"

