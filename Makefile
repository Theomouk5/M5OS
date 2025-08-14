all: bootloader/stage1.asm
	mkdir -p bin
	nasm -f bin $< -o bin/stage1.bin

run: bin/stage1.bin
	qemu-system-i386 -drive format=raw,file=$<

debug: bin/stage1.bin
	qemu-system-i386 -drive format=raw,file=$<
