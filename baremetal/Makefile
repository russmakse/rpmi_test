CROSS_COMPILE ?= riscv64-unknown-elf-
TARGET      = baremetal.elf
BIN         = baremetal.bin
AS          = $(CROSS_COMPILE)as
CC          = $(CROSS_COMPILE)gcc
LD          = $(CROSS_COMPILE)ld
OBJCOPY     = $(CROSS_COMPILE)objcopy
OBJDUMP     = $(CROSS_COMPILE)objdump
GDB         = $(CROSS_COMPILE)gdb
CFLAGS      = -g -O0 -march=rv64imac -mabi=lp64 -nostdlib -I. -MMD
LDFLAGS     = -T baremetal.ld
SOURCES_ASM = baremetal.S
SOURCES_C   = 
OBJECTS     = $(addprefix build/, $(SOURCES_ASM:.S=.o)) $(addprefix build/, $(SOURCES_C:.c=.o))
DEPS        = $(OBJECTS:.o=.d)
BUILD_DIR   = build


all: clean $(BUILD_DIR)/$(BIN)

$(BUILD_DIR)/$(BIN): $(BUILD_DIR)/$(TARGET)
	$(OBJCOPY) -O binary $< $@

$(BUILD_DIR)/$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
	$(OBJDUMP) -D $@ > $@.disasm  


$(BUILD_DIR)/%.o: %.S | $(BUILD_DIR)
	$(AS) -g -o $@ $<


$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<


-include $(DEPS)


$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)


.PHONY: all clean