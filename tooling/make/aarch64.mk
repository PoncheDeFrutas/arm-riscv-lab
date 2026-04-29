RUN_MODE ?= qemu
BUILD_DIR ?= build
TARGET ?= $(BUILD_DIR)/main
SRC ?= main.s

AARCH64_CC ?= aarch64-linux-gnu-gcc
NATIVE_CC ?= gcc
QEMU ?= qemu-aarch64
GDB_MULTIARCH ?= gdb-multiarch
GDB_NATIVE ?= gdb
GDB_PORT ?= 1234
UNAME_M := $(shell uname -m)

ASFLAGS ?= -g
LDFLAGS ?= -nostdlib -static

ifeq ($(RUN_MODE),native)
CC_FOR_TARGET := $(NATIVE_CC)
RUN_CMD := ./$(TARGET)
GDB_CMD := $(GDB_NATIVE) ./$(TARGET)
else ifeq ($(RUN_MODE),qemu)
CC_FOR_TARGET := $(AARCH64_CC)
RUN_CMD := $(QEMU) ./$(TARGET)
GDB_CMD := $(QEMU) -g $(GDB_PORT) ./$(TARGET)
else
$(error RUN_MODE must be qemu or native)
endif

.PHONY: all run gdb clean info check-compiler

all: $(TARGET)

check-compiler:
	@if [ "$(RUN_MODE)" = "native" ] && [ "$(UNAME_M)" != "aarch64" ] && [ "$(UNAME_M)" != "arm64" ]; then \
		echo "error: RUN_MODE=native requires an AArch64 host; detected $(UNAME_M)"; \
		echo "Use the default QEMU mode on x86_64."; \
		exit 2; \
	fi
	@command -v $(CC_FOR_TARGET) >/dev/null 2>&1 || { \
		echo "error: compiler '$(CC_FOR_TARGET)' not found"; \
		echo "For x86_64/QEMU install gcc-aarch64-linux-gnu or use Docker."; \
		echo "For ARM native run: make RUN_MODE=native"; \
		exit 127; \
	}

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET): $(SRC) check-compiler | $(BUILD_DIR)
	$(CC_FOR_TARGET) $(ASFLAGS) $(LDFLAGS) -o $@ $<

run: $(TARGET)
	$(RUN_CMD)

gdb: $(TARGET)
	$(GDB_CMD)

info:
	@echo "RUN_MODE=$(RUN_MODE)"
	@echo "CC_FOR_TARGET=$(CC_FOR_TARGET)"
	@echo "TARGET=$(TARGET)"

clean:
	rm -rf $(BUILD_DIR)
