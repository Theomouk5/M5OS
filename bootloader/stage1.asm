[BITS 16]
[ORG 0x7C00]

BOOT_DISK equ 0x800

mov [BOOT_DISK], dl

mov sp, 0x4000
mov bp, 0x4000

mov ah, 0
mov al, 0x2
int 10h

mov ah, 0x2
mov al, 0x1
mov ch, 0
mov cl, 0x2
mov dh, 0
mov dl, [BOOT_DISK]
mov bx, 0x8000
int 13h
jb read_error

jmp 0x0000:0x8000

read_error:
    mov si, disk_error
    call error
    jmp $

%include "bootloader/print.asm"

disk_error: db "Cannot read disk : Bootloader", 13, 10, 0

times 510 - ($ - $$) db 0
dw 0xAA55
