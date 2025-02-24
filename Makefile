SUBDIRS = bootloader baremetal

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

run: $(BUILD_DIR)/$(TARGET)
	@qemu-system-riscv64 -M virt,rpmi=on -smp cpus=2 -m 1G -nographic -serial pty -serial pty \
	-device loader,file=../opensbi/build/platform/generic/firmware/fw_payload.bin,addr=0x80200000 \
	-device loader,file=./bootloader/build/bootloader.bin,addr=0x80000000 \
	-device loader,file=../zephyr/build/zephyr/zephyr.bin,addr=0x80001000


debug: $(BUILD_DIR)/$(TARGET)
	@qemu-system-riscv64 -M virt,rpmi=on -smp cpus=2 -m 1G -nographic -serial pty -serial pty -d guest_errors \
	-device loader,file=../opensbi/build/platform/generic/firmware/fw_payload.bin,addr=0x80200000 \
	-device loader,file=./bootloader/build/bootloader.bin,addr=0x80000000 \
	-device loader,file=../zephyr/build/zephyr/zephyr.bin,addr=0x80001000 -s -S

.PHONY: all clean run debug $(SUBDIRS)