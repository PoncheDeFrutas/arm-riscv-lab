USE_LIBC = 1
S_SRCS =
C_SRCS = $(SRC_DIR)/main.c
EXTRA_DEPS = $(BUILD)/liboperaciones.a
LDLIBS = $(BUILD)/liboperaciones.a

$(BUILD)/operaciones.o: $(SRC_DIR)/operaciones.s | $(BUILD)
	$(CC) $(ASFLAGS) -I"$(SRC_DIR)" -c -o "$@" "$<"

$(BUILD)/liboperaciones.a: $(BUILD)/operaciones.o
	$(AR) rcs "$@" "$<"
