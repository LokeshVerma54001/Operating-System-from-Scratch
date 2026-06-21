BUILD = build

STAGE1 = boot/stage1.asm
STAGE2 = boot/stage2.asm

STAGE1_BIN = $(BUILD)/stage1.bin
STAGE2_BIN = $(BUILD)/stage2.bin

DISK = $(BUILD)/disk.img

all: $(DISK)

$(BUILD):
	mkdir -p $(BUILD)

$(STAGE1_BIN): $(STAGE1) | $(BUILD)
	nasm -f bin $< -o $@

$(STAGE2_BIN): $(STAGE2) | $(BUILD)
	nasm -f bin $< -o $@

$(DISK): $(STAGE1_BIN) $(STAGE2_BIN)
	dd if=/dev/zero of=$(DISK) bs=512 count=2880
	dd if=$(STAGE1_BIN) of=$(DISK) conv=notrunc
	dd if=$(STAGE2_BIN) of=$(DISK) bs=512 seek=1 conv=notrunc

run: all
	qemu-system-i386 -fda $(DISK)

clean:
	rm -rf $(BUILD)