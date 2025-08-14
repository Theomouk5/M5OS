all: bootloader/stage1.asm bootloader/stage2.asm kernel/entry.asm kernel/kernel.c linker.ld
	mkdir -p bin
	mkdir -p build
	nasm -f bin bootloader/stage1.asm -o bin/stage1.bin
	nasm -f bin bootloader/stage2.asm -o bin/stage2.bin
	nasm -f elf32 kernel/entry.asm -o build/entry.o
	gcc -m32 -fno-pic -fno-pie -ffreestanding -c kernel/kernel.c -o build/kernel.o
	i386-elf-ld -T linker.ld build/entry.o build/kernel.o -o bin/kernel.bin --oformat binary
	dd if=/dev/zero of=bin/os.bin bs=512 count=2880
	dd if=bin/stage1.bin of=bin/os.bin bs=512 count=1 conv=notrunc
	dd if=bin/stage2.bin of=bin/os.bin bs=512 seek=1 conv=notrunc
	dd if=bin/kernel.bin of=bin/os.bin bs=512 seek=2 conv=notrunc

run: all
	qemu-system-i386 -drive format=raw,file=bin/os.bin

debug: all
	qemu-system-i386 -drive format=raw,file=bin/os.bin

clean:
	rm -rf build bin
