all: bootloader/stage1.asm bootloader/stage2.asm
	mkdir -p bin
	nasm -f bin bootloader/stage1.asm -o bin/stage1.bin
	nasm -f bin bootloader/stage2.asm -o bin/stage2.bin
	dd if=/dev/zero of=bin/bootloader.bin bs=512 count=2880
	dd if=bin/stage1.bin of=bin/bootloader.bin bs=512 count=1 conv=notrunc
	dd if=bin/stage2.bin of=bin/bootloader.bin bs=512 seek=1 conv=notrunc

run: bin/bootloader.bin
	qemu-system-i386 -drive format=raw,file=$<

debug: bin/bootloader.bin
	qemu-system-i386 -drive format=raw,file=$<
