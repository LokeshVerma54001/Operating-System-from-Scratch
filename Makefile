all:
	nasm -f bin boot/boot.asm -o build/os.bin

run: all
	qemu-system-i386 -drive format=raw,file=build/os.bin

clean:
	rm -f build/os.bin