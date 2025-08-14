[BITS 16]
[ORG 0x8000]

KERNEL_LOCATION equ 0x10000

CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start

mov ah, 0x2
mov al, 0x1
mov ch, 0
mov cl, 0x3
mov dh, 0
mov dl, [0x800]
mov bx, KERNEL_LOCATION >> 4
int 13h
jb read_error

in al, 0x92
or al, 0b00000010
out 0x92, al
cli

lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

read_error:
    mov si, disk_error
    call error
    jmp $

%include "bootloader/print.asm"

GDT_start:
    GDT_null:
        dd 0
        dd 0
    GDT_code:
        dw 0xFFFF
        dw 0
        db 0
        db 0b10011011
        db 0b11001111
        db 0
    GDT_data:
        dw 0xFFFF
        dw 0
        db 0
        db 0b10010011
        db 0b11001111
        db 0
GDT_end:

GDT_descriptor:
    dw GDT_end - GDT_start - 1
    dd GDT_start

[BITS 32]
start_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    jmp KERNEL_LOCATION >> 4

jmp $

disk_error: db "Cannot read disk : Kernel", 13, 10, 0
