all: boot/asm/boot.asm
	nasm -f bin boot/asm/boot.asm -o bin/boot

run: all
	qemu-system-i386 -m 512M -hda bin/boot
